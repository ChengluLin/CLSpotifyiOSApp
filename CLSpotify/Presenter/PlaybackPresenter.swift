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
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if !tracks.isEmpty {
            return tracks.first
        }
        return nil
    }
    
    var player: AVPlayer?
    
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
        player?.volume = 0.2
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        self.tracks = tracks
        self.track = nil
        let vc = PlayerViewController()
        vc.dataSource = self
        viewController.present(vc, animated: true, completion: nil)
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
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
        }
        else {
            
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
            player?.play()
        }
        else {
            
        }
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
