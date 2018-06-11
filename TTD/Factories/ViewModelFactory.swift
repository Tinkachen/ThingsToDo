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
    
    /// Makes an instance of the 'NewTodoListViewModel'
    ///
    /// - Returns: The instance
    static func makeNewTodoListViewModel () -> NewTodoListViewModel {
        return NewTodoListViewModel()
    }
    
    /// Makes an instance of the 'NewTodoTaskViewModel'
    ///
    /// - Returns: The instance
    static func makeNewTodoTaskViewModel () -> NewTodoTaskViewModel {
        return NewTodoTaskViewModel()
    }
    
    /// Makes an instance of the 'PasscodeViewModel'
    ///
    /// - Returns: The instance
    static func makePasscodeViewModel () -> PasscodeViewModel {
        return PasscodeViewModel()
    }
}
