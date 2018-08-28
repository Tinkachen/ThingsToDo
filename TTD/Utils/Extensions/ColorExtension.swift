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
    
    // Morning
    static let blond = UIColor(hex: 0xFFF6B7)
    
    static let radicialRed = UIColor(hex: 0xF6416C)
    
    // Green
    static let aquamarine = UIColor(hex: 0x81FBB8)
    
    static let ufoGreen = UIColor(hex: 0x28C76F)
    
    // Lavender
    static let mauve = UIColor(hex: 0xE2B0FF)
    
    static let deepLilac = UIColor(hex: 0x9F44D3)
    
    // Violet
    static let pinkSherbet = UIColor(hex: 0xF97794)
    
    static let royalPurple = UIColor(hex: 0x623AA2)
    
    // Sunset
    static let kournikova = UIColor(hex: 0xFCCF31)
    
    static let carnation = UIColor(hex: 0xF55555)
    
    // Berry
    static let magenta2 = UIColor(hex: 0xF761A1)
    
    static let vividViolet = UIColor(hex: 0x8C1BAB)
    
    // Moody Blue
    static let mayaBlue = UIColor(hex: 0x43CBFF)
    
    static let darkOrchid = UIColor(hex: 0x9708CC)
    
    // Maya
    static let babyBlue = UIColor(hex: 0x5EFCE8)
    
    static let fadedBlue = UIColor(hex: 0x736EFE)
    
    // Peach
    static let champagne = UIColor(hex: 0xFAD7A1)
    
    static let froly = UIColor(hex: 0xE96D71)
    
    // Bombay
    static let salomie = UIColor(hex: 0xFFD26F)
    
    static let bleuDeFrance = UIColor(hex: 0x3677FF)
    
    // Apple
    static let sulu = UIColor(hex: 0xA0FE65)
    
    static let razzMatazz = UIColor(hex: 0xFA016D)
    
    // Kokada
    static let sunglow = UIColor(hex: 0xFFDB01)
    
    static let astronaut = UIColor(hex: 0x0E197D)
    
    // Orange
    static let chardonnay = UIColor(hex: 0xFEC163)
    
    static let punch = UIColor(hex: 0xDE4313)
    
    // Deep Sea
    static let magicMint = UIColor(hex: 0x92FFC0)
    
    static let coolBlack = UIColor(hex: 0x002661)
    
    // Mauve
    static let waxflower = UIColor(hex: 0xEEAD92)
    
    static let purpleHeart = UIColor(hex: 0x6018DC)
    
    // Plum
    static let classicRose = UIColor(hex: 0xF6CEEC)
    
    static let deepFuchsia = UIColor(hex: 0xD939CD)
    
    // Denim
    static let turquoiseBlue = UIColor(hex: 0x52E5E7)
    
    static let persianBlue = UIColor(hex: 0x130CB7)
    
    // Oriental
    static let marzipan = UIColor(hex: 0xF1CA74)
    
    static let violetBlue = UIColor(hex: 0xA64DB6)
    
    // Bouquet
    static let putty = UIColor(hex: 0xE8D07A)
    
    static let purpleHeart2 = UIColor(hex: 0x5312D6)
    
    // Charm
    static let festival = UIColor(hex: 0xEECE13)
    
    static let veronica = UIColor(hex: 0xB210FF)
    
    // Sea
    static let lightGreen = UIColor(hex: 0x79F1A4)
    
    static let matisse = UIColor(hex: 0x0E5CAD)
    
    // Fire
    static let sunglow2 = UIColor(hex: 0xFDD819)
    
    static let lust = UIColor(hex: 0xE80505)
    
    // Orchid
    static let buttermilk = UIColor(hex: 0xFFF3B0)
    
    static let mediumOrchid = UIColor(hex: 0xCA26FF)
    
    // Lily
    static let beeswax = UIColor(hex: 0xFFF5C3)
    
    static let vividViolet2 = UIColor(hex: 0x9452A5)
    
    // Romance
    static let roman = UIColor(hex: 0xF05F57)
    
    static let valentino = UIColor(hex: 0x360940)
    
    // Miami
    static let turquoise2 = UIColor(hex: 0x2AFADF)
    
    static let unitedNationsBlue = UIColor(hex: 0x4C83FF)
    
    // Manhatten
    static let pastelYellow = UIColor(hex: 0xFFF886)
    
    static let carissma = UIColor(hex: 0xF072B6)
    
    // Dark Blue
    static let jordyBlue = UIColor(hex: 0x97ABFF)
    
    static let yaleBlue = UIColor(hex: 0x123597)
    
    // Fuchsia
    static let frenchLilac = UIColor(hex: 0xF5CBFF)
    
    static let deepFuchsia2 = UIColor(hex: 0xC346C2)
    
    // lightGreen
    static let gorse = UIColor(hex: 0xFFF720)
    
    static let dullLime = UIColor(hex: 0x3CD500)
    
    // Fairy
    static let fadedCyan = UIColor(hex: 0x81FFEF)
    
    static let magenta = UIColor(hex: 0xF067B4)
}
