//
//  SearchResult.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/5/1.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
