//
//  Securing.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/2/21.
//

import CryptoKit
import Foundation

protocol Securing {
    static var timeStamp : Int64 { get }
    static var securityPlistContent: Data? { get }
    static func generateHashParameters(publicKey: String) throws -> HashParameters
    static func getPrivateKey() throws -> String
}

extension Securing {
    static var timeStamp : Int64 {
        Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    static var securityPlistContent: Data? {
        guard let path = Bundle.main.path(forResource: "Security", ofType: "plist") else { return nil }
        return FileManager.default.contents(atPath: path)
    }
    
    static func generateHashParameters(publicKey: String) throws -> HashParameters {
        let ts = timeStamp
        let privateKey = try getPrivateKey()
        let hashString = "\(ts)\(privateKey)\(publicKey)"
        guard let hashData = hashString.data(using: .utf8) else { throw SecurityError.hashDataError }
        let hash = Insecure.MD5.hash(data: hashData).map({ String(format: "%02x", $0) }).joined()

        return HashParameters(timeStamp: ts,hash: hash)
    }
    
    static func getPrivateKey() throws -> String {
        guard let content = securityPlistContent else {
            throw SecurityError.plistFileNotFound
        }
        let plistDict = try PropertyListSerialization.propertyList(from: content, options: .mutableContainersAndLeaves, format: nil) as? [String:String]
        
        guard let privateKey = plistDict?["privateKey"] else {
            throw SecurityError.privateKeyNotFound
        }
        return privateKey
    }
}
