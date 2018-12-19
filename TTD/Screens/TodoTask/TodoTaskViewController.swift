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
        static let descriptionTextKey = "TTVC_description".localized
        
        /// The title for the view
        static let viewTitleKey = "TTVC_title".localized
        
        /// The placeholder for the name
        static let namePlaceholderKey = "TTVC_name_placeholer".localized
        
        /// The placeholder for the notes
        static let notesPlaceholderKey = "TTVC_notes_placeholder".localized
        
        /// The text for the reminder
        static let reminderTextKey = "TTVC_reminder".localized
        
        /// The priority localization key
        static let priorityTextKey = "TTVC_priority".localized
        
        /// The note localization key
        static let noteTextKey = "TTVC_note".localized
        
        /// The done localized key
        static let pickerDoneKey = "TTVC_picker_done".localized
    }
    
    /// The animation duration for showing/hiding the picker
    static let animationDuration = 0.3
    
    /// The size of the button
    static let buttonSize = CGSize(width: 44, height: 44)
    
    /// The default height for the date picker
    static let scheduleDatePickerDefaultHeightConstraintConstant: CGFloat = 162
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
    
    // Schedule Picker
    @IBOutlet fileprivate weak var scheduleDatePickerContainerView: UIView!
    @IBOutlet fileprivate weak var scheduleDatePicker: UIDatePicker!
    @IBOutlet fileprivate weak var scheduleDatePickerHeightConstraint: NSLayoutConstraint!
    
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
    @IBOutlet fileprivate weak var notesHeaderContainerView: UIView!
    @IBOutlet fileprivate weak var notesTextView: UITextView!
    @IBOutlet fileprivate weak var noteTitleLabel: UILabel!
    @IBOutlet fileprivate weak var noteImageView: UIImageView!
    @IBOutlet fileprivate weak var notesContainerView: UIView!
    
    // MARK: - Variables
    
    /// The service
    var service: TodoTaskService!
    
    /// The view model
    var viewModel: TodoTaskViewModel!
    
    /// The view model of the parent todo list
    var parentViewModel: TodoListViewModel!
    
    /// Indicator if the schedule date picker is visibile
    var isScheduleDatePickerHidden = true
    
    /// Indicator if the notes section is visible
    var isNotesHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        registerNotifications()
        
        setupTopic()
        setupPriority()
        setupReminder()
        setupSchedule()
        setupScheduleDatePicker()
        setupNote()
        
        nameTextField.delegate = self
        nameTextField.text = viewModel.taskDescription
        nameTextField.tintColor = parentViewModel.getMainColor()
        if viewModel.taskDescription.isEmpty {
            nameTextField.becomeFirstResponder()
        }

        notesTextView.delegate = self
        showPlaceholderInTextInput(viewModel.notes != "" ? false : true)
        
        descriptionLabel.text = Constants.Strings.descriptionTextKey
        descriptionLabel.textColor = .midGray
        
        // Hide schedule date picker for start
        shouldHideScheduleDatePicker(isScheduleDatePickerHidden)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        nameTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        
        super.viewWillDisappear(animated)
    }
    
    private func setupNavigationBar () {
        self.navigationController?.navigationBar.isHidden = false
        let closeItem = UIBarButtonItem(image: Constants.Images.closeIcon, style: .plain, target: self, action: #selector(closeButtonPressed))
        closeItem.tintColor = .midGray
        self.navigationItem.leftBarButtonItem = closeItem
        
        self.title = Constants.Strings.viewTitleKey
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    /// Registers the notification services
    private func registerNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShows(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHides(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /// Prep the text view with place holder design or with text input design
    ///
    /// - Parameter show: Shows the placeholder or not
    fileprivate func showPlaceholderInTextInput (_ show: Bool) {
        if show {
            viewModel.notes = ""
            notesTextView.text = Constants.Strings.notesPlaceholderKey
            notesTextView.textColor = .midGray
        } else {
            notesTextView.text = notesTextView.text == Constants.Strings.notesPlaceholderKey ? "" : viewModel.notes
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
        scheduleTitleLabel.text = viewModel.formattedSavedDate()
        scheduleTitleLabel.textColor = .midGray
        scheduleImageView.image = Constants.Images.calendarIcon
        scheduleImageView.tintColor = .midGray
    }
    
    /// Setup the schedule date picker informations
    private func setupScheduleDatePicker () {
        scheduleDatePicker.date = viewModel.taskEndDate
        scheduleDatePicker.addTarget(self, action: #selector(scheduleDatePickerValueChanged(_:)), for: .valueChanged)
    }
    
    /// Called when the value of the schedule date picker did change
    ///
    /// - Parameter sender: The sender of the event
    @objc private func scheduleDatePickerValueChanged (_ sender: UIDatePicker) {
        viewModel.taskEndDate = sender.date
        scheduleTitleLabel.text = viewModel.formattedSavedDate()
    }
    
    /// Called when the schedule container was touched
    @objc private func schedulePressed () {
        isScheduleDatePickerHidden = !isScheduleDatePickerHidden
        shouldHideScheduleDatePicker(isScheduleDatePickerHidden)
    }
    
    /// Hides or shows the date picker
    ///
    /// - Parameter hide: Indicator if the picker should hide
    private func shouldHideScheduleDatePicker (_ hide: Bool) {
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.scheduleDatePickerHeightConstraint.constant = hide ? 0 : Constants.scheduleDatePickerDefaultHeightConstraintConstant
            self.scheduleDatePickerContainerView.isHidden = hide
            self.scheduleDatePicker.isHidden = hide
        })
    }
    
    /// Setup the reminder informations
    private func setupReminder () {
        NotificationService.isNotificationGranted { (granted) in
            DispatchQueue.main.async {
                if granted {
                    self.reminderTitleLabel.text = Constants.Strings.reminderTextKey
                    self.reminderTitleLabel.textColor = .midGray
                    self.reminderImageView.image = Constants.Images.remimderIcon
                    self.reminderImageView.tintColor = .midGray
                    self.reminderSwitch.onTintColor = self.parentViewModel.getMainColor()
                    self.reminderSwitch.setOn(self.viewModel.isTimerSet, animated: true)
                } else {
                    self.reminderContainerView.isHidden = true
                }
            }
        }
    }
    
    /// Called when the switch value changed
    ///
    /// - Parameter sender: The switch
    @IBAction fileprivate func reminderSwitchChanged (_ sender: UISwitch) {
        viewModel.isTimerSet = sender.isOn
    }
    
    /// Setup priority
    private func setupPriority () {
        priorityTitleLabel.text = Constants.Strings.priorityTextKey
        priorityTitleLabel.textColor = .midGray
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
        noteTitleLabel.text = Constants.Strings.noteTextKey
        noteTitleLabel.textColor = .midGray
        noteImageView.image = Constants.Images.noteIcon
        noteImageView.tintColor = .midGray
    
        notesTextView.tintColor = parentViewModel.getMainColor()
    }
    
    // MARK: - Actions
    
    /// Called when the close button in the navigation bar is pressed
    @objc private func closeButtonPressed () {
        viewModel.taskDescription = nameTextField.text ?? ""
        
        if !(viewModel.taskDescription.isEmpty) && (viewModel.taskDescription != Constants.Strings.namePlaceholderKey) {
            viewModel.updateTaskViewModel()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Keyboard Notification Actions
    
    /// Observer call when the keyboard will be shown
    ///
    /// - Parameter notification: The notification
    @objc private func keyboardShows (notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            scrollView.setContentOffset(CGPoint(x: 0, y: <#T##Double#>), animated: true)
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
        return false
    }
    
}

// MARK: - Extension Text View Delegate
extension TodoTaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        showPlaceholderInTextInput(false)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.notes = textView.text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            showPlaceholderInTextInput(true)
        }
    }
}
