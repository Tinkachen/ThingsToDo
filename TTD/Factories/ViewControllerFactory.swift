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
        let navigationController = UINavigationController(rootViewController: firstStart ? makeOnboardingViewController() : makeMainViewController())
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    /// Makes an instane of the onboarding view controller
    ///
    /// - Returns: The instance
    private static func makeOnboardingViewController () -> UIViewController {
        let onboardingViewController = OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        onboardingViewController.pages = [
            makeOnboardingPersonalizeViewController(),
            makeOnboardingNotificationViewController()
        ]
        return onboardingViewController
    }
    
    /// Makes an instance of the onboarding view controller with view model for requesting a service
    ///
    /// - Parameters:
    ///   - viewModel: The view model
    ///   - request: Callback for the request status
    ///   - next: Callback for the next status
    /// - Returns: The instance
    static func makeOnboardingViewControllerWith (_ viewModel: OnboardingViewModel,
                                                  andRequestCallback request: @escaping (()->Void),
                                                  andNextCallback next: @escaping (()->Void)) -> UIViewController{
        let onboardingViewController: OnboardingRequestViewController = makeViewController()
        onboardingViewController.viewModel = viewModel
        onboardingViewController.setupCallbacks(request: request, next: next)
        
        return onboardingViewController
    }
    
    /// Makes a personalize view controller for onboarding
    ///
    /// - Returns: The instance
    static func makePersonalizeViewController () -> UIViewController {
        let onboardingPersonalizeViewController: OnboardingPersonalizeViewController = makeViewController()
        return onboardingPersonalizeViewController
    }
    
    /// Makes an instance of the 'OnboardingPersonalizeViewController'
    ///
    /// - Returns: The instance
    private static func makeOnboardingPersonalizeViewController () -> UIViewController {
        let onboardingPersonalizeViewController: OnboardingPersonalizeViewController = makeViewController()
        return onboardingPersonalizeViewController
    }
    
    /// Makes an instance of 'OnboardingNotificationViewController'
    ///
    /// - Returns: The instance
    private static func makeOnboardingNotificationViewController () -> UIViewController {
        let onboardingNotificationViewController: OnboardingRequestViewController = makeViewController()
        return onboardingNotificationViewController
    }
    
    /// Makes an instance of the 'MainViewController'
    ///
    /// - Returns: The instance
    static func makeMainViewController () -> UIViewController {
        let mainViewController: MainViewController = makeViewController()
        return mainViewController
    }
    
    /// Makes an instance of 'TodoListViewController' with empty view model
    ///
    /// - Returns: The instance
    static func makeNewTodoListViewController () -> UIViewController {
        let newViewModel = ViewModelFactory.makeTodoListViewModel()
        let todoListViewController = makeCardDetailViewController(WithViewModel: newViewModel)
        return todoListViewController
    }
    
    /// Makes an instance of 'CardContentDetailViewController'
    ///
    /// - Returns: The instance
    static func makeCardDetailViewController (WithViewModel viewModel: TodoListViewModel) -> UIViewController {
        let cardDetailViewController: CardContentDetailViewController = makeViewController()
        cardDetailViewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: cardDetailViewController)
        return navigationController
    }
    
    /// Makes an instance of 'SymbolsViewController' with passed view model information
    ///
    /// - Parameter viewModel: The view model
    /// - Returns: The instance
    static func makeSymbolsViewController (WithViewModel viewModel: TodoListViewModel) -> UIViewController {
        let symbolsViewController: ChangeIdentifierSymbolsViewController = makeViewController()
        symbolsViewController.viewModel = viewModel
        return symbolsViewController
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
        return todoTaskViewController
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
