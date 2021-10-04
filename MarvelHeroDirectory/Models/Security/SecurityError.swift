//
//  SecurityError.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/2/21.
//

import Foundation

enum SecurityError: Error {
    case privateKeyNotFound
    case plistFileNotFound
    case hashDataError
}
