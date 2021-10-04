//
//  CharacterListData.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/3/21.
//

import Foundation

struct CharacterListData: Codable {
    var total: Int
    var results: [Character]
}
