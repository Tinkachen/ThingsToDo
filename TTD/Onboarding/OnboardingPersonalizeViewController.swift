//
//  OnboardingPersonalizeViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 15.10.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The string for the title label
    static let titleLabelString = "PVC_title".localized
    
    /// The string for the name text field
    static let nameFieldPlaceholderString = "PVC_name_placeholder".localized
    
    /// The title string for the ready button
    static let readyButtonTitle = "PVC_ready_button_title".localized
}

/// Personalizing onboarding view controller
class OnboardingPersonalizeViewController: UIViewController {
    
    // Outlets
    
    /// The scroll view
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    
    /// The image button
    @IBOutlet fileprivate weak var imageButton: UserImageButton!
    
    /// The title label
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    /// The name text field
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    
    /// The ready button
    @IBOutlet fileprivate weak var readyButton: UIButton!
    
    /// The content height layout constraint
    @IBOutlet fileprivate weak var contentHeightConstraint: NSLayoutConstraint!
    
    // Variables
    
    /// The last offset of the scroll view
    var lastOffset = CGPoint(x: 0, y: 0)
    
    /// The height of the keyboard
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
        registerNotifications()
        
        // Set text field delegate
        nameTextField.delegate = self
    }
    
    /// Layouts the view elements and fill them with data
    private func layoutView () {
        
        self.titleLabel.text = Constants.titleLabelString
        
        self.nameTextField.placeholder = Constants.nameFieldPlaceholderString
        
        self.readyButton.setTitle(Constants.readyButtonTitle, for: .normal)
    }
    
    /// Registers the notification needed for the screen
    private func registerNotifications () {
        // Observe keyboard change
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    // Actions
    
    /// Called when the image button was pressed
    @IBAction fileprivate func imageButtonPressed () {
        
    }
    
    /// Called when the ready button was pressed
    @IBAction fileprivate func readyButtonPressed () {
        let mainViewController = ViewControllerFactory.makeMainViewController()
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
}

// MARK: - UI Text Field Delegate
extension OnboardingPersonalizeViewController: UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        lastOffset = scrollView.contentOffset
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - Keyboard handling

extension OnboardingPersonalizeViewController {
    
    /// Called when the key board will be shown
    ///
    /// - Parameter notification: The notification
    @objc private func keyboardWillShow (_ notification: NSNotification) {

        guard keyboardHeight != nil else { return }
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.contentHeightConstraint.constant += self.keyboardHeight
            })
            // move if keyboard hide input field
            let distanceToBottom = self.scrollView.frame.size.height - (nameTextField.frame.origin.y) - (nameTextField.frame.size.height)
            let collapseSpace = keyboardHeight - distanceToBottom
            if collapseSpace < 0 {
                // no collapse
                return
            }
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 points
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
            })
        }
    }
    
    /// Called when the keyboard will be hidden
    ///
    /// - Parameter notification: The notification
    @objc private func keyboardWillHide (_ notification: NSNotification) {
        guard keyboardHeight != nil else { return }
        UIView.animate(withDuration: 0.3) {
            self.contentHeightConstraint.constant -= self.keyboardHeight
            self.scrollView.contentOffset = self.lastOffset
        }
        keyboardHeight = nil
    }
}
