//
//  PlaylistDetails.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/4/19.
//

import Foundation

struct PlaylistdetailsResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracksResponse
    
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
