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
    static let useFallbackString = "BS_authentication_fallback".localized
}

struct BiometricService {
    
    private static let localAuthenticationContext = LAContext()
    
    
}
