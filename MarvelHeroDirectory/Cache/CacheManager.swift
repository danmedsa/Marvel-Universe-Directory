//
//  CacheManager.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/4/21.
//

import UIKit

struct CacheManager {
    // MARK:- Images
    static func cacheImage(_ data: Data, url: String) {
        guard let imageName = findImageName(from: url) else { return }
        cacheData(data, for: imageName)
    }
    
    private static func findImageName(from url: String) -> String? {
        let components = url.components(separatedBy: "/")
        guard components.count > 1 else { return nil }
        return "\(components[components.count-2]).jpg"
    }
    
    static func loadCachedImage(from url: String) -> UIImage? {
        guard let imageName = findImageName(from: url) else { return nil }
            let cacheDir = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            guard let imageUrl = cacheDir?.appendingPathComponent(imageName),
                  let data = FileManager.default.contents(atPath: imageUrl.path),
                  let image = UIImage(data: data)
            else { return nil }
            
            return image
    }
    
    //MARK:- Data
    private static func findResponseQuery(from url: String) -> String? {
        let urlComponents = url.components(separatedBy: "?")
        let urlParams = urlComponents.last?.components(separatedBy: "&") ?? []
        let limitParam = getParameter(name: "limit", from: urlParams) ?? ""
        let offsetParam = getParameter(name: "offset", from: urlParams) ?? ""
        return "characters-\(limitParam)&\(offsetParam).json"
    }
    
    private static func getParameter(name: String, from parameters: [String]) -> String? {
        for param in parameters {
            if param.contains(name) {
                return param
            }
        }
        return nil
    }
    
    static func cacheResponse(_ data: Data, url: String) {
        guard let responseName = findResponseQuery(from: url) else { return }
        cacheData(data, for: responseName)
    }
    
    static func loadCachedResponse(from url: String) -> Data? {
        guard let responseName = findResponseQuery(from: url) else { return nil }
        do {
            let cacheDir = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let filePath = cacheDir.appendingPathComponent(responseName)
            let data = FileManager.default.contents(atPath: filePath.path)
            
            return data
            
        } catch {
            return nil
        }
    }
    
    //MARK:- Shared
    private static func cacheData(_ data: Data, for url: String) {
        do {
            let cacheDir = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let filePath = cacheDir.appendingPathComponent(url)
            FileManager.default.createFile(atPath: filePath.path, contents: data, attributes: nil)
        } catch {
            return
        }
    }
}
