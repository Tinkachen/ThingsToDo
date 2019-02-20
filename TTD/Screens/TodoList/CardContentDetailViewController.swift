//
//  CardContentDetailViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 22.01.19.
//  Copyright © 2019 Catharina Herchert. All rights reserved.
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
        
        /// The close icon
        static let closeIcon = #imageLiteral(resourceName: "CloseIcon")
        
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
        static let viewTitleKey = "TLVC_title".localized
        
        /// The placeholder for the name of the todo list
        static let namePlaceholderKey = "TLVC_name_placeholer".localized
        
        /// The text for choosing a gradient
        static let chooseGradientKey = "TLVC_choose_gradient".localized
        
        /// The text for choosing an icon
        static let chooseIconKey = "TLVC_choose_icon".localized
        
        /// The task text
        static let tasksKey = "TLVC_tasks".localized
        
        /// The text to secure the todo list with a passcode
        static let secureWithPasscodeKey = "TLVC_secure_passcode".localized
        
        /// Alert Strings
        
        /// The title for the alert
        static let alertTitleKey = "TLVC_alert_title".localized
        
        /// The gradient alert action name
        static let alertChangeGradientAndIconKey = "TLVC_alert_change_gradient_and_icon".localized
        
        /// The lock alert action name
        static let alertLockListKey = "TLVC_alert_lock_list".localized
        
        /// The cancel alert action name
        static let alertCancelKey = "TLVC_alert_cancel".localized
    }
    
    /// The height of the progress bar
    static let progressBarHeight: CGFloat = 5
}

