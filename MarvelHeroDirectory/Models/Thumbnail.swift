//
//  Thumbnail.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/3/21.
//

import Foundation

struct Thumbnail: Codable {
    var path: String
    var filetype: String
    var imagePath: String {
        MarvelAPI.getMarvelImageURL(size: .medium, thumbnail: self)
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case filetype = "extension"
    }
}
