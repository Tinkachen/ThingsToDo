//
//  Themes.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The gradient structure
struct Gradient: Equatable {
    
    /// The id of the gradient
    let id: Int
    
    /// The main color of the gradient
    let main: UIColor
    
    /// The colors for the gradient
    let gradient: [CGColor]
    
    /// Indicator if the gradient has a light appereance
    let light: Bool
}

/// Compare gradients
///
/// - Parameters:
///   - rhs: Gradient 1
///   - lhs: Gradient 2
/// - Returns: The identicator if the gradients are equal
func == (rhs: Gradient, lhs: Gradient) -> Bool {
    return rhs.id == lhs.id
}

/// The gradients for the application
private struct Gradients {
    
    static let yellow = Gradient(id: 0, main: .goldenDream, gradient: [UIColor.goldenDream.cgColor, UIColor.witchHaze.cgColor], light: true)
    
    static let lightBlue = Gradient(id: 1, main: .sail, gradient: [UIColor.sail.cgColor, UIColor.dodgerBlue.cgColor], light: true)
    
    static let pink = Gradient(id: 2, main: .mandysPink, gradient: [UIColor.mandysPink.cgColor, UIColor.mandy.cgColor], light: true)
    
    static let purple = Gradient(id: 3, main: .brightUbe, gradient: [UIColor.brightUbe.cgColor, UIColor.mediumSlateBlue.cgColor], light: true)
    
    static let turquoise = Gradient(id: 4, main: .waterLeaf, gradient: [UIColor.waterLeaf.cgColor, UIColor.dullCyan.cgColor], light: false)
    
    static let morning = Gradient(id: 5, main: .radicialRed, gradient: [UIColor.blond.cgColor, UIColor.radicialRed.cgColor], light: false)
    
    static let green = Gradient(id: 6, main: .ufoGreen, gradient: [UIColor.aquamarine.cgColor, UIColor.ufoGreen.cgColor], light: false)
    
    static let lavender = Gradient(id: 7, main: .deepLilac, gradient: [UIColor.mauve.cgColor, UIColor.deepLilac.cgColor], light: false)
    
    static let violet = Gradient(id: 8, main: .royalPurple, gradient: [UIColor.pinkSherbet.cgColor, UIColor.royalPurple.cgColor], light: false)
    
    static let sunset = Gradient(id: 9, main: .carnation, gradient: [UIColor.kournikova.cgColor, UIColor.carnation.cgColor], light: false)
    
    static let berry = Gradient(id: 10, main: .vividViolet, gradient: [UIColor.magenta2.cgColor, UIColor.vividViolet.cgColor], light: false)
    
    static let moodyBlue = Gradient(id: 11, main: .darkOrchid, gradient: [UIColor.mayaBlue.cgColor, UIColor.darkOrchid.cgColor], light: false)
    
    static let maya = Gradient(id: 12, main: .fadedBlue, gradient: [UIColor.babyBlue.cgColor, UIColor.fadedBlue.cgColor], light: false)
    
    static let peach = Gradient(id: 13, main: .froly, gradient: [UIColor.champagne.cgColor, UIColor.froly.cgColor], light: true)
    
    static let bombay = Gradient(id: 14, main: .bleuDeFrance, gradient: [UIColor.salomie.cgColor, UIColor.bleuDeFrance.cgColor], light: true)
    
    static let apple = Gradient(id: 15, main: .razzMatazz, gradient: [UIColor.sulu.cgColor, UIColor.razzMatazz.cgColor], light: true)
    
    static let kokada = Gradient(id: 16, main: .astronaut, gradient: [UIColor.sunglow.cgColor, UIColor.astronaut.cgColor], light: false)
    
    static let orange = Gradient(id: 17, main: .punch, gradient: [UIColor.chardonnay.cgColor, UIColor.punch.cgColor], light: true)
    
    static let deepSea = Gradient(id: 18, main: .coolBlack, gradient: [UIColor.magicMint.cgColor, UIColor.coolBlack.cgColor], light: false)
    
    static let mauve = Gradient(id: 19, main: .purpleHeart, gradient: [UIColor.waxflower.cgColor, UIColor.purpleHeart.cgColor], light: false)
    
