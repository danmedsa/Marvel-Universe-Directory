//
//  Character.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/3/21.
//

import Foundation

struct Character: Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: Thumbnail
    var comics: Comics
    var stories: Stories
    var events: Events
}
