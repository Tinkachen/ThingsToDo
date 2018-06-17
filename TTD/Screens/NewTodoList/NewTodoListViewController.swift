//
//  NewTodoListViewController.swift
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
        static let viewTitle = NSLocalizedString("NTLVC_title", comment: "The title for the view")
        static let namePlaceholder = NSLocalizedString("NTLVC_name_placeholer", comment: "The place holder for the todo list name")
        static let chooseGradient = NSLocalizedString("NTLVC_choose_gradient", comment: "The text for choosing a gradient")
        static let chooseIcon = NSLocalizedString("NTLVC_choose_icon", comment: "The text for choosing an icon")
        static let secureWithPasscode = NSLocalizedString("NTLVC_secure_passcode", comment: "The text to secure the todo list with a passcode")
    }
}

/// Interface for creating a new todo list
class NewTodoListViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The text field for the todo list name
    @IBOutlet fileprivate weak var nameTextField: SkyFloatingLabelTextField!
    
    // MARK: - Variables
    
    /// The service
    var service: NewTodoListService!
    
    // The view model
    var viewModel: TodoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    
    /// Presents a view for selecting a icon for the todo list
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func chooseIconButtonPressed (_ sender: UIButton) {
        
    }
    
    /// Presents a view for selecting a gradient for the todo list
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func chooseGradientButtonPressed (_ sender: UIButton) {
        
    }
    
    /// Presents the 'TodoTaskViewController', to add a new task to the todo list
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addTasksButtonPressed (_ sender: UIButton) {
        let newTodoTaskViewController = ViewControllerFactory.makeTodoTaskViewController(WithViewModel: nil)
        self.navigationController?.pushViewController(newTodoTaskViewController, animated: true)
    }
    
    /// Secures the todo list with a passcode
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func saveWithPasscodeToggleSwitched (_ sender: UISwitch) {
        
    }
}
