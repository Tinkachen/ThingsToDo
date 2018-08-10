//
//  PasscodeViewModel.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The passcode type enum
///
/// - new: For entering a new passcode
/// - verify: For verifing the passcode
/// - verifyNew: For verifing the new passcode
enum PasscodeType {
    case new
    case verify
    case verifyNew
}

// The view model for setting or entering a passcode
struct PasscodeViewModel {
    
    /// The passcode
    var passcode: String!
    
    /// The passcode type
    var passcodeType: PasscodeType!
    
    /// Initializes the passcode view model with a passcode
    ///
    /// - Parameter passcode: The passcode
    mutating func initWithPasscode (_ passcode: String) {
        self.passcodeType = .verify
    }
    
    /// Initialzes the passcode view model for a new passocde
    mutating func initWithNewPasscode() {
        self.passcodeType = .new
    }
    
    /// The first passcode that had been set - it is temporary
    var temporaryNewPasscode: String?
}
