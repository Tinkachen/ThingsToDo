//
//  BiometricService.swift
//  TTD
//
//  Created by Catharina Herchert on 13.12.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import LocalAuthentication

/// Private constants
private enum Constants {
    
    /// String for using the fallback
    static let useFallbackLocalizedString = "BS_authentication_fallback".localized
}

// #TODO
/// The biometric service
struct BiometricService {
    
    /// The local authentication context
    private static let localAuthenticationContext = LAContext()
    
    
}
