//
//  MainService.swift
//  TTD
//
//  Created by Catharina Herchert on 11.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// The error messages
enum ErrorMessage {
    
    /// No context error message
    static let noContext = "No context found."
    
    /// No entity error message
    static let noEntity = "No entity found with the name."
    
    /// Unknown error message
    static let unknown = "An unknown Error occured."
    
    /// No save error message
    static let noSave = "There was no save of the data possible."
}

/// The main service protocol
protocol MainService {
    
    /// The moc context
    static var context: NSManagedObjectContext? { get }
}

/// The service for getting data from the local storage
extension MainService {
    
    // Core Data
    
    /// The moc context
    static var context: NSManagedObjectContext? {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDel.persistentContainer.viewContext
    }
}