    static let plum = Gradient(id: 20, main: .deepFuchsia, gradient: [UIColor.classicRose.cgColor, UIColor.deepFuchsia.cgColor], light: false)
    
    static let denim = Gradient(id: 21, main: .persianBlue, gradient: [UIColor.turquoiseBlue.cgColor, UIColor.persianBlue.cgColor], light: false)
    
    static let oriental = Gradient(id: 22, main: .violetBlue, gradient: [UIColor.marzipan.cgColor, UIColor.violetBlue.cgColor], light: true)
    
    static let bouquet = Gradient(id: 23, main: .purpleHeart2, gradient: [UIColor.putty.cgColor, UIColor.purpleHeart2.cgColor], light: false)
    
    static let charm = Gradient(id: 24, main: .veronica, gradient: [UIColor.festival.cgColor, UIColor.veronica.cgColor], light: true)
    
    static let sea = Gradient(id: 25, main: .matisse, gradient: [UIColor.lightGreen.cgColor, UIColor.matisse.cgColor], light: false)
    
    static let fire = Gradient(id: 26, main: .lust, gradient: [UIColor.sunglow2.cgColor, UIColor.lust.cgColor], light: false)
    
    static let orchid = Gradient(id: 27, main: .mediumOrchid, gradient: [UIColor.buttermilk.cgColor, UIColor.mediumOrchid.cgColor], light: true)
    
    static let lily = Gradient(id: 28, main: .vividViolet2, gradient: [UIColor.beeswax.cgColor, UIColor.vividViolet2.cgColor], light: true)
    
    static let romance = Gradient(id: 29, main: .valentino, gradient: [UIColor.roman.cgColor, UIColor.valentino.cgColor], light: false)
    
    static let miami = Gradient(id: 30, main: .unitedNationsBlue, gradient: [UIColor.turquoise2.cgColor, UIColor.unitedNationsBlue.cgColor], light: true)
    
    static let manhatten = Gradient(id: 31, main: .carissma, gradient: [UIColor.pastelYellow.cgColor, UIColor.carissma.cgColor], light: true)
    
    static let darkBlue = Gradient(id: 32, main: .yaleBlue, gradient: [UIColor.jordyBlue.cgColor, UIColor.yaleBlue.cgColor], light: false)
    
    static let fuchsia = Gradient(id: 33, main: .deepFuchsia2, gradient: [UIColor.frenchLilac.cgColor, UIColor.deepFuchsia2.cgColor], light: false)
    
    
    
    static let lightGreen = Gradient(id: 34, main: .dullLime, gradient: [UIColor.gorse.cgColor, UIColor.dullCyan.cgColor], light: true)
    
    static let fairy = Gradient(id: 35, main: .magenta, gradient: [UIColor.fadedCyan.cgColor, UIColor.magenta.cgColor], light: true)
}

/// The themes for the application
enum Theme {
    case yellow, lightblue, pink, purple, turquoise, morning, green, lavender, violet, sunset, berry, moodyBlue, maya,
    peach, bombay, apple, kokada, orange, deepSea, mauve, plum, denim, oriental, bouquet, charm, sea, fire, orchid,
    lily, romance, miami, manhatten, darkBlue, fuchsia, lightGreen, fairy
    
    /// Returns all themes for the application
    static var allThemes: [Gradient] {
        return [
            Gradients.yellow, Gradients.lightBlue, Gradients.pink, Gradients.purple, Gradients.turquoise, Gradients.morning,
            Gradients.green, Gradients.lavender, Gradients.violet, Gradients.sunset, Gradients.berry, Gradients.moodyBlue,
            Gradients.maya, Gradients.peach, Gradients.bombay, Gradients.apple, Gradients.kokada, Gradients.orange,
            Gradients.deepSea, Gradients.mauve, Gradients.plum, Gradients.denim, Gradients.oriental, Gradients.bouquet,
            Gradients.charm, Gradients.sea, Gradients.fire, Gradients.orchid, Gradients.lily, Gradients.romance,
            Gradients.miami, Gradients.manhatten, Gradients.darkBlue, Gradients.fuchsia, Gradients.lightGreen, Gradients.fairy
        ]
    }
    
