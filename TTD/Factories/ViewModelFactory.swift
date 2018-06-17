//
//  ViewModelFactory.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

/// Foctory for creating view models
struct ViewModelFactory {
    
    /// Makes an instance of 'TodoListViewModel'
    ///
    /// - Returns: The instance
    static func makeTodoListViewModel () -> TodoListViewModel {
        return TodoListViewModel ()
    }
    
    /// Makes an instance of 'TodoTaskViewModel'
    ///
    /// - Returns: The instance
    static func makeTodoTaskVieModel () -> TodoTaskViewModel {
        return TodoTaskViewModel()
    }
    
    /// Makes an instance of the 'PasscodeViewModel'
    ///
    /// - Returns: The instance
    static func makePasscodeViewModel () -> PasscodeViewModel {
        return PasscodeViewModel()
    }
}
