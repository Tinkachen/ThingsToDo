//
//  MainViewModel.swift
//  TTD
//
//  Created by Catharina Herchert on 06.09.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// <#Description#>
private enum Constants {
    
    /// <#Description#>
    static let userDefaultNameKey = "ttd_user_name"
    
    /// <#Description#>
    static let userLocalizedNameKey = "MVM_unknown_user_name"
    
}

struct MainViewModel {
    
    private let defaults = UserDefaults.standard
    
    /// <#Description#>
    ///
    /// - Parameter name: <#name description#>
    func saveUserName (_ name: String) {
        defaults.set(name, forKey: Constants.userDefaultNameKey)
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func getUserName () -> String {
        guard let userName = defaults.value(forKey: Constants.userDefaultNameKey) as? String else {
            return Constants.userLocalizedNameKey.localized
        }
        
        return userName
    }
}
