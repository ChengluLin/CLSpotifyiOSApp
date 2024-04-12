//
//  Playlist.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/3/30.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
