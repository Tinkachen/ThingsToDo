//
//  Themes.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

enum Gradient {
    case yellow
    case lightBlue
    case pink
    case purple
}

/// The construction of a color theme
struct Theme {
     let main: UIColor
     let gradient: [CGColor]
     let light: Bool
}

/// The color themes for the app
struct Themes {
    
    static let allThemes: [Gradient : Theme] = [.yellow: yellow,
                                                .lightBlue: lightBlue,
                                                .pink: pink,
                                                .purple: purple]
    
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
}
