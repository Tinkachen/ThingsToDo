//
//  Environment.swift
//  TTD
//
//  Created by Catharina Herchert on 19.12.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import UIKit

/// Prints the passed string to the debugging console with class informations
///
/// - Parameters:
///   - txt: The string that will be printed to console
///   - sender: The sender of the call
public func print (_ txt: String, _ sender: AnyClass) {
    print("[\(sender.self)] -> \(txt)]")
}
