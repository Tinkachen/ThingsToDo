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
    
    /// Makes the main view controller
    ///
    /// - Returns: The instance
    static func makeMainViewController () -> UIViewController {
        let mainViewController: MainViewController = makeViewController()
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        navigationViewController.isNavigationBarHidden = true
        return navigationViewController
    }
    
    /// Makes the passcode view controller
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
