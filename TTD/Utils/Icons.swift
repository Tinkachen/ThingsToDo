//
//  Icons.swift
//  TTD
//
//  Created by Catharina Herchert on 17.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The enum for the available icons
enum Icon {
    
    // Essential
    case audio, buildings, coding, communication, device, finance, gaming, image, logistik, money, places, shopping, statistic, time, office, video,
    
    // Extra
    christmas, clothe, construction, crime, ecology, food, furniture, health, holidays, hotel, learning, leisure, object, party, romance, spa, space, sport, symbols, tools, transportation, weather,
    
    // Others
    file, woman, man, children, family
    
    /// Creates a random icon
    ///
    /// - Returns: The icon
    static func rdmIcon () -> Icon {
        // TODO: Swift 4.2 .randomElement()
        return Array(Icons.allIcons.keys)[Int(arc4random_uniform(UInt32(Themes.allThemes.count)))]
    }
}

/// The icons for the tasks
struct Icons {
    
    /// An arry of all available images
    static let allIcons: [Icon : UIImage?] = [
        // Essential
        .audio : audio, .buildings : buildings, .coding : coding, .communication : communication, .device : device, .finance : finance, .gaming : gaming, .image : image, .logistik : logistik, .money : money, .places : places, .shopping : shopping, .statistic : statistic, .time : time, .office : office, .video : video,
        
        // Extra
        .christmas : christmas, .clothe : clothe, .construction : construction, .crime : crime, .ecology : ecology, .food : food, .furniture : furniture, .health : health, .holidays : holidays, .hotel : hotel, .learning : learning, .leisure : leisure, .object : object, .party : party, .romance : romance, .spa : spa, .space : space, .sport : sport, .symbols : symbols, .tools : tools, .transportation : transportation, .weather : weather,
        
        // Others
        .file : file, .woman : woman, .man : man, .children : children, .family : family
    ]
    
    /// Gives the icon sa an image
    ///
    /// - Parameter icon: The icon enum
    /// - Returns: The image
    static func getIcon (_ icon: Icon) -> UIImage? {
        switch icon {
        // Essential
        case .audio:
            return audio
        case .buildings:
            return buildings
        case .coding:
            return coding
        case .communication:
            return communication
        case .device:
            return device
        case .finance:
            return finance
        case .gaming:
            return gaming
        case .image:
            return image
        case .logistik:
            return logistik
        case .money:
            return money
        case .places:
            return places
        case .shopping:
            return shopping
        case .statistic:
            return statistic
        case .time:
            return time
        case .office:
            return office
        case .video:
            return video
            
        // Extra
        case .christmas:
            return christmas
        case .clothe:
            return clothe
        case .construction:
            return construction
        case .crime:
            return crime
        case .ecology:
            return ecology
        case .food:
            return food
        case .furniture:
            return furniture
        case .health:
            return health
        case .holidays:
            return holidays
        case .hotel:
            return hotel
        case .learning:
            return learning
        case .leisure:
            return leisure
        case .object:
            return object
        case .party:
            return party
        case .romance:
            return romance
        case .spa:
            return spa
        case .space:
            return space
        case .sport:
            return sport
        case .symbols:
            return symbols
        case .tools:
            return tools
        case .transportation:
            return transportation
        case .weather:
            return weather
            
        // Others
        case .file:
            return file
        case .woman:
            return woman
        case .man:
            return man
        case .children:
            return children
        case .family:
            return family
        }
    }
    
    // Essential
    static let audio = UIImage(named: "")
    static let buildings = UIImage(named: "")
    static let coding = UIImage(named: "")
    static let communication = UIImage(named: "")
    static let device = UIImage(named: "")
    static let finance = UIImage(named: "")
    static let gaming = UIImage(named: "")
    static let image = UIImage(named: "")
    static let logistik = UIImage(named: "")
    static let money = UIImage(named: "")
    static let places = UIImage(named: "")
    static let shopping = UIImage(named: "")
    static let statistic = UIImage(named: "")
    static let time = UIImage(named: "")
    static let office = UIImage(named: "")
    static let video = UIImage(named: "")
    
    // Extra
    static let christmas = UIImage(named: "")
    static let clothe = UIImage(named: "")
    static let construction = UIImage(named: "")
    static let crime = UIImage(named: "")
    static let ecology = UIImage(named: "")
    static let food = UIImage(named: "")
    static let furniture = UIImage(named: "")
    static let health = UIImage(named: "")
    static let holidays = UIImage(named: "")
    static let hotel = UIImage(named: "")
    static let learning = UIImage(named: "")
    static let leisure = UIImage(named: "")
    static let object = UIImage(named: "")
    static let party = UIImage(named: "")
    static let romance = UIImage(named: "")
    static let spa = UIImage(named: "")
    static let space = UIImage(named: "")
    static let sport = UIImage(named: "")
    static let symbols = UIImage(named: "")
    static let tools = UIImage(named: "")
    static let transportation = UIImage(named: "")
    static let weather = UIImage(named: "")
    
    // Others
    static let file = UIImage(named: "")
    static let woman = UIImage(named: "")
    static let man = UIImage(named: "")
    static let children = UIImage(named: "")
    static let family = UIImage(named: "")
}
