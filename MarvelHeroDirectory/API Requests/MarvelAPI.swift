//
//  MarvelAPI.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 9/29/21.
//

import Foundation

enum Endpoint: String {
    case characters = "characters"
}

enum ImageSize: String {
    case small = "portrait_small"
    case medium = "portrait_medium"
    case large = "portrait_xlarge"
    case fantastic = "portrait_fantastic"
    case uncanny = "portrait_uncanny"
    case incredible = "portrait_incredible"
}

struct MarvelAPI {
    private static let domainURL = "gateway.marvel.com"
    private static let apiVersion = "v1"
    private static let apiPath = "public"
    private static let pubKey = "a0b503a90dfd66e931bbad8dfce48b00"
    private static let limit = 100
    private static var url: String {
        "https://\(domainURL)/\(apiVersion)/\(apiPath)/"
    }
    
    /// Generate parameters for URL Request to Marvel API
    static func getParameters(publicKey: String, page: Int) throws -> [String : String] {
        let hashParams = try Security.generateHashParameters(publicKey: pubKey)
        let params = [
            "limit": "\(limit)",
            "offset": "\(page * limit)",
            "ts": "\(hashParams.timeStamp)",
            "apikey": pubKey,
            "hash": hashParams.hash
        ]
        
        return params
    }
    
    static func getMarvelURL(endpoint: Endpoint, page: Int, with searchText: String?, publicKey: String = pubKey) throws -> String {
        let hashParameters = try getParameters(publicKey: publicKey, page: page)
        var url = "https://\(domainURL)/\(apiVersion)/\(apiPath)/\(endpoint.rawValue)?"

        for (index,(key,value)) in hashParameters.enumerated() {
            url.append("\(key)=\(value)")
            if index != hashParameters.count - 1 {
                url.append("&")
            }
        }
        
        print(url)
        guard let searchText = searchText, !searchText.isEmpty else { return url }
        let htmlSearchText = HTMLConverter.getHTMLParameterValue(text: searchText)
        return "\(url)&name=\(htmlSearchText)"
    }
    
    /// Generates URL to Fetch Image of Character
    static func getMarvelImageURL(size: ImageSize, thumbnail: Thumbnail) -> String {
        let path = thumbnail.path.replacingOccurrences(of: "http://", with: "https://")
        return "\(path)/\(size.rawValue).\(thumbnail.filetype)"
    }
}
