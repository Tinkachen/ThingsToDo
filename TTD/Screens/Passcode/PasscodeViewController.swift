//
//  PasscodeViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 08.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private Constants of the class
private enum Constants {
    
    /// Strings for the outlets
    enum Strings {
        static let cancelButtonText = NSLocalizedString("PCVC_cancel_btn", comment: "Cancel button text")
    }
}

/// Screen for setting and entering a pin (Shortcut PCVC)
class PasscodeViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Title for the screen
    @IBOutlet fileprivate var titleLabel: UILabel!
    
    /// Button for the cancel action
    @IBOutlet fileprivate var cancelButton: UIButton!
    
    /// The stack view (container) of the pin indicators
    @IBOutlet fileprivate var indicatorStackView: UIStackView!
    
    /// The indicators for the pin
    @IBOutlet fileprivate var indicatorView: [UIView]!
    
    // MARK: - Variables
    
    /// The view model
    private var viewModel: PasscodeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Button Actions
    
    /// Cancel action for the screen
    ///
    /// - Parameter sender: The sender of the action
    @IBAction fileprivate func cancelButtonAction (_ sender: UIButton) {
        
    }
    
    /// The action for the passcode button
    ///
    /// - Parameter sender: The sender of the action
    @IBAction fileprivate func passcodeButtonAction (_ sender: PasscodeButton) {
        
    }
    
    // MARK: - Private helper functions
    
    /// Dismisses the passcode view
    private func dismissPasscodeView () {
        self.dismiss(animated: true, completion: nil)
    }
}
