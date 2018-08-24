//
//  Themes.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

enum Gradient: Int {
    case yellow = 0
    case lightBlue
    case pink
    case purple
    case turquoise
    case green
    case fairy
    
    /// Creates a random gradient
    ///
    /// - Returns: The gradient
    static func rdmGradient () -> Gradient {
        // TODO: Swift 4.2 .randomElement()
        return Array(Themes.allThemes.keys)[Int(arc4random_uniform(UInt32(Themes.allThemes.count)))]
    }
}

/// The construction of a color theme
struct Theme {
     let main: UIColor
     let gradient: [CGColor]
     let light: Bool
}

/// The color themes for the app
struct Themes {
    
    static let allThemes: [Gradient : Theme] = [.yellow : yellow,
                                                .lightBlue : lightBlue,
                                                .pink : pink,
                                                .purple : purple,
                                                .turquoise : turquoise,
                                                .green : green,
                                                .fairy : fairy]
    
    /// Gives the theme informations
    ///
    /// - Parameter theme: The theme enum
    /// - Returns: The theme
    static func getTheme (_ theme: Gradient) -> Theme {
        switch theme {
        case .yellow:
            return yellow
        case .lightBlue:
            return lightBlue
        case .pink:
            return pink
        case .purple:
            return purple
        case .turquoise:
            return turquoise
        case .green:
            return green
        case .fairy:
            return fairy
        }
    }
    
    /// Colors for the yellow theme
    static let yellow = Theme(main: .goldenDream, gradient: [UIColor.goldenDream.cgColor, UIColor.witchHaze.cgColor], light: true)
    
    /// Colors for the light blue theme
    static let lightBlue = Theme(main: .sail, gradient: [UIColor.sail.cgColor, UIColor.dodgerBlue.cgColor], light: true)
    
    /// Colors for the pink theme
    static let pink = Theme(main: .mandysPink, gradient: [UIColor.mandysPink.cgColor, UIColor.mandy.cgColor], light: true)
    
    /// Colors for the purple theme
    static let purple = Theme(main: .brightUbe, gradient: [UIColor.brightUbe.cgColor, UIColor.mediumSlateBlue.cgColor], light: true)
    
    static let turquoise = Theme(main: .waterLeaf, gradient: [UIColor.waterLeaf.cgColor, UIColor.dullCyan.cgColor], light: false)
    
    /// <#Description#>
    static let green = Theme(main: .dullLime, gradient: [UIColor.gorse.cgColor, UIColor.dullCyan.cgColor], light: true)
    
    /// <#Description#>
    static let fairy = Theme(main: .magenta, gradient: [UIColor.fadedCyan.cgColor, UIColor.magenta.cgColor], light: true)
}
