//
//  StringExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 20.08.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

extension String {
    
    /// To call localized strings easier
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String: Error {
    
}
