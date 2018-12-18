//
//  MainViewModel.swift
//  TTD
//
//  Created by Catharina Herchert on 06.09.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The default user name key
    static let userDefaultNameKey = "ttd_user_name"
    
    /// The localized key for user
    static let userLocalizedNameKey = "MVM_unknown_user_name".localized
    
}

struct MainViewModel {
    
    private let defaults = UserDefaults.standard
    
    /// Saves the user name to user defaults
    ///
    /// - Parameter name: The name of the user
    func saveUserName (_ name: String) {
        defaults.set(name, forKey: Constants.userDefaultNameKey)
    }
    
    /// Returns the saved user name
    ///
    /// - Returns: The user name
    func getUserName () -> String {
        guard let userName = defaults.value(forKey: Constants.userDefaultNameKey) as? String else {
            return Constants.userLocalizedNameKey
        }
        
        return userName
    }
    
    // Date
    
    /// A date formatter (September 20, 2017)
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter
    }
    
    /// The current date formatted as MMMM dd, YYYY
    var currentFormattedDate: String {
        return dateFormatter.string(from: Date())
    }
}
