//
//  StringExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 20.08.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

// MARK: - String extension
extension String {
    
    /// To call localized strings easier
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Localizing string with passed elements
    ///
    /// - Parameter elements: The elements for the localized string
    /// - Returns: The localized string
    public func localizedWith (_ elements: [CVarArg]) -> String {
        return String(format: self.localized, arguments: elements)
    }
}

// MARK: - String with Error extension
extension String: Error {
    
}
