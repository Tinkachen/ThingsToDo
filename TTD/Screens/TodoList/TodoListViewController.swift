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
        static let headerCellId = "TodoTaskHeaderCell"
        static let headerCellHeight: CGFloat = 40
        
        static let todoTaskTableViewCellId = "TodoTaskTableVieCellId"
        static let todoTaskTableViewCellHeight: CGFloat = 30
    }
    
    /// Constant images
    enum Images {
        static let closeIcon = #imageLiteral(resourceName: "CloseIcon")
    }
    
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
    @IBOutlet fileprivate weak var nameTextField: SkyFloatingLabelTextField!
    
    /// The toggle for the passcode setting
    @IBOutlet fileprivate weak var passcodeToggle: UISwitch!
    
    /// The progress background view
    @IBOutlet fileprivate weak var progressBackgroundView: UIView!
    
    /// The progress percent label
    @IBOutlet fileprivate weak var progressPercentLabel: UILabel!
    
    /// The table view
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Variables
    
    /// The service
    var service: TodoListService!
    
    // The view model
    var viewModel: TodoListViewModel!
    
    /// The sorted tasks form the view model
    var sortedTaskViewModel: [Date : [TodoTaskViewModel]] {
        var sorted = [Date : [TodoTaskViewModel]]()
        guard let tasks = viewModel.tasks else { return sorted }
        sorted = Dictionary(grouping: tasks, by: { $0.taskEndDate })
        return sorted
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeItem = UIBarButtonItem(image: Constants.Images.closeIcon, style: .plain, target: self, action: #selector(closeButtonPressed))
        closeItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = closeItem
        
        // Setup Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.TableView.todoTaskTableViewCellId, bundle: nil), forCellReuseIdentifier: Constants.TableView.todoTaskTableViewCellId)
        tableView.register(UINib(nibName: Constants.TableView.headerCellId, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.TableView.headerCellId)
        
        // Add gesture recognizer to views
        iconContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseIconPressed)))
        gradientContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseGradientPressed)))
        
    }
    
    // MARK: - Actions
    
    /// Presents a view for selecting a icon for the todo list
    @objc fileprivate func chooseIconPressed () {
        let choiceView: ChoiceView = .fromNib()
        choiceView.setupForIcons(Constants.Strings.chooseIcon, andData: Icons.allIcons)
    }
    
    /// Presents a view for selecting a gradient for the todo list
    @objc fileprivate func chooseGradientPressed () {
        let choiceView: ChoiceView = .fromNib()
        choiceView.setupForGradients(Constants.Strings.chooseGradient, andData: Themes.allThemes)
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
    
    /// Called when the close button in the navigation bar is pressed
    @objc private func closeButtonPressed () {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table View Delegate, Table View Data Source
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableView.headerCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: TodoTaskHeaderCell = .fromNib()
        headerView.setTitle("\(Array(sortedTaskViewModel)[section])")
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
        
        cell.applyData(title: taskViewModel.taskDescription, isTimerSet: taskViewModel.isTimerSet, isDone: taskViewModel.isDone)
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = Array(sortedTaskViewModel.keys)[indexPath.section]
        let taskViewModel = sortedTaskViewModel[key]![indexPath.row]
        
        let todoTaskViewController = ViewControllerFactory.makeTodoTaskViewController(WithViewModel: taskViewModel)
        self.navigationController?.pushViewController(todoTaskViewController, animated: true)
    }
}
