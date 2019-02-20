//
//  OnboardingViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 15.10.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The private constants
private enum Constants {
    
    /// Informations for the notification request
    enum NotificationRequest {
        
        /// The enable notification title string
        static let enableNotificationTitleString = "OVC_enable_notification".localized
        
        /// The enable notification description string
        static let enableNotificationDescriptionString = "OVC_enable_notification_description".localized
    }
}

/// The onboarding view controller
class OnboardingViewController: UIPageViewController {
    
    // Variables
    
    /// The pages for the UIPageViewController
    lazy var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        createPages()
        
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    /// Creates the pages for the page view controller
    private func createPages () {
        pages = [notificationRequestController()]
    }
    
    // MARK: - Pages
    
    /// Creates the notification request controller
    ///
    /// - Returns: The instance
    private func notificationRequestController () -> UIViewController {
        let gradientImage = CAGradientLayer(size: CGSize(width: 100, height: 100), colors: Theme.apple).createGradientImage()
        let notificationInformation = OnboardingViewModel(image: gradientImage,
                                                          title: Constants.NotificationRequest.enableNotificationTitleString,
                                                          description: Constants.NotificationRequest.enableNotificationDescriptionString)
        
        let notificationViewController = ViewControllerFactory.makeOnboardingViewControllerWith(notificationInformation, andRequestCallback: {
            NotificationService.askForPermissions()
        }) {
            self.showPersonalizeController()
        }
        
        return notificationViewController
    }
    
    /// Shows the personalize view controller for the last step on onboarding
    private func showPersonalizeController () {
        let onboardingPersonalizeViewController = ViewControllerFactory.makePersonalizeViewController()
        self.navigationController?.pushViewController(onboardingPersonalizeViewController, animated: true)
    }
}

// MARK: - UI Page View Controller Data Source
extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard pages.count != nextIndex else { return nil }
        
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
}
