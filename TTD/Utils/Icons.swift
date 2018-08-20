//
//  Icons.swift
//  TTD
//
//  Created by Catharina Herchert on 17.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The enum for the available icons
enum Icon: Int {
    
    // Essential
    case audio = 0, buildings, coding, communication, device, finance, gaming, image, logistik, money, places, shopping, statistic, time, office, video,
    
    // Extra
    christmas, clothe, construction, crime, ecology, food, furniture, health, holidays, hotel, learning, leisure, object, party, romance, spa, space, sport, symbols, tools, transportation, weather,
    
    // Others
    file, woman, man, children
    
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
        .file : file, .woman : woman, .man : man, .children : children
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
        }
    }
    
    // Essential
    static let audio = #imageLiteral(resourceName: "Audio")
    static let buildings = #imageLiteral(resourceName: "Buildings")
    static let coding = #imageLiteral(resourceName: "Coding")
    static let communication = #imageLiteral(resourceName: "Communication")
    static let device = #imageLiteral(resourceName: "Device")
    static let finance = #imageLiteral(resourceName: "Finance")
    static let gaming = #imageLiteral(resourceName: "Gaming")
    static let image = #imageLiteral(resourceName: "Image")
    static let logistik = #imageLiteral(resourceName: "Logistic")
    static let money = #imageLiteral(resourceName: "Money")
    static let places = #imageLiteral(resourceName: "Places")
    static let shopping = #imageLiteral(resourceName: "Shopping")
    static let statistic = #imageLiteral(resourceName: "Statistics")
    static let time = #imageLiteral(resourceName: "Time")
    static let office = #imageLiteral(resourceName: "Office")
    static let video = #imageLiteral(resourceName: "Video")
    
    // Extra
    static let christmas = #imageLiteral(resourceName: "Christmas")
    static let clothe = #imageLiteral(resourceName: "Clothe")
    static let construction = #imageLiteral(resourceName: "Construction")
    static let crime = #imageLiteral(resourceName: "Crime")
    static let ecology = #imageLiteral(resourceName: "Ecology")
    static let food = #imageLiteral(resourceName: "Food")
    static let furniture = #imageLiteral(resourceName: "Furniture")
    static let health = #imageLiteral(resourceName: "Health")
    static let holidays = #imageLiteral(resourceName: "Holiday")
    static let hotel = #imageLiteral(resourceName: "Hotel")
    static let learning = #imageLiteral(resourceName: "Learning")
    static let leisure = #imageLiteral(resourceName: "Leisure")
    static let object = #imageLiteral(resourceName: "Object")
    static let party = #imageLiteral(resourceName: "Party")
    static let romance = #imageLiteral(resourceName: "Romance")
    static let spa = #imageLiteral(resourceName: "Spa")
    static let space = #imageLiteral(resourceName: "space")
    static let sport = #imageLiteral(resourceName: "Sport")
    static let symbols = #imageLiteral(resourceName: "Symbol")
    static let tools = #imageLiteral(resourceName: "Tool")
    static let transportation = #imageLiteral(resourceName: "Transportation")
    static let weather = #imageLiteral(resourceName: "Weather")
    
    // Others
    static let file = #imageLiteral(resourceName: "File")
    static let woman = #imageLiteral(resourceName: "Woman")
    static let man = #imageLiteral(resourceName: "Man")
    static let children = #imageLiteral(resourceName: "Children")
}
