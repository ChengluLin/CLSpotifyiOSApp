//
//  SettingsModels.swift
//  CLSpotify
//
//  Created by ChengLu on 2024/4/4.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
