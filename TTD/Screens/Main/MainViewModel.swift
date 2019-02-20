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
    
    /// The localized key for the description text - state chill out
    static let descriptionChillOutKey = "MVM_description_chill_out".localized
    
    /// The localized key for the description text - state feels good
    static let descriptionFeelsGoodKey = "MVM_description_feels_good".localized
    
    /// The localized key for the description text - state stressy time
    static let descriptionStressyTimeKey = "MVM_description_stressy_time".localized
    
    /// The localized key for the description text (second line)
    static let descriptionTaskKey = "MVM_description_tasks"
    
    /// The human readable date format
    static let dateFormat = "MMMM dd, YYYY"
    
}

/// The main view model
struct MainViewModel {
    
    /// The user defaults
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
    
    /// Delivers the string for the description label
    ///
    /// - Parameter count: The number of tasks that have to be finsihed today
    /// - Returns: The string formatted by the value of task count
    func getDescriptionStringForTaskCount (_ count: Int) -> String {
        
        var descriptionString = ""
        
        if count == 0 {
            descriptionString = Constants.descriptionChillOutKey
        } else if count < 7 {
            descriptionString = Constants.descriptionFeelsGoodKey
        } else {
            descriptionString = Constants.descriptionStressyTimeKey
        }
        
        return "\(descriptionString)\n\(Constants.descriptionTaskKey.localizedWith([count]))"
    }
    
    // Date
    
    /// A date formatter (September 20, 2017)
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        return formatter
    }
    
    /// The current date formatted as MMMM dd, YYYY
    var currentFormattedDate: String {
        return dateFormatter.string(from: Date())
    }
}
