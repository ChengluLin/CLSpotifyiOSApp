//
//  RecommendationResponse.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/4/10.
//

import Foundation

struct RecommendationResponse: Codable {
    let tracks: [AudioTrack]
}

struct AudioTrack: Codable {
    let album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
    let popularity: Int?
}
