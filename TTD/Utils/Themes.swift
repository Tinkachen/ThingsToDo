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
    case morning
    case green
    case lavender
    case violet
    case sunset
    case berry
    case moodyBlue
    case maya
    case peach
    case bombay
    case apple
    case kokada
    case orange
    case deepSea
    case mauve
    case plum
    case denim
    case oriental
    case bouquet
    case charm
    case sea
    case fire
    case orchid
    case lily
    case romance
    case miami
    case manhatten
    case darkBlue
    case fuchsia
    case lightGreen
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
                                                .morning : morning,
                                                .green : green,
                                                .lavender : lavender,
                                                .violet : violet,
                                                .sunset : sunset,
                                                .berry : berry,
                                                .moodyBlue : moodyBlue,
                                                .maya : maya,
                                                .peach : peach,
                                                .bombay : bombay,
                                                .apple : apple,
                                                .kokada : kokada,
                                                .orange : orange,
                                                .deepSea : deepSea,
                                                .mauve : mauve,
                                                .plum : plum,
                                                .denim : denim,
                                                .oriental : oriental,
                                                .bouquet : bouquet,
                                                .charm : charm,
                                                .sea : sea,
                                                .fire : fire,
                                                .orchid : orchid,
                                                .lily : lily,
                                                .romance : romance,
                                                .miami : miami,
                                                .manhatten : manhatten,
                                                .darkBlue : darkBlue,
                                                .fuchsia : fuchsia,
                                                .lightGreen : lightGreen,
                                                
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
        case .morning:
            return morning
        case .green:
            return green
        case .lavender:
            return lavender
        case .violet:
            return violet
        case .sunset:
            return sunset
        case .berry:
            return berry
        case .moodyBlue:
            return moodyBlue
        case .maya:
            return maya
        case .peach:
            return peach
        case .bombay:
            return bombay
        case .apple:
            return apple
        case .kokada:
            return kokada
        case .orange:
            return orange
        case .deepSea:
            return deepSea
        case .mauve:
            return mauve
        case .plum:
            return plum
        case .denim:
            return denim
        case .oriental:
            return oriental
        case .bouquet:
            return bouquet
        case .charm:
            return charm
        case .sea:
            return sea
        case .fire:
            return fire
        case .orchid:
            return orchid
        case .lily:
            return lily
        case .romance:
            return romance
        case .miami:
            return miami
        case .manhatten:
            return manhatten
        case .darkBlue:
            return darkBlue
        case .fuchsia:
            return fuchsia
        case .lightGreen:
            return lightGreen
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
    
    /// <#Description#>
    static let turquoise = Theme(main: .waterLeaf, gradient: [UIColor.waterLeaf.cgColor, UIColor.dullCyan.cgColor], light: false)
    
    /// <#Description#>
    static let morning = Theme(main: .radicialRed, gradient: [UIColor.blond.cgColor, UIColor.radicialRed.cgColor], light: false)
    
    /// <#Description#>
    static let green = Theme(main: .ufoGreen, gradient: [UIColor.aquamarine.cgColor, UIColor.ufoGreen.cgColor], light: false)
    
    /// <#Description#>
    static let lavender = Theme(main: .deepLilac, gradient: [UIColor.mauve.cgColor, UIColor.deepLilac.cgColor], light: false)
    
    /// <#Description#>
    static let violet = Theme(main: .royalPurple, gradient: [UIColor.pinkSherbet.cgColor, UIColor.royalPurple.cgColor], light: false)
    
    /// <#Description#>
    static let sunset = Theme(main: .carnation, gradient: [UIColor.kournikova.cgColor, UIColor.carnation.cgColor], light: false)
    
    
    static let berry = Theme(main: .vividViolet, gradient: [UIColor.magenta2.cgColor, UIColor.vividViolet.cgColor], light: false)
    
    static let moodyBlue = Theme(main: .darkOrchid, gradient: [UIColor.mayaBlue.cgColor, UIColor.darkOrchid.cgColor], light: false)
    
    static let maya = Theme(main: .fadedBlue, gradient: [UIColor.babyBlue.cgColor, UIColor.fadedBlue.cgColor], light: false)
    
    static let peach = Theme(main: .froly, gradient: [UIColor.champagne.cgColor, UIColor.froly.cgColor], light: true)
    
    static let bombay = Theme(main: .bleuDeFrance, gradient: [UIColor.salomie.cgColor, UIColor.bleuDeFrance.cgColor], light: true)
    
    static let apple = Theme(main: .razzMatazz, gradient: [UIColor.sulu.cgColor, UIColor.razzMatazz.cgColor], light: true)
    
    static let kokada = Theme(main: .astronaut, gradient: [UIColor.sunglow.cgColor, UIColor.astronaut.cgColor], light: false)
    
    static let orange = Theme(main: .punch, gradient: [UIColor.chardonnay.cgColor, UIColor.punch.cgColor], light: true)
    
    static let deepSea = Theme(main: .coolBlack, gradient: [UIColor.magicMint.cgColor, UIColor.coolBlack.cgColor], light: false)
    
    static let mauve = Theme(main: .purpleHeart, gradient: [UIColor.waxflower.cgColor, UIColor.purpleHeart.cgColor], light: false)
    
    static let plum = Theme(main: .deepFuchsia, gradient: [UIColor.classicRose.cgColor, UIColor.deepFuchsia.cgColor], light: false)
    
    static let denim = Theme(main: .persianBlue, gradient: [UIColor.turquoiseBlue.cgColor, UIColor.persianBlue.cgColor], light: false)
    
    static let oriental = Theme(main: .violetBlue, gradient: [UIColor.marzipan.cgColor, UIColor.violetBlue.cgColor], light: true)
    
    static let bouquet = Theme(main: .purpleHeart2, gradient: [UIColor.putty.cgColor, UIColor.purpleHeart2.cgColor], light: false)
    
    static let charm = Theme(main: .veronica, gradient: [UIColor.festival.cgColor, UIColor.veronica.cgColor], light: true)
    
    static let sea = Theme(main: .matisse, gradient: [UIColor.lightGreen.cgColor, UIColor.matisse.cgColor], light: false)
    
    static let fire = Theme(main: .lust, gradient: [UIColor.sunglow2.cgColor, UIColor.lust.cgColor], light: false)
    
    static let orchid = Theme(main: .mediumOrchid, gradient: [UIColor.buttermilk.cgColor, UIColor.mediumOrchid.cgColor], light: true)
    
    static let lily = Theme(main: .vividViolet2, gradient: [UIColor.beeswax.cgColor, UIColor.vividViolet2.cgColor], light: true)
    
    static let romance = Theme(main: .valentino, gradient: [UIColor.roman.cgColor, UIColor.valentino.cgColor], light: false)
    
    static let miami = Theme(main: .unitedNationsBlue, gradient: [UIColor.turquoise2.cgColor, UIColor.unitedNationsBlue.cgColor], light: true)
    
    static let manhatten = Theme(main: .carissma, gradient: [UIColor.pastelYellow.cgColor, UIColor.carissma.cgColor], light: true)
    
    static let darkBlue = Theme(main: .yaleBlue, gradient: [UIColor.jordyBlue.cgColor, UIColor.yaleBlue.cgColor], light: false)
    
    static let fuchsia = Theme(main: .deepFuchsia2, gradient: [UIColor.frenchLilac.cgColor, UIColor.deepFuchsia2.cgColor], light: false)
    
    /// <#Description#>
    static let lightGreen = Theme(main: .dullLime, gradient: [UIColor.gorse.cgColor, UIColor.dullCyan.cgColor], light: true)
    
    /// <#Description#>
    static let fairy = Theme(main: .magenta, gradient: [UIColor.fadedCyan.cgColor, UIColor.magenta.cgColor], light: true)
}
