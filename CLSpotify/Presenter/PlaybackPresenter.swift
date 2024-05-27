//
//  PlaybackPresenter.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/5/5.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get}
}

final class PlaybackPresenter {
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if/* let player = self.playerQueue,*/ !tracks.isEmpty {
//            let item = player.currentItem
//            let items = player.items()
//            guard let index = items.firstIndex(where: { $0 == item }) else {
//                return nil
//            }
            return tracks[index]
        }
        return nil
    }
    
    var playerVC: PlayerViewController?
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
//        print("track:::::", track)
        guard let url = URL(string: track.preview_url ?? "") else {
            print("track.preview_url = nil")
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController(type: .single)
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        self.index = 0
        self.tracks = tracks
        self.track = nil
        
        guard let url = URL(string: tracks.first?.preview_url ?? "") else {
            print("track.preview_url = nil")
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5

//        self.playerQueue = AVQueuePlayer(items:  tracks.compactMap {
//            guard let url = URL(string: $0.preview_url ?? "") else {
//                return nil
//            }
//            return AVPlayerItem(url: url)
//        })
//        self.playerQueue?.volume = 0.5
//        self.playerQueue?.play()
        
        let vc = PlayerViewController(type: .many)
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
}

extension PlaybackPresenter: PlayerViewControllerDelegate{
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
        }
        else if !tracks.isEmpty {
            //            playerQueue?.advanceToNextItem()
            print("indexx::", index)
            print("tracks.count::", tracks.count)

            if index >= (self.tracks.count-1) {
                return
            }
            index += 1
            
            guard let url = URL(string: tracks[index].preview_url ?? "") else {
                print("track.preview_url = nil")
                return
            }
            
            player = AVPlayer(url: url)
            player?.play()
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
            player?.play()
        }
        else if !tracks.isEmpty {
            if index <= 0 {
                return
            } else {
                index -= 1
            }
            guard let url = URL(string: tracks[index].preview_url ?? "") else {
                print("track.preview_url = nil")
                return
            }
            
            player = AVPlayer(url: url)
            player?.play()
            playerVC?.refreshUI()
            print("tracks index url:::", tracks[index].preview_url)
            

        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
    
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
//        print(currentTrack?.album?.images.first?.url ?? "nil")
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    
}
