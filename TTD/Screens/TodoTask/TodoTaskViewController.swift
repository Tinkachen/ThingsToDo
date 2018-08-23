//
//  TodoTaskViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 11.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// Strings for the outlets
    enum Strings {
        
        /// The title for the view
        static let viewTitleKey = "NTTVC_title"
        
        /// The placeholder for the name
        static let namePlaceholderKey = "NTTVC_name_placeholer"
        
        /// The placeholder for the notes
        static let notesPlaceholderKey = "NTTVC_notes_placeholder"
    }
    
    /// The size of the button
    static let buttonSize = CGSize(width: 44, height: 44)
    
    /// The bottom constraint of the floating button
    static let floatingButtonBottomConstraintConstant: CGFloat = 100
    
    /// The trailing constraint of the floating button
    static let floatingButtonTrailingConstraintConstant: CGFloat = 25
}

/// Interface for creating a new task for a todo list
class TodoTaskViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The text field for the name of the todo task
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    
    /// The image view for the list icon
    @IBOutlet fileprivate weak var listIconImageView: UIImageView!
    
    /// The name of the todo list
    @IBOutlet fileprivate weak var listNameLabel: UILabel!
    
    /// The text view for notes
    @IBOutlet fileprivate weak var notesTextView: UITextView!
    
    /// The floating button
    @IBOutlet fileprivate weak var floatingButton: UIButton!
    
    /// The floating button bottom constraint
    @IBOutlet fileprivate weak var floatingButtonBottomConstraint: NSLayoutConstraint!
    
    /// The floating button aspect ration constraint
    @IBOutlet fileprivate weak var floatingButtonAspectRatioConstraint: NSLayoutConstraint!
    
    /// The floating button leading constraint
    @IBOutlet fileprivate weak var floatingButtonLeadingConstraint: NSLayoutConstraint!
    
    /// The floating button trailing constraint
    @IBOutlet fileprivate weak var floatingButtonTrailingConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    
    /// The service
    var service: TodoTaskService!
    
    /// The view model
    var viewModel: TodoTaskViewModel!
    
    /// The gradient
    var gradient: Gradient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        applyLayoutForFloatingButton()
        
        registerNotifications()
        
        nameTextField.delegate = self
        
    }
    
    /// Applies the layout for the floating button
    private func applyLayoutForFloatingButton (_ round: Bool = true) {
        if round {
            floatingButton.layer.cornerRadius = floatingButton.bounds.height / 2
            floatingButton.applyGradient(colors: Themes.getTheme(gradient).gradient, WithCornerRadius: floatingButton.layer.cornerRadius)
            floatingButton.layer.borderWidth = 1.0
            floatingButton.layer.borderColor = UIColor.lightGray.cgColor
            floatingButton.layer.shadowColor = UIColor.black.cgColor
            floatingButton.layer.shadowOpacity = 0.5
            floatingButton.layer.shadowOffset = CGSize(width: 0, height: 1)
            floatingButton.layer.shadowRadius = 5
        } else {
            floatingButton.layer.cornerRadius = 0
            floatingButton.applyGradient(colors: Themes.getTheme(gradient).gradient)
            floatingButton.layer.borderWidth = 0
            floatingButton.layer.borderColor = UIColor.clear.cgColor
            floatingButton.layer.shadowRadius = 0
        }
    }
    
    
    /// Registers the notification services
    private func registerNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShows(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHides(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Actions
    
    /// Adds the created task to the todo list
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addNewTaskButtonPressed (_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Opens a picker for selecting a date and time
    /// when the task should be done
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func updateScheduleButtonPressed (_ sender: UIButton) {
        
    }
    
    // MARK: - Keyboard Notification Actions
    
    /// Observer call when the keyboard will be shown
    ///
    /// - Parameter notification: The notification
    @objc private func keyboardShows (notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            animateFloat(forKeyboardSize: keyboardSize)
            print("Ich wurde gezeigt")
        }
    }
    
    /// Animates the floating button to the new position
    ///
    /// - Parameter keyboardSize: The size of the keyboard
    private func animateFloat (forKeyboardSize keyboardSize: CGRect) {
        UIView.animate(withDuration: 0.25, animations: {
            self.floatingButtonBottomConstraint.constant = keyboardSize.height + Constants.buttonSize.height
            self.floatingButtonAspectRatioConstraint.isActive = false
            self.floatingButtonLeadingConstraint.isActive = true
            self.floatingButtonTrailingConstraint.constant = 0
//            self.floatingButton.applyGradient(colors: Themes.getTheme(self.gradient).gradient, WithCornerRadius: self.floatingButton.layer.cornerRadius)
            self.floatingButton.setImage(CAGradientLayer(frame: self.floatingButton.frame, colors: Themes.getTheme(self.gradient).gradient).createGradientImage(), for: .normal)
            self.applyLayoutForFloatingButton(false)
            
            self.view.layoutIfNeeded()
        }) { (complete) in
            self.floatingButton.applyGradient(colors: Themes.getTheme(self.gradient).gradient)
        }
    }
    
    /// Observer call when the keybaord will be hidden
    ///
    /// - Parameter notification: The notification
    @objc private func keyboardHides (notification: Notification) {
        
    }
}

// MARK: Text Field Delegate
extension TodoTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
