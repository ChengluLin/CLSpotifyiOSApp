//
//  LibaryAlbumsResponse.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/5/21.
//

import Foundation

struct LibaryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
 
