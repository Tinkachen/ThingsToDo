//
//  TodoListViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 11.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// Informations for the table view
    enum TableView {
        
        /// The identifier of the header
        static let headerCellId = "TodoTaskHeaderCell"
        
        /// The header height
        static let headerCellHeight: CGFloat = 20
        
        /// The identifier of the table view cell
        static let todoTaskTableViewCellId = "TodoTaskTableViewCell"
        
        /// The table view cell height
        static let todoTaskTableViewCellHeight: CGFloat = 50
    }
    
    /// Constant images
    enum Images {
        
        /// The back arrow icon
        static let backArrowIcon = #imageLiteral(resourceName: "back_arrow")
        
        /// The more icon
        static let moreIcon = #imageLiteral(resourceName: "more_dots")
        
        /// The lcok icon
        static let lockItem = #imageLiteral(resourceName: "Lock")
        
        /// The unlock icon
        static let unlockItem = #imageLiteral(resourceName: "Unlock")
    }
    
    /// Localized strings for the view
    enum Strings {
        
        /// The title for the view
        static let viewTitleKey = "NTLVC_title"
        
        /// The placeholder for the name of the todo list
        static let namePlaceholderKey = "NTLVC_name_placeholer"
        
        /// The text for choosing a gradient
        static let chooseGradientKey = "NTLVC_choose_gradient"
        
        /// The text for choosing an icon
        static let chooseIconKey = "NTLVC_choose_icon"
        
        /// The task text
        static let tasksKey = "NTLVC_tasks"
        
        /// The text to secure the todo list with a passcode
        static let secureWithPasscodeKey = "NTLVC_secure_passcode"
        
        /// Alert Strings
        
        /// The title for the alert
        static let alertTitleKey = "NTLVC_alert_title"
        
        /// The gradient alert action name
        static let alertChangeGradientKey = "NTLVC_alert_change_gradient"
        
        /// The lock alert action name
        static let alertLockListKey = "NTLVC_alert_lock_list"
        
        /// The cancel alert action name
        static let alertCancelKey = "NTLVC_alert_cancel"
    }
    
    /// The bottom constraint constant for the floating button
    static let foatingButtonBottomConstraint: CGFloat = 100
    
    /// The height of the progress bar
    static let progressBarHeight: CGFloat = 5
}

