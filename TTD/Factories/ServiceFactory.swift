//
//  ServiceFactory.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

/// Factory for creating services
struct ServiceFactory {
    
    /// Makes an instance of 'NewTodoListService'
    ///
    /// - Returns: The instance
    static func makeTodoListService () -> TodoListService {
        return TodoListService()
    }
    
    /// Makes an instance of 'NewTodoTaskService'
    ///
    /// - Returns: The instance
    static func makeTodoTaskService () -> TodoTaskService {
        return TodoTaskService ()
    }
}
