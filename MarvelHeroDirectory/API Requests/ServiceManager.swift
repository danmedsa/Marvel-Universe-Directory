//
//  ServiceManager.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/29/21.
//

import Foundation

protocol ServiceManaging {
    func makeGetHerosCall(text: String?, page: Int, completionHandler: @escaping ServiceResponse)
}

/// Manages the Calls made to the Marvel API
struct ServiceManager: ServiceManaging {
    
    ///Makes call to the /characters endpoint of MarvelAPI
    func makeGetHerosCall(text: String?, page: Int, completionHandler: @escaping ServiceResponse) {
        do {
            let urlPath = try MarvelAPI.getMarvelURL(endpoint: .characters, page: page, with: text)
            
            if !isASearch(text: text) {
                if let responseData = CacheManager.loadCachedResponse(from: urlPath) {
                    completionHandler(responseData,nil,nil)
                    return
                }
            }
            
            guard let url = URL(string: urlPath) else {
                completionHandler(nil,nil,ServiceError.urlMalformation)
                return
            }
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
                
                if let error = error {
                    let serviceError = isASearch(text: text) ? ServiceError.searchUnavailable : error
                    completionHandler(data,response,serviceError)
                }
                completionHandler(data,response,error)
                
                // Dont cache response if its a search
                if let responseData = data, !isASearch(text: text) {
                    CacheManager.cacheResponse(responseData, url: urlPath)
                }
            }
            task.resume()
        } catch {
            completionHandler(nil,nil,SecurityError.privateKeyNotFound)
        }
    }
    
    private func isASearch(text: String?) -> Bool {
        return !(text == nil || (text ?? "").isEmpty)
    }
}
