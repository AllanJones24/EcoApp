//
//  PhotoSetLoader.swift
//  EcoApp
//
//  Created by Allan Jones on 12/5/23.
//

import Foundation

class PhotoSetLoader {
    class func load(jsonFileName: String) -> PhotoSet? {
        var photoSet: PhotoSet?
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601

        if let jsonFileUrl = Bundle.main.url(forResource: "eco", withExtension: ".json"),
           let jsonData = try? Data(contentsOf: jsonFileUrl)
        {
            photoSet = try? jsonDecoder.decode(PhotoSet.self, from: jsonData)
        }

        print("PhotoSet: \(String(describing: photoSet))")

        return photoSet
    }
}
