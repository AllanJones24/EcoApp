//
//  PhotoSet.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import Foundation

struct PhotoSet: Codable {
    var status: String
    var photosPath: String
    var photos: [PhotoItem]

    enum CodingKeys: String, CodingKey {
        case status
        case photosPath = "photos_path"
        case photos
    }
}

struct PhotoItem: Codable, Identifiable, Hashable {
    var id = UUID()
    var imageNames: [String]
    var name: String
    var scientificName: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case imageNames = "images"
        case name
        case scientificName
        case description
    }
}