    /// Creates a random gradient
    static var rdmGradient: Gradient {
        return allThemes.randomElement() ?? Gradients.yellow
    }
    
    /// Gets the gradient for the passed id
    ///
    /// - Parameter id: The id
    /// - Returns: The gradient for the id
    static func gradientForId (_ id: Int) -> Gradient {
        return allThemes[id]
    }
}

// MARK: - Extension Theme : RawRepresentable
extension Theme : RawRepresentable {
    
    typealias RawValue = Gradient
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case Gradients.yellow:
            self = .yellow
        case Gradients.lightBlue:
            self = .lightblue
        case Gradients.pink:
            self = .pink
        case Gradients.purple:
            self = .purple
        case Gradients.turquoise:
            self = .turquoise
        case Gradients.morning:
            self = .morning
        case Gradients.green:
            self = .green
        case Gradients.lavender:
            self = .lavender
        case Gradients.violet:
            self = .violet
        case Gradients.sunset:
            self = .sunset
        case Gradients.berry:
            self = .berry
        case Gradients.moodyBlue:
            self = .moodyBlue
        case Gradients.maya:
            self = .maya
        case Gradients.peach:
            self = .peach
        case Gradients.bombay:
            self = .bombay
        case Gradients.apple:
            self = .apple
        case Gradients.kokada:
            self = .kokada
        case Gradients.orange:
            self = .orange
        case Gradients.deepSea:
            self = .deepSea
        case Gradients.mauve:
            self = .mauve
        case Gradients.plum:
            self = .plum
        case Gradients.denim:
            self = .denim
        case Gradients.oriental:
            self = .oriental
        case Gradients.bouquet:
            self = .bouquet
        case Gradients.charm:
            self = .charm
        case Gradients.sea:
            self = .sea
        case Gradients.fire:
            self = .fire
        case Gradients.orchid:
            self = .orchid
        case Gradients.lily:
            self = .lily
        case Gradients.romance:
            self = .romance
        case Gradients.miami:
            self = .miami
        case Gradients.manhatten:
            self = .manhatten
        case Gradients.darkBlue:
            self = .darkBlue
        case Gradients.fuchsia:
            self = .fuchsia
        case Gradients.lightGreen:
            self = .lightGreen
        case Gradients.fairy:
            self = .fairy
        default:
            self = .yellow
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .yellow:
            return Gradients.yellow
        case .lightblue:
            return Gradients.lightBlue
        case .pink:
            return Gradients.pink
        case .purple:
            return Gradients.purple
        case .turquoise:
            return Gradients.turquoise
        case .morning:
            return Gradients.morning
        case .green:
            return Gradients.green
        case .lavender:
            return Gradients.lavender
        case .violet:
            return Gradients.violet
        case .sunset:
            return Gradients.sunset
        case .berry:
            return Gradients.berry
        case .moodyBlue:
            return Gradients.moodyBlue
        case .maya:
            return Gradients.maya
        case .peach:
            return Gradients.peach
        case .bombay:
            return Gradients.bombay
        case .apple:
            return Gradients.apple
        case .kokada:
            return Gradients.kokada
        case .orange:
            return Gradients.orange
        case .deepSea:
            return Gradients.deepSea
        case .mauve:
            return Gradients.mauve
        case .plum:
            return Gradients.plum
        case .denim:
            return Gradients.denim
        case .oriental:
            return Gradients.oriental
        case .bouquet:
            return Gradients.bouquet
        case .charm:
            return Gradients.charm
        case .sea:
            return Gradients.sea
        case .fire:
            return Gradients.fire
        case .orchid:
            return Gradients.orchid
        case .lily:
            return Gradients.lily
        case .romance:
            return Gradients.romance
        case .miami:
            return Gradients.miami
        case .manhatten:
            return Gradients.manhatten
        case .darkBlue:
            return Gradients.darkBlue
        case .fuchsia:
            return Gradients.fuchsia
        case .lightGreen:
            return Gradients.lightGreen
        case .fairy:
            return Gradients.fairy
        }
    }
}
