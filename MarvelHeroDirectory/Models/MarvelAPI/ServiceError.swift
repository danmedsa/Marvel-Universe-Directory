//
//  ServiceError.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/1/21.
//

import Foundation

struct ErrorResponse: Decodable {
    var code: String
    var message: String
}
