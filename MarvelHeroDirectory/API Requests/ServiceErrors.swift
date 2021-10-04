//
//  ServiceErrors.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/30/21.
//

import Foundation

enum ServiceError: Error {
    case urlMalformation
    case noData
    case requestError
    case decodingData
    case searchUnavailable
}
