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
    
    /// Constant images
    enum Images {
        
        /// The close icon
        static let closeIcon = #imageLiteral(resourceName: "CloseIcon")
        
        /// The reminder icon
        static let remimderIcon = #imageLiteral(resourceName: "timer")
        
        /// The calendar icon
        static let calendarIcon = #imageLiteral(resourceName: "calendar")
        
        /// The priority icon
        static let priorityIcon = #imageLiteral(resourceName: "exclaration_mark")
        
        /// The note icon
        static let noteIcon = #imageLiteral(resourceName: "note")
    }
    
    /// Strings for the outlets
    enum Strings {
        
        /// The description text
        static let descriptionTextKey = "NTTVC_description"
        
        /// The title for the view
        static let viewTitleKey = "NTTVC_title"
        
        /// The placeholder for the name
        static let namePlaceholderKey = "NTTVC_name_placeholer"
        
        /// The placeholder for the notes
        static let notesPlaceholderKey = "NTTVC_notes_placeholder"
        
        /// The text for the reminder
        static let reminderTextKey = "NTTVC_reminder"
        
        /// The priority localization key
        static let priorityTextKey = "NTTVC_priority"
        
        /// The note localization key
        static let noteTextKey = "NTTVC_note"
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
    
    /// The scroll view
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    
    /// The description label
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    /// The text field for the name of the todo task
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    
    /// Topic
    @IBOutlet fileprivate weak var topicContainerView: UIView!
    @IBOutlet fileprivate weak var topicImageView: UIImageView!
    @IBOutlet fileprivate weak var topicTitleLabel: UILabel!
    
    // Schedule
    @IBOutlet fileprivate weak var scheduleContainerView: UIView!
    @IBOutlet fileprivate weak var scheduleTitleLabel: UILabel!
    @IBOutlet fileprivate weak var scheduleImageView: UIImageView!
    
    // Reminder
    @IBOutlet fileprivate weak var reminderContainerView: UIView!
    @IBOutlet fileprivate weak var reminderImageView: UIImageView!
    @IBOutlet fileprivate weak var reminderTitleLabel: UILabel!
    @IBOutlet fileprivate weak var reminderSwitch: UISwitch!
    
    // Priority
    @IBOutlet fileprivate weak var priorityContainerView: UIView!
    @IBOutlet fileprivate weak var priorityImageView: UIImageView!
    @IBOutlet fileprivate weak var priorityTitleLabel: UILabel!
    @IBOutlet fileprivate weak var prioritySegmentedControl: UISegmentedControl!
    
    /// Note
    @IBOutlet fileprivate weak var notesTextView: UITextView!
    @IBOutlet fileprivate weak var noteTitleLabel: UILabel!
    @IBOutlet fileprivate weak var noteImageView: UIImageView!
    
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
    
    /// The view model of the parent todo list
    var parentViewModel: TodoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        applyLayoutForFloatingButton()
        
        registerNotifications()
        
        setupTopic()
        setupPriority()
        setupReminder()
        setupSchedule()
        setupNote()
        
        nameTextField.delegate = self
        nameTextField.text = viewModel.taskDescription
        nameTextField.tintColor = parentViewModel.getMainColor()
        if viewModel.taskDescription.isEmpty {
            nameTextField.becomeFirstResponder()
        }

        notesTextView.delegate = self
        showPlaceholderIntextInput(viewModel.notes != "" ? false : true)
        
        descriptionLabel.text = Constants.Strings.descriptionTextKey.localized
        descriptionLabel.textColor = .midGray
    }
    
    private func setupNavigationBar () {
        self.navigationController?.navigationBar.isHidden = false
        let closeItem = UIBarButtonItem(image: Constants.Images.closeIcon, style: .plain, target: self, action: #selector(closeButtonPressed))
        closeItem.tintColor = .midGray
        self.navigationItem.leftBarButtonItem = closeItem
        
        self.title = Constants.Strings.viewTitleKey.localized
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    /// Applies the layout for the floating button
    private func applyLayoutForFloatingButton (_ round: Bool = true) {
        if round {
            floatingButton.layer.cornerRadius = floatingButton.bounds.height / 2
            floatingButton.applyGradient(colors: parentViewModel.getGradient(), WithCornerRadius: floatingButton.layer.cornerRadius)
            floatingButton.layer.borderWidth = 1.0
            floatingButton.layer.borderColor = UIColor.lightGray.cgColor
            floatingButton.layer.shadowColor = UIColor.black.cgColor
            floatingButton.layer.shadowOpacity = 0.5
            floatingButton.layer.shadowOffset = CGSize(width: 0, height: 1)
            floatingButton.layer.shadowRadius = 5
        } else {
            floatingButton.layer.cornerRadius = 0
            floatingButton.applyGradient(colors: parentViewModel.getGradient())
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
    
    /// Prep the text view with place holder design or with text input design
    ///
    /// - Parameter show: Shows the placeholder or not
    fileprivate func showPlaceholderIntextInput (_ show: Bool) {
        if show {
            viewModel.notes = ""
            notesTextView.text = Constants.Strings.notesPlaceholderKey.localized
            notesTextView.textColor = .midGray
        } else {
            viewModel.notes = notesTextView.text
            notesTextView.text = notesTextView.text == Constants.Strings.notesPlaceholderKey.localized ? "" : notesTextView.text
            notesTextView.textColor = .black
        }
    }
    
    /// Setup the topic informations
    private func setupTopic () {
        topicTitleLabel.text = parentViewModel.title
        topicTitleLabel.textColor = .midGray
        topicImageView.image = parentViewModel.image()
        topicImageView.tintColor = .midGray
    }
    
    /// Setup the schedule informations
    private func setupSchedule () {
        scheduleContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(schedulePressed)))
        scheduleTitleLabel.text = "Test"
        scheduleTitleLabel.textColor = .midGray
        scheduleImageView.image = Constants.Images.calendarIcon
        scheduleImageView.tintColor = .midGray
    }
    
    /// Called when the schedule container was touched
    @objc private func schedulePressed () {
        
    }
    
    /// Setup the reminder informations
    private func setupReminder () {
        reminderTitleLabel.text = Constants.Strings.reminderTextKey.localized
        reminderTitleLabel.textColor = .midGray
        reminderImageView.image = Constants.Images.remimderIcon
        reminderImageView.tintColor = .midGray
        reminderSwitch.onTintColor = parentViewModel.getMainColor()
        reminderSwitch.setOn(viewModel.isTimerSet, animated: true)
    }
    
    /// Called when the switch value changed
    ///
    /// - Parameter sender: The switch
    @IBAction fileprivate func reminderSwitchChanged (_ sender: UISwitch) {
        viewModel.isTimerSet = sender.isOn
    }
    
    /// Setup priority
    private func setupPriority () {
        priorityTitleLabel.text = Constants.Strings.priorityTextKey.localized
        priorityImageView.image = Constants.Images.priorityIcon
        priorityImageView.tintColor = .midGray
        prioritySegmentedControl.tintColor = parentViewModel.getMainColor()
        prioritySegmentedControl.selectedSegmentIndex = viewModel.priority.rawValue
    }
    
    /// Called when the segmented control did change
    ///
    /// - Parameter sender: The segmented conrtrol
    @IBAction fileprivate func segmentedChanged (_ sender: UISegmentedControl) {
        viewModel.priority = PriorityLevel(rawValue: sender.selectedSegmentIndex)
    }
    
    /// Setup the note
    private func setupNote () {
        noteTitleLabel.text = Constants.Strings.noteTextKey.localized
        noteTitleLabel.textColor = .midGray
        noteImageView.image = Constants.Images.noteIcon
        noteImageView.tintColor = .midGray
    }
    
    // MARK: - Actions
    
    /// Called when the close button in the navigation bar is pressed
    @objc private func closeButtonPressed () {
        viewModel.taskDescription = nameTextField.text ?? ""
        
        if !(viewModel.taskDescription.isEmpty) && (viewModel.taskDescription != Constants.Strings.namePlaceholderKey.localized) {
            viewModel.updateTaskViewModel()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Adds the created task to the todo list
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addNewTaskButtonPressed (_ sender: UIButton) {
        nameTextField.resignFirstResponder()
        viewModel.updateTaskViewModel()
    }
    
    // MARK: - Keyboard Notification Actions
    
    /// Observer call when the keyboard will be shown
    ///
    /// - Parameter notification: The notification
    @objc private func keyboardShows (notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            animateFloat(forKeyboardSize: keyboardSize)
        }
    }
    
    /// Animates the floating button to the new position
    ///
    /// - Parameter keyboardSize: The size of the keyboard
    private func animateFloat (forKeyboardSize keyboardSize: CGRect) {
//        UIView.animate(withDuration: 0.25, animations: {
//            self.floatingButtonBottomConstraint.constant = keyboardSize.height + Constants.buttonSize.height
//            self.floatingButtonAspectRatioConstraint.constant = 1
//            self.floatingButtonLeadingConstraint.isActive = true
//            self.floatingButtonTrailingConstraint.constant = 0
////            self.floatingButton.applyGradient(colors: Themes.getTheme(self.gradient).gradient, WithCornerRadius: self.floatingButton.layer.cornerRadius)
//            self.floatingButton.setImage(CAGradientLayer(frame: self.floatingButton.frame, colors: Themes.getTheme(self.gradient).gradient).createGradientImage(), for: .normal)
//            self.applyLayoutForFloatingButton(false)
//
//            self.view.layoutIfNeeded()
//        }) { (complete) in
//            self.floatingButton.applyGradient(colors: Themes.getTheme(self.gradient).gradient)
//        }
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
        return false
    }
    
}

// MARK: - Extension Text View Delegate
extension TodoTaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        showPlaceholderIntextInput(false)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            showPlaceholderIntextInput(true)
        } else {
            viewModel.notes = textView.text
        }
    }
}
