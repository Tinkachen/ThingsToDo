//
//  NewTodoTaskViewController.swift
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
        static let viewTitle = NSLocalizedString("NTTVC_title", comment: "The title for the view")
        static let namePlaceholder = NSLocalizedString("NTTVC_name_placeholer", comment: "The placeholder for the task name")
        static let notesPlaceholder = NSLocalizedString("NTTVC_notes_placeholder", comment: "The placeholder for the notes")
    }
}

/// Interface for creating a new task for a todo list
class NewTodoTaskViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The text field for the name of the todo task
    @IBOutlet fileprivate weak var nameTextField: SkyFloatingLabelTextField!
    
    /// The image view for the list icon
    @IBOutlet fileprivate weak var listIconImageView: UIImageView!
    
    /// The name of the todo list
    @IBOutlet fileprivate weak var listNameLabel: UILabel!
    
    /// The text view for notes
    @IBOutlet fileprivate weak var notesTextView: UITextView!
    
    
    // MARK: - Variables
    
    /// The view model
    var viewModel: NewTodoTaskViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    
    /// Adds the created task to the todo list
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addNewTaskButtonPressed (_ sender: UIButton) {
        
    }
    
    /// Opens a picker for selecting a date and time
    /// when the task should be done
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func updateScheduleButtonPressed (_ sender: UIButton) {
        
    }
}
