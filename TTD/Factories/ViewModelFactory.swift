//
//  ViewModelFactory.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

/// Foctory for creating view models
struct ViewModelFactory {
    
    /// Makes a passcode view model
    ///
    /// - Returns: The instance of the view model
    static func makePasscodeViewModel () -> PasscodeViewModel {
        return PasscodeViewModel()
    }
}
