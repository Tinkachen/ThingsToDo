//
//  OnboardingViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 06.09.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit
import UserNotifications

/// <#Description#>
private enum Constants {
    
    /// <#Description#>
    static let enableNotificationButtonTitleKey = "OVC_enable_notification"
    
    /// <#Description#>
    static let enableNotificationsDescriptionKey = "OVC_enable_notification_description"
}

class OnboardingViewController: UIViewController {
    
    // Outlets
    
    /// <#Description#>
    @IBOutlet fileprivate weak var enableNotificationButton: UIButton!
    
    /// <#Description#>
    @IBOutlet fileprivate weak var enableNotificationDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        enableNotificationDescriptionLabel.text = Constants.enableNotificationsDescriptionKey.localized
        
        enableNotificationButton.setTitle(Constants.enableNotificationButtonTitleKey.localized, for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction fileprivate func enableNotificationButtonPressed () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (enabled, error) in
        }
    }
    
    @IBAction fileprivate func continueToNextScreen () {
        let personalizeViewController = ViewControllerFactory.makePersonalizeViewController()
        self.navigationController?.pushViewController(personalizeViewController, animated: true)
    }
}
