//
//  ViewModelFactory.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

/// Private constants
private enum Constants {
    
    /// Localized Strings for view models
    enum Strings {
        
        /// Title for a new todo list
        static let newTodoList = NSLocalizedString("NTLVC_title", comment: "Title for a new todo list")
        
        /// Title for a new todo task
        static let newTodoTask = NSLocalizedString("NTTVC_title", comment: "Title for a new todo task")
    }
}

/// Foctory for creating view models
struct ViewModelFactory {
    
    /// Makes an instance of 'TodoListViewModel'
    ///
    /// - Returns: The instance
    static func makeTodoListViewModel () -> TodoListViewModel {
        return TodoListViewModel(id: UUID().uuidString,
                                 gradient: Gradient.rdmGradient(),
                                 icon: Icon.rdmIcon(),
                                 title: Constants.Strings.newTodoList,
                                 passcode: nil,
                                 tasks: nil)
    }
    
    /// Makes an instance of 'TodoTaskViewModel'
    ///
    /// - Returns: The instance
    static func makeTodoTaskVieModel () -> TodoTaskViewModel {
        var viewModel = TodoTaskViewModel()
        viewModel.taskDescription = Constants.Strings.newTodoTask
        return viewModel
    }
    
    /// Makes an instance of the 'PasscodeViewModel'
    ///
    /// - Returns: The instance
    static func makePasscodeViewModel () -> PasscodeViewModel {
        return PasscodeViewModel()
    }
}
