//
//  AllCategriesResponse.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/4/29.
//

import Foundation

struct AllcategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
