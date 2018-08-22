//
//  PersonalizeViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 21.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private Constants of the class
private enum Constants {
    
    /// Strings for the outlets
    enum Strings {
        static let namePlaceholerKey = "PVC_name_placeholder"
    }
}

/// Registration screen for setting user name (only shown if there is no name in userdefaults)
class PersonalizeViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The name text field
    @IBOutlet fileprivate weak var nameTextField: SkyFloatingLabelTextField!
    
    /// The image view for the user image
    @IBOutlet fileprivate weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Buttons Actions
    
    /// Adds or updates the image of the user
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addImage (_ sender: UIButton) {
        
    }
}
