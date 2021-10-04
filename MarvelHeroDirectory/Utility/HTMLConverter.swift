//
//  HTMLConverter.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/3/21.
//

import Foundation

struct HTMLConverter {
    static func getHTMLParameterValue(text: String) -> String {
        let parameterText = text.replacingOccurrences(of: " ", with: "%20")
        // Additional rules
        
        return parameterText
    }
}
