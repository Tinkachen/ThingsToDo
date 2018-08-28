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
    /// - Parameter viewModel: The view model
    /// - Returns: The instance
    static func makeTodoListViewController (withTransitioningDelegate delegate: UIViewControllerTransitioningDelegate,
                                            andViewModel viewModel: TodoListViewModel? = nil) -> UIViewController {
        let todoListViewController: TodoListViewController = makeViewController()
        todoListViewController.service = ServiceFactory.makeTodoListService()
        todoListViewController.viewModel = viewModel ?? ViewModelFactory.makeTodoListViewModel()
        todoListViewController.transitioningDelegate = delegate
        let navigationController = UINavigationController(rootViewController: todoListViewController)
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.backgroundColor = .white
        return navigationController
    }
    
    /// Makes an instance of the 'NewTodoTaskViewController'
    ///
    /// - Parameter viewModel: The view model
    /// - Parameter list: The todo list view model id
    /// - Parameter gradient: The main gradient of the list
    /// - Returns: The instance
    static func makeTodoTaskViewController (WithViewModel viewModel: TodoTaskViewModel?, AndParentViewModel parentViewModel: TodoListViewModel) -> UIViewController {
        let todoTaskViewController: TodoTaskViewController = makeViewController()
        todoTaskViewController.service = ServiceFactory.makeTodoTaskService()
        todoTaskViewController.parentViewModel = parentViewModel
        todoTaskViewController.viewModel = viewModel ?? ViewModelFactory.makeTodoTaskVieModel(forList: parentViewModel.id)
        let navigationController = UINavigationController(rootViewController: todoTaskViewController)
        return navigationController
    }
    
    /// Makes an instance of the 'PasscodeViewController'
    ///
    /// - Parameter gradient: The gradient
    /// - Parameter callback: The callback for entering a passcode
    /// - Returns: The instance
    static func makePasscodeViewController (withGradient gradient: Gradient,
                                            andCallback callback: @escaping ((_ passcode: Int?)->Void)) -> UIViewController {
        let passcodeViewController: PasscodeViewController = makeViewController()
        passcodeViewController.viewModel = ViewModelFactory.makePasscodeViewModel()
        passcodeViewController.gradient = gradient
        passcodeViewController.callback = callback
        return passcodeViewController
    }
    
    /// Makes an instance of the 'PasscodeViewController'
    ///
    /// - Parameters:
    ///   - gradient: The gradient
    ///   - passcode: The passcode
    ///   - callback: The callb ack for entering a passcode (success / failure)
    /// - Returns: The instance
    static func makePasscodeViewController (withGradient gradient: Gradient,
                                            andPasscode passcode: String,
                                            andCallback callback: @escaping (_ success: Bool)->Void) -> UIViewController {
        let passcodeViewController: PasscodeViewController = makeViewController()
        passcodeViewController.viewModel = ViewModelFactory.makePasscodeViewModel(withPasscode: passcode)
        passcodeViewController.gradient = gradient
//        passcodeViewController.callback = callback TODO
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
