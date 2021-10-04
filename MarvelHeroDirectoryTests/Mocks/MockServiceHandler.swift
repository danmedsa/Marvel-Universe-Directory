//
//  MockServiceHandler.swift
//  MarvelHeroDirectoryTests
//
//  Created by Daniel Medina Sada on 10/4/21.
//

import Foundation
@testable import MarvelHeroDirectory

class MockServiceHandler: ServiceHandling {
    var sendResponseError: ServiceError?
    func fetchHeroList(text: String?, page: Int, completionHandler: @escaping HeroListResponse) {
        if let error = sendResponseError {
            completionHandler(.failure(error))
        } else {
            if let path = Bundle.main.path(forResource: "CharactersMockData", ofType:".json") {
                let urlPath = URL(fileURLWithPath: path)
                if let data = try? Data(contentsOf: urlPath),
                   let characterList = try? JSONDecoder().decode(CharacterList.self, from: data) {
                    completionHandler(.success(characterList))
                }
            }
        }
    }
    
    
}
