//
//  ViewControllerFactory.swift
//  TTD
//
//  Created by Catharina Herchert on 08.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Factory for creating view controllers
class ViewControllerFactory {
    
    /// Makes an instance of the first screen for the application
    ///
    /// - Parameter firstStart: Says if it is the very first start of the application
    /// - Returns: The instance
    static func startWithViewController (ForFirstStart firstStart: Bool) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: firstStart ? makePersonalizeViewController() : makeMainViewController())
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    /// Makes an instance of the 'PersonalizeViewController'
    ///
    /// - Returns: The instance
    private static func makePersonalizeViewController () -> UIViewController {
        let personalizeViewController: PersonalizeViewController = makeViewController()
        return personalizeViewController
    }
    
    /// Makes an instance of the 'MainViewController'
    ///
    /// - Returns: The instance
    private static func makeMainViewController () -> UIViewController {
        let mainViewController: MainViewController = makeViewController()
        return mainViewController
    }
    
    /// Makes an instance of the 'NewTodoListViewController'
    ///
    /// - Returns: The instance
    static func makeTodoListViewController (WithViewModel viewModel: TodoListViewModel?) -> UIViewController {
        let newTodoListViewController: NewTodoListViewController = makeViewController()
        newTodoListViewController.service = ServiceFactory.makeNewTodoListService()
        newTodoListViewController.viewModel = viewModel ?? ViewModelFactory.makeTodoListViewModel()
        return newTodoListViewController
    }
    
    /// Makes an instance of the 'NewTodoTaskViewController'
    ///
    /// - Returns: The instance
    static func makeTodoTaskViewController (WithViewModel viewModel: TodoTaskViewModel?) -> UIViewController {
        let newTodoTaskViewController: NewTodoTaskViewController = makeViewController()
        newTodoTaskViewController.service = ServiceFactory.makeNewTodoTaskService()
        newTodoTaskViewController.viewModel = viewModel ?? ViewModelFactory.makeTodoTaskVieModel()
        return newTodoTaskViewController
    }
    
    /// Makes an instance of the 'PasscodeViewController'
    ///
    /// - Returns: The instance
    static func makePasscodeViewController () -> UIViewController {
        let passcodeViewController: PasscodeViewController = makeViewController()
        return passcodeViewController
    }
    
    // MARK: - Private helper functions
    
    /// Makes a view controller from the given class
    ///
    /// - Returns: The instance of the view controller
    private static func makeViewController<T> () -> T where T: UIViewController {
        let storyBoard = UIStoryboard(name: String(describing: T.self), bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateInitialViewController() as? T else {
            fatalError("")
        }
        return viewController
    }
    
    
}