/// The view controller for the card content detail
class CardContentDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The card content view
    @IBOutlet weak var cardContentView: CardInformationView!
    
    /// The scroll view
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// The bottom constraint
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    /// The table view
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    /// The button to add a new todo task
    @IBOutlet fileprivate weak var addTodoTaskButton: UIButton!
    
    // MARK: - Variables
    
    /// The view model
    var viewModel: TodoListViewModel!
    
    /// The sorted tasks from the view model
    private var sortedTaskViewModel: [Date : [TodoTaskViewModel]] {
        var sorted = [Date : [TodoTaskViewModel]]()
        guard let tasks = viewModel.tasks else { return sorted }
        sorted = Dictionary(grouping: tasks, by: { $0.dateForSorting() })
        return sorted
    }
    
    /// The service
    var service: TodoListService!
    
    /// A date formatter
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter
    }
    
    /// The interactive starting point
    var interactiveStartingPoint: CGPoint?
    
    /// The dismissal animator
    var dismissalAnimator: UIViewPropertyAnimator?
    
    /// The dragging down to dismiss indicator
    var draggingDownToDismiss = false
    
    /// The dismissal pan gesture
    private lazy var dismissalPanGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.maximumNumberOfTouches = 1
        return pan
    }()
    
    /// The dismissal screen edge pan gesture
    private lazy var dismissalScreenEdgePanGesture: UIScreenEdgePanGestureRecognizer = {
        let pan = UIScreenEdgePanGestureRecognizer()
        pan.edges = .left
        return pan
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.reloadViewModel()
        viewModel.updateTasks()
        tableView.reloadData()
        
        checkIfTableViewIsEmpty()
        
        // Setup UI
        applyLayoutForAddTaskButton()
        cardContentView.updateData(viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup scrollview
        scrollView.layer.borderWidth = 3
        scrollView.layer.borderColor = UIColor.green.cgColor
        
        if let subviewLayer = scrollView.subviews.first {
            subviewLayer.layer.borderWidth = 3
            subviewLayer.layer.borderColor = UIColor.purple.cgColor
        }
        
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        // Setup gesture recognizeer
        
        dismissalPanGesture.addTarget(self, action: #selector(handleDismissalPan(_:)))
        dismissalPanGesture.delegate = self
        
        dismissalScreenEdgePanGesture.addTarget(self, action: #selector(handleDismissalPan(_:)))
        dismissalScreenEdgePanGesture.delegate = self
        
        // Make drag down/scroll pan gesture wait til screen edge pan to fail first to begin
        dismissalPanGesture.require(toFail: dismissalScreenEdgePanGesture)
        scrollView.panGestureRecognizer.require(toFail: dismissalScreenEdgePanGesture)
        
        view.addGestureRecognizer(dismissalPanGesture)
        view.addGestureRecognizer(dismissalScreenEdgePanGesture)
        
        // Fill card with data
        cardContentView.fillWithData(viewModel, forNormalView: false)
        cardContentView.addGestureRecognizerToImage {
            self.changeIdentifierSymbolsForTodoList()
        }
        
        // Setup table view
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.TableView.todoTaskTableViewCellId, bundle: nil), forCellReuseIdentifier: Constants.TableView.todoTaskTableViewCellId)
        tableView.register(UINib(nibName: Constants.TableView.headerCellId, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.TableView.headerCellId)
        
        // Setup the navigation bar
        setupNavigationBar()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(cardContentView.bounds.height, 0, 0, 0)
    }
    
    // UI helper methods
    
    /// Applies the layout for the floating button
    private func applyLayoutForAddTaskButton () {
        addTodoTaskButton.layer.cornerRadius = addTodoTaskButton.frame.height / 2
        addTodoTaskButton.tintColor = .white
        addTodoTaskButton.backgroundColor = viewModel.getMainColor()
    }
    
    /// Sets up the navigation bar
    private func setupNavigationBar () {
        let closeItem = UIBarButtonItem(image: Constants.Images.closeIcon, style: .plain, target: self, action: #selector(closeButtonPressed))
        closeItem.tintColor = .midGray
        self.navigationItem.rightBarButtonItem = closeItem
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Helper methods
    
    /// Performs the dismiss action, when the scroll view was dragged down to dismiss
    private func didSuccessfullyDragDownToDismiss () {
        dismiss(animated: true, completion: nil)
    }
    
    /// Cancels the dismissal transition
    private func didCancelDismissalTransition () {
        interactiveStartingPoint = nil
        dismissalAnimator = nil
        draggingDownToDismiss = false
    }
    
    /// Checks if the table view is empty
    private func checkIfTableViewIsEmpty () {
        if sortedTaskViewModel.count == 0 {
            tableView.setEmptyViewWithMessage("Empty", AndButtonTitle: "Test", AndSpecialColor: viewModel.getMainColor(), AndCallback: {
                self.addTaskButtonPressed(UIButton())
            })
        } else {
            tableView.restore()
        }
    }
    
    // MARK: - Actions
    
    /// Called when the add task button was pressed
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addTaskButtonPressed (_ sender: UIButton) {
        let newTodoTaskViewController = ViewControllerFactory.makeTodoTaskViewController(WithViewModel: nil, AndParentViewModel: viewModel)
        self.navigationController?.pushViewController(newTodoTaskViewController, animated: true)
    }
    
    /// Called when the close button was pressed
    ///
    /// - Parameter sender: The sender of the event
    @objc fileprivate func closeButtonPressed (_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Changes the identifier symbolf for the todo list
    private func changeIdentifierSymbolsForTodoList () {
        let identifierSymbolsViewController = ViewControllerFactory.makeSymbolsViewController(WithViewModel: self.viewModel)
        self.navigationController?.pushViewController(identifierSymbolsViewController, animated: true)
    }
    
    /// Called when the pan gesture recognizer is triggerd
    ///
    /// - Parameter gesture: The gesture of the event
    @objc private func handleDismissalPan (_ gesture: UIPanGestureRecognizer) {
        let isScreenEdgePan = gesture.isKind(of: UIScreenEdgePanGestureRecognizer.self)
        let canStartDragDownToDismissPan = !isScreenEdgePan && !draggingDownToDismiss
        
        // Don't do anything when it's not in the drag down mode
        if canStartDragDownToDismissPan { return }
        
        let targetAnimatedView = gesture.view!
        let startingPoint: CGPoint
        
        if let p = interactiveStartingPoint {
            startingPoint = p
        } else {
            // Initial location
            startingPoint = gesture.location(in: nil)
            interactiveStartingPoint = startingPoint
        }

        let currentLocation = gesture.location(in: nil)
        let progress = isScreenEdgePan ? (gesture.translation(in: targetAnimatedView).x / 100) : (currentLocation.y - startingPoint.y) / 100
        let targetShrinkScale: CGFloat = 0.86
        let targetCornerRadius: CGFloat = 5.0
        
        func createInteractiveDismissalAnimatorIfNeeded() -> UIViewPropertyAnimator {
            if let animator = dismissalAnimator {
                return animator
            } else {
                let animator = UIViewPropertyAnimator(duration: 0, curve: .linear, animations: {
                    targetAnimatedView.transform = .init(scaleX: targetShrinkScale, y: targetShrinkScale)
                    targetAnimatedView.layer.cornerRadius = targetCornerRadius
                })
                animator.isReversed = false
                animator.pauseAnimation()
                animator.fractionComplete = progress
                return animator
            }
        }
        
        switch gesture.state {
        case .began:
            dismissalAnimator = createInteractiveDismissalAnimatorIfNeeded()
            
        case .changed:
            dismissalAnimator = createInteractiveDismissalAnimatorIfNeeded()
            
            let actualProgress = progress
            let isDismissalSuccess = actualProgress >= 1.0
            
            dismissalAnimator!.fractionComplete = actualProgress
            
            if isDismissalSuccess {
                dismissalAnimator!.stopAnimation(false)
                dismissalAnimator!.addCompletion { [unowned self] (pos) in
                    switch pos {
                    case .end:
                        self.didSuccessfullyDragDownToDismiss()
                    default:
                        fatalError("Must finish dismissal at end!")
                    }
                }
                dismissalAnimator!.finishAnimation(at: .end)
            }
            
        case .ended, .cancelled:
            if dismissalAnimator == nil {
                // Gesture's too quick that it doesn't have dismissalAnimator!
                print("Too quick there's no animator!")
                didCancelDismissalTransition()
                return
            }
            // NOTE:
            // If user lift fingers -> ended
            // If gesture.isEnabled -> cancelled
            
            // Ended, Animate back to start
            dismissalAnimator!.pauseAnimation()
            dismissalAnimator!.isReversed = true
            
            // Disable gesture until reverse closing animation finishes.
            gesture.isEnabled = false
            dismissalAnimator!.addCompletion { [unowned self] (pos) in
                self.didCancelDismissalTransition()
                gesture.isEnabled = true
            }
            dismissalAnimator!.startAnimation()
        default:
            fatalError("Impossible gesture state? \(gesture.state.rawValue)")
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CardContentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return sortedTaskViewModel[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = Array(sortedTaskViewModel.keys)[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.todoTaskTableViewCellId, for: indexPath) as? TodoTaskTableViewCell,
              let taskViewModel = sortedTaskViewModel[key]?[indexPath.row] else {
            fatalError("Could not instanciate table view cell!")
        }
        
        cell.applyData(taskViewModel, deleteCallback: {
            self.removeCellAtIndex(indexPath)
        }, doneStateCallback: {
            self.viewModel.updateTasks()
            self.cardContentView.updateData(self.viewModel)
        })
        
        return UITableViewCell()
    }
    
    /// Removes the cell at the passed index
    ///
    /// - Parameter index: The index
    private func removeCellAtIndex (_ index: IndexPath) {
        self.viewModel.deleteTaskViewModel(atIndex: index.row)
        
        if self.sortedTaskViewModel.count <= 0 {
            self.checkIfTableViewIsEmpty()
            self.tableView.reloadData()
        } else {
            self.tableView.deleteRows(at: [index], with: .fade)
        }
        
        self.cardContentView.updateData(viewModel)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = Array(sortedTaskViewModel.keys)[indexPath.section]
        guard let taskViewModel = sortedTaskViewModel[key]?[indexPath.row] else { return }
        if !taskViewModel.isDone {
            let todoTaskViewController = ViewControllerFactory.makeTodoTaskViewController(WithViewModel: taskViewModel, AndParentViewModel: viewModel)
            self.navigationController?.pushViewController(todoTaskViewController, animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate
extension CardContentDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.title = textField.text ?? Constants.Strings.namePlaceholderKey
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.title = textField.text ?? Constants.Strings.namePlaceholderKey
    }
}

// MARK: - ScrollView Delegate
extension CardContentDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            if draggingDownToDismiss || (scrollView.isTracking && scrollView.contentOffset.y < 0) {
                draggingDownToDismiss = true
                scrollView.contentOffset = .zero
            }
            
            scrollView.showsVerticalScrollIndicator = !draggingDownToDismiss
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if self.scrollView == scrollView && velocity.y > 0 && scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset = .zero
        }
    }
}

// MARK: - Gesture Recognizer Delegate
extension CardContentDetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
