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

enum ErrorMessage {
    
    static let noContext = ""
    
    static let noEntity = ""
    
    static let unknown = ""
    
    static let noSave = ""
}

protocol MainService {
    
    static var context: NSManagedObjectContext? { get }
}

/// The service for getting data from the local storage
extension MainService {
    
    /// Creates dummy data of todo lists
    ///
    /// - Returns: The created dummy data
    func createDummyData () -> [TodoListViewModel] {
        var todoLists = [TodoListViewModel]()
        
        todoLists.append(TodoListViewModel(id: "1", gradient: .yellow, icon: .audio, title: "Test", passcode: nil, tasks: nil))
        
        return todoLists
    }
    
    // Core Data
    
    static var context: NSManagedObjectContext? {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDel.persistentContainer.viewContext
    }
}
