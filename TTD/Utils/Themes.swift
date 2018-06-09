//
//  Themes.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The construction of a color theme
struct Theme {
     let main: UIColor
     let gradient: [CGColor]
     let light: Bool
}

/// The color themes for the app
struct Themes {
    
    /// Colors for the yellow theme
    static let yellowTheme = Theme(main: .goldenDream, gradient: [UIColor.goldenDream.cgColor, UIColor.witchHaze.cgColor], light: true)
    
    /// Colors for the light blue theme
    static let lightBlueTheme = Theme(main: .sail, gradient: [UIColor.sail.cgColor, UIColor.dodgerBlue.cgColor], light: true)
    
    /// Colors for the pink theme
    static let pinkTheme = Theme(main: .mandysPink, gradient: [UIColor.mandysPink.cgColor, UIColor.mandy.cgColor], light: true)
    
    /// Colors for the purple theme
    static let purpleTheme = Theme(main: .brightUbe, gradient: [UIColor.brightUbe.cgColor, UIColor.mediumSlateBlue.cgColor], light: true)
}
