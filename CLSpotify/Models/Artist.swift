//
//  Artist.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/3/30.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}

