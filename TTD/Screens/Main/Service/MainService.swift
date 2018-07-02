//
//  MainService.swift
//  TTD
//
//  Created by Catharina Herchert on 11.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

/// The service for getting data from the local storage
struct MainService {
    
    /// Creates dummy data of todo lists
    ///
    /// - Returns: The created dummy data
    func createDummyData () -> [TodoListViewModel] {
        var todoLists = [TodoListViewModel]()
        
        todoLists.append(TodoListViewModel(id: "1", gradient: .yellow, icon: .audio, title: "Test", passcode: nil, tasks: nil))
        
        return todoLists
    }
}
