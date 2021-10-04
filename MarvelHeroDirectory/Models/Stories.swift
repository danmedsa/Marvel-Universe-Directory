//
//  Stories.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/3/21.
//

import Foundation

struct Stories: Codable {
    var available: Int
    var items: [StoryItem]
}
