//
//  FeaturedPlaylistsResponse.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/4/9.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct CategoryPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
