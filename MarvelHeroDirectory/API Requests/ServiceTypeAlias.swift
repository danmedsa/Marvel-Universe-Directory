//
//  ServiceTypeAlias.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/30/21.
//

import Foundation

typealias HeroListResponse = (Result<CharacterList,ServiceError>) -> ()
typealias ServiceResponse = (Data?, URLResponse?, Error?) -> ()
