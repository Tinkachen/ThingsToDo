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
    
    /// <#Description#>
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    /// The name text field
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    
    /// <#Description#>
    @IBOutlet fileprivate weak var continueToNextScreenButton: UIButton!
    
    // MARK: - Variables
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        continueToNextScreenButton.layer.cornerRadius = continueToNextScreenButton.frame.height / 2
        continueToNextScreenButton.backgroundColor = .white
        
        descriptionLabel.text = Constants.Strings.namePlaceholerKey.localized
        descriptionLabel.textColor = .white
        
        nameTextField.textColor = .lightGray
        nameTextField.delegate = self
    }
    
    // MARK: - Buttons Actions
    
    /// <#Description#>
    @IBAction fileprivate func continueToNextScreen () {
        viewModel.saveUserName(nameTextField.text ?? "")
        let rootViewController = ViewControllerFactory.makeMainViewController()
        self.navigationController?.present(rootViewController, animated: true, completion: nil)
    }
}

// MARK; - UI Text Field Delegate
extension PersonalizeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return false
    }
}
