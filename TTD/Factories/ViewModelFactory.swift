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
        static let newTodoListKey = "TLVC_title"
        
        /// Title for a new todo task
        static let newTodoTaskKey = "TTVC_title"
    }
}

/// Foctory for creating view models
struct ViewModelFactory {
    
    /// Makes an instance of 'TodoListViewModel'
    ///
    /// - Returns: The instance
    static func makeTodoListViewModel () -> TodoListViewModel {
        let newTodoList = TodoListViewModel(id: UUID().uuidString,
                                            gradient: Gradient.rdmGradient(),
                                            icon: Icon.rdmIcon(),
                                            title: Constants.Strings.newTodoListKey.localized,
                                            passcode: nil,
                                            tasks: nil)
        TodoListService.saveNewListViewModel(newTodoList) { (error) in
            if let error = error {
                print(error.localizedDescription, self)
            }
        }
        return newTodoList
    }
    
    /// Makes an instance of 'TodoTaskViewModel'
    ///
    /// - Returns: The instance
    static func makeTodoTaskVieModel (forList list: String) -> TodoTaskViewModel {
        let viewModel = TodoTaskViewModel(listId: list,
                                          taskId: UUID().uuidString,
                                          taskDescription: Constants.Strings.newTodoTaskKey.localized,
                                          taskEndDate: Date(),
                                          isTimerSet: false,
                                          priority: .no,
                                          isDone: false,
                                          notes: nil)
        return viewModel
    }
    
    /// Makes an instance of the 'PasscodeViewModel'
    ///
    /// - Returns: The instance
    static func makePasscodeViewModel () -> PasscodeViewModel {
        var viewModel =  PasscodeViewModel()
        viewModel.initWithNewPasscode()
        return viewModel
    }
    
    /// Makes an instance of the 'PasscodeViewModel'
    /// - Parameter passcode: The passcode
    ///
    /// - Returns: The instance
    static func makePasscodeViewModel (withPasscode passcode: String) -> PasscodeViewModel {
        var viewModel =  PasscodeViewModel()
        viewModel.initWithPasscode(passcode)
        return viewModel
    }
}
