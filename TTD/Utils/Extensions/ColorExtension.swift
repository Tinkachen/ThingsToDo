//
//  ColorExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 08.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//
// Colors from: https://webkul.github.io/coolhue/

import UIKit

// MARK: - Extension of the UIColor class
extension UIColor {
    
    /// Convertes a hex value to UIColor
    ///
    /// - Parameter hex: Hex Value of the Color
    convenience init(hex: UInt32) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hex & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
    
    // MARK: - Main Colors
    
    static let lightGray = UIColor(hex: 0xF6F6F6)
    
    static let midGray = UIColor(hex: 0x6E6F6D)
    
    // MARK: - Colors
    
    // Yellow
    static let goldenDream = UIColor(hex: 0xFDEB71)
    
    static let witchHaze = UIColor(hex: 0xF8D800)
    
    // Light blue
    static let sail = UIColor(hex: 0xABDCFF)
    
    static let dodgerBlue = UIColor(hex: 0x0396FF)
    
    // Pink
    static let mandysPink = UIColor(hex: 0xFEB692)
    
    static let mandy = UIColor(hex: 0xEA5455)
    
    // Purple
    static let brightUbe = UIColor(hex: 0xCE9FFC)
    
    static let mediumSlateBlue = UIColor(hex: 0x7367F0)
    
    // Turquoise
    
    static let waterLeaf = UIColor(hex: 0x90F7EC)
    
    static let dullCyan = UIColor(hex: 0x32CCBC)
    
    // Green
    static let gorse = UIColor(hex: 0xFFF720)
    
    static let dullLime = UIColor(hex: 0x3CD500)
    
    // Fairy
    static let fadedCyan = UIColor(hex: 0x81FFEF)
    
    static let magenta = UIColor(hex: 0xF067B4)
}