/// Interface for creating a new todo list
class TodoListViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The container view for the icon
    @IBOutlet fileprivate weak var iconContainer: UIView!
    
    /// The image view for the icon
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    
    /// The container for the gradient
    @IBOutlet fileprivate weak var gradientContainer: UIView!
    
    /// The label for the task description
    @IBOutlet fileprivate weak var taskLabel: UILabel!
    
    /// The text field for the todo list name
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    
    /// The button for enable or disable passcode security
    @IBOutlet fileprivate weak var passcodeButton: UIButton!
    
    /// The progress view
    @IBOutlet fileprivate weak var progressBar: UIProgressView!
    
    /// The progress percent label
    @IBOutlet fileprivate weak var progressPercentLabel: UILabel!
    
    /// The table view
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    /// The button to add a new todo task
    @IBOutlet fileprivate weak var addTodoTaskFloatingButton: UIButton!
    
    /// The bottom constraint of the floating button
    @IBOutlet fileprivate weak var addTodoTaskFloatingButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    /// The service
    var service: TodoListService!
    
    // The view model
    var viewModel: TodoListViewModel!
    
    /// The sorted tasks form the view model
    var sortedTaskViewModel: [Date : [TodoTaskViewModel]] {
        var sorted = [Date : [TodoTaskViewModel]]()
        guard let tasks = viewModel.tasks else { return sorted }
        sorted = Dictionary(grouping: tasks, by: { $0.dateForSorting() })
        return sorted
    }
    
    /// A date formatter
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        // Setup Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.TableView.todoTaskTableViewCellId, bundle: nil), forCellReuseIdentifier: Constants.TableView.todoTaskTableViewCellId)
        tableView.register(UINib(nibName: Constants.TableView.headerCellId, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.TableView.headerCellId)
        
        // Add gesture recognizer to views
        iconContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseIconPressed)))
        gradientContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseGradientPressed)))
        
        // Apply layout to floating button
        applyLayoutForFloatingButton()
        
        // Setup view with view model
        setupViewWithViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.updateTasks()
        tableView.reloadData()
    }
    
    /// Sets up the navigation bar
    private func setupNavigationBar () {
        let closeItem = UIBarButtonItem(image: Constants.Images.backArrowIcon, style: .plain, target: self, action: #selector(closeButtonPressed))
        closeItem.tintColor = .midGray
        self.navigationItem.leftBarButtonItem = closeItem
        
        let moreItem = UIBarButtonItem(image: Constants.Images.moreIcon, style: .plain, target: self, action: #selector(moreButtonPressed))
        moreItem.tintColor = .midGray
        self.navigationItem.rightBarButtonItem = moreItem
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    /// Setup the view with the passed view model
    private func setupViewWithViewModel () {
        
        // Title
        self.nameTextField.text = viewModel.title
        self.nameTextField.delegate = self
        self.nameTextField.tintColor = viewModel.getMainColor()
        
        // Gradient
        self.gradientContainer.applyGradient(colors: Themes.getTheme(viewModel.gradient).gradient, WithCornerRadius: self.gradientContainer.bounds.height / 2)
        self.gradientContainer.layer.cornerRadius = self.gradientContainer.bounds.height / 2
        self.gradientContainer.layer.borderColor = UIColor.lightGray.cgColor
        self.gradientContainer.layer.borderWidth = 1.0
        
        // Icon
        self.iconContainer.layer.cornerRadius = self.iconContainer.frame.width / 2
        self.iconContainer.layer.borderColor = UIColor.lightGray.cgColor
        self.iconContainer.layer.borderWidth = 1.0
        self.iconImageView.image = Icons.getIcon(viewModel.icon)
        self.iconImageView.tintColor = viewModel.getMainColor()
        
        // Tasks
        self.taskLabel.text = "\(viewModel.tasks?.count ?? 0) \(Constants.Strings.tasksKey.localized)"
        
        applyProgressBarLayout()
        applyPasscodeButtonLayout()
    }
    
    /// Applies the layout for the floating button
    private func applyLayoutForFloatingButton () {
        addTodoTaskFloatingButton.layer.cornerRadius = addTodoTaskFloatingButton.bounds.height / 2
        addTodoTaskFloatingButton.removeGradientLayer()
        addTodoTaskFloatingButton.applyGradient(colors: Themes.getTheme(viewModel.gradient).gradient, WithCornerRadius: addTodoTaskFloatingButton.layer.cornerRadius)
        addTodoTaskFloatingButton.layer.borderWidth = 1.0
        addTodoTaskFloatingButton.layer.borderColor = UIColor.lightGray.cgColor
        addTodoTaskFloatingButton.layer.shadowColor = UIColor.black.cgColor
        addTodoTaskFloatingButton.layer.shadowOpacity = 0.5
        addTodoTaskFloatingButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        addTodoTaskFloatingButton.layer.shadowRadius = 5
    }
    
    /// Applys the layout to the progress bar
    private func applyProgressBarLayout () {
        
        progressPercentLabel.text =  "\(Int(viewModel.getDonePercentage() * 100)) %"
        
        progressBar.layer.cornerRadius = Constants.progressBarHeight / 2
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = Constants.progressBarHeight / 2
        progressBar.subviews[1].clipsToBounds = true
        progressBar.setProgress(viewModel.getDonePercentage(), animated: true)
        progressBar.trackTintColor = .lightGray
        progressBar.progressImage = CAGradientLayer(frame: progressBar.frame, colors: viewModel.getGradient()).createGradientImage()
    }
    
    /// Applys the layout to the passcode button
    private func applyPasscodeButtonLayout () {
        self.passcodeButton.tintColor = viewModel.getMainColor()
        passcodeButton.setImage(viewModel.passcode != nil ? Constants.Images.lockItem : Constants.Images.unlockItem, for: .normal)
    }
    
    // MARK: - Actions
    
    /// Presents a view for selecting a icon for the todo list
    @objc fileprivate func chooseIconPressed () {
        nameTextField.resignFirstResponder()
        
        let choiceView = CustomAlert(color: viewModel.getMainColor(), iconCallback: { (icon) in
            self.iconImageView.image = Icons.getIcon(icon)
            self.viewModel.icon = icon
        })
        choiceView.show(animated: true)
    }
    
    /// Presents a view for selecting a gradient for the todo list
    @objc fileprivate func chooseGradientPressed () {
        nameTextField.resignFirstResponder()
        
        let choiceView = CustomAlert(gradientCallback: { (gradient) in
            self.gradientContainer.removeGradientLayer()
            self.gradientContainer.applyGradient(colors: Themes.getTheme(gradient).gradient, WithCornerRadius: self.gradientContainer.layer.cornerRadius)
            self.viewModel.gradient = gradient
            self.iconImageView.tintColor = self.viewModel.getMainColor()
            self.passcodeButton.tintColor = self.viewModel.getMainColor()
            self.nameTextField.tintColor = self.viewModel.getMainColor()
            
            
            self.applyProgressBarLayout()
            self.applyLayoutForFloatingButton()
        })
        choiceView.show(animated: true)
    }
    
    /// Presents the 'TodoTaskViewController', to add a new task to the todo list
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addTasksButtonPressed (_ sender: UIButton) {
        let newTodoTaskViewController = ViewControllerFactory.makeTodoTaskViewController(WithViewModel: nil, AndParentViewModel: viewModel)
        self.navigationController?.present(newTodoTaskViewController, animated: true, completion: nil)
    }
    
    /// Secures the todo list with a passcode
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func saveWithPasscodeButtonPressed (_ sender: UIButton) {
        if viewModel.passcode != nil {
            viewModel.passcode = nil
        } else {
            passcodeButton.setImage(Constants.Images.lockItem, for: .normal)
            let passcodeViewConroller = ViewControllerFactory.makePasscodeViewController(withGradient: viewModel.gradient) { (passcode) in
                guard let passcodeUnwrapped = passcode else {
                    self.viewModel.passcode = nil
                    return
                }
                self.viewModel.passcode = passcodeUnwrapped
            }
            self.navigationController?.pushViewController(passcodeViewConroller, animated: true)
        }
        self.applyPasscodeButtonLayout()
    }
    
    /// Called when the close button in the navigation bar is pressed
    @objc private func closeButtonPressed () {
        viewModel.updateListViewModel()
        self.dismiss(animated: true, completion: nil)
    }
    
    /// The more icon has been pressed
    @objc fileprivate func moreButtonPressed () {
        let alertController = UIAlertController(title: nil, message: Constants.Strings.alertTitleKey.localized, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: Constants.Strings.alertChangeGradientKey.localized, style: .default, handler: { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: Constants.Strings.alertLockListKey.localized, style: .default, handler: { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: Constants.Strings.alertCancelKey.localized, style: .cancel, handler: { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Table View Delegate, Table View Data Source
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableView.headerCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: TodoTaskHeaderCell = .fromNib()
        let dateString = dateFormatter.string(from: Array(sortedTaskViewModel)[section].key)
        headerView.setTitle(dateString)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableView.todoTaskTableViewCellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedTaskViewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(sortedTaskViewModel.keys)[section]
        return sortedTaskViewModel[key]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.todoTaskTableViewCellId, for: indexPath) as? TodoTaskTableViewCell else {
            fatalError("Could not instanciate table view cell!")
        }
        
        let key = Array(sortedTaskViewModel.keys)[indexPath.section]
        let taskViewModel = sortedTaskViewModel[key]![indexPath.row]
        
        cell.applyData(taskViewModel, deleteCallback: {
            self.viewModel.deleteTaskViewModel(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.applyProgressBarLayout()
        }, doneStateCallback: {
            self.viewModel.updateTasks()
            self.applyProgressBarLayout()
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = Array(sortedTaskViewModel.keys)[indexPath.section]
        let taskViewModel = sortedTaskViewModel[key]![indexPath.row]
        if !taskViewModel.isDone {
            let todoTaskViewController = ViewControllerFactory.makeTodoTaskViewController(WithViewModel: taskViewModel, AndParentViewModel: viewModel)
            self.navigationController?.present(todoTaskViewController, animated: true, completion: nil)
        }
    }
}

extension TodoListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.title = textField.text ?? Constants.Strings.namePlaceholderKey.localized
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.title = textField.text ?? Constants.Strings.namePlaceholderKey.localized
    }
}
