//
//  ServiceHandler.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/30/21.
//

import Foundation

protocol ServiceHandling {
    func fetchHeroList(text: String?, page: Int, completionHandler: @escaping HeroListResponse)
}

/// Handles responses from service Requests
struct ServiceHandler: ServiceHandling {
    private var serviceManager: ServiceManaging = ServiceManager()
    
    init(serviceManager: ServiceManaging? = nil) {
        if let serviceManager = serviceManager {
            self.serviceManager = serviceManager
        }
    }
    
    /// Handles response from Marvel /characters API
    func fetchHeroList(text: String?, page: Int, completionHandler: @escaping HeroListResponse) {
        serviceManager.makeGetHerosCall(text: text, page: page) { (data, response, error) in
            guard let data = data else {
                let error = error as? ServiceError
                completionHandler(.failure(error ?? .noData))
                return
            }
            
            do {
                let heroList = try JSONDecoder().decode(CharacterList.self, from: data)
                completionHandler(.success(heroList))
            } catch {
                do {
                    let error = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    print("""
                    Error response from server:
                        \(error.message)
                    """)
                    completionHandler(.failure(.requestError))
                } catch {
                    completionHandler(.failure(.decodingData))
                }
            }
        }
    }
}
