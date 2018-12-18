//
//  MainViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 21.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private Constants
private enum Constants {
    
    /// The collection view cell id
    static let collectionViewCellId = "CollectionViewCell"
    
    /// Strings for the outlets
    enum Strings {
        
        /// The localized text to welcome the user
        static let welcomeUserKey = "MVC_welcome_user".localized
        
        /// The localized text for the today label
        static let todayWithInputKey = "MVC_today"
        
        /// The localized text to delete a cell
        static let alertDeleteKey = "MVC_alert_delete".localized
        
        /// The localized text to cancel the cell delete
        static let alertCancelKey = "MVC_alert_cancel".localized
        
        /// The message for a empty colleciton view
        static let emptyMessage = "MVC_empty_view_message".localized
        
        /// The title string for a empty collection view
        static let emptyButtonTitle = "MVC_empty_view_button".localized
    }
}

/// The main view controller of the application
class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// The collection view
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    /// The welcome label
    @IBOutlet fileprivate weak var welcomeLabel: UILabel!
    
    /// The description label
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    /// The today label
    @IBOutlet fileprivate weak var todayLabel: UILabel!
    
    // MARK: - Variables
    
    // the main view model
    let mainViewModel = MainViewModel()
    
    /// The todo list view models
    var todoListViewModels = [TodoListViewModel]()
    
    /// The transition make
    let transition = Animator()
    
    /// The selected index path
    var selectedIndexPath: IndexPath!
    
    /// The collection view cell size
    fileprivate var collectionViewCellSize = CGSize(width: 100, height: 100)
    
    /// The collection view editing mode indicator
    fileprivate var collectionViewEditingMode = false
    
    // Horizontal Page Collection Setup
    private var _indexOfCellBeforeDragging = 0
    fileprivate var indexOfCellBeforeDragging: Int {
        get {
            return _indexOfCellBeforeDragging
        }
        set {
            _indexOfCellBeforeDragging = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: Constants.collectionViewCellId, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCellId)
        
        collectionView.backgroundColor = .clear
        collectionView.isPrefetchingEnabled = false
        
//        collectionView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(handlePanGestureOnCollectionViewCell(_:))))
        
        // Setup user informations
        welcomeLabel.text = "\(Constants.Strings.welcomeUserKey) \(mainViewModel.getUserName())"
    
        // Setup the current date
        todayLabel.text = Constants.Strings.todayWithInputKey.localizedWith([mainViewModel.currentFormattedDate])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionViewCellSize = CGSize(width: collectionView.frame.size.width * 0.8, height: collectionView.frame.size.height)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getListViewModels()
        collectionView.reloadData()
        checkIfCollectionViewIsEmpty()
        
        self.view.removeGradientLayer()
        
        self.view.applyGradient(colors: todoListViewModels.count > 0 ? todoListViewModels[indexOfMajorCell()].getGradient() : Themes.getTheme(Gradient.rdmGradient()).gradient)
    }
    
    /// Checks if the collection view is empty an displays a empty view or restores it
    private func checkIfCollectionViewIsEmpty () {
        if todoListViewModels.count == 0 {
            collectionView.setEmptyViewWithMessage(Constants.Strings.emptyMessage, AndButtonTitle: Constants.Strings.emptyButtonTitle) {
                self.addNewTodoListButtonPressed(UIButton())
            }
            descriptionLabel.text = mainViewModel.getDescriptionStringForTaskCount(0)
        } else {
            collectionView.restore()
            descriptionLabel.text = mainViewModel.getDescriptionStringForTaskCount(TodoListService.getTotalCountOfTodayTasks())
        }
    }
    
    /// Requests the list view models from the local storage
    private func getListViewModels () {
        todoListViewModels = TodoListService.getListViewModels()
        descriptionLabel.text = mainViewModel.getDescriptionStringForTaskCount(TodoListService.getTotalCountOfTodayTasks())
    }
    
    // MARK: - Transition animation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
//        guard let cell = collectionView.cellForItem(at: selectedIndexPath) else {
//
//        }
//
//        coordinator.animate(alongsideTransition: { (context) in
//            
//        }, completion: nil)
    }
    
    // MARK: - Buttons Actions
    
    /// Adds a new to do list card
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addNewTodoListButtonPressed (_ sender: UIButton) {
        let newTodoListViewController = ViewControllerFactory.makeTodoListViewController(withTransitioningDelegate: self)
        self.navigationController?.present(newTodoListViewController, animated: true)
    }
    
    /// Deletes the passed cell and connected data
    ///
    /// - Parameter indexPath: The index path of the cell
    fileprivate func deleteCell (atIndexPath indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: Constants.Strings.alertDeleteKey, style: .destructive, handler: { (alertAction) in
            
            
            self.collectionView.performBatchUpdates({
                let vm = self.todoListViewModels[indexPath.row]
                vm.deleteListViewModel()
                self.todoListViewModels.remove(at: indexPath.row)
                self.collectionView.deleteItems(at: [indexPath])
                
                if self.todoListViewModels.count == 0 {
                    self.checkIfCollectionViewIsEmpty()
                    return
                }
                
                let newIndex = ((self.indexOfMajorCell() / self.todoListViewModels.count) < (self.todoListViewModels.count / 2)) ? self.indexOfMajorCell() + 1 : self.indexOfMajorCell() - 1
                if newIndex > 0 && newIndex <= self.todoListViewModels.count {
                    self.view.transitToGradient(from: vm.getGradient(), to: self.todoListViewModels[newIndex].getGradient())
                }
                
                self.checkIfCollectionViewIsEmpty()
                
            }, completion: nil)
            
            alertController.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: Constants.Strings.alertCancelKey, style: .cancel, handler: { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Gestures
    
    /// Handles the pan gesture on a collection view cell
    ///
    /// - Parameter gesture: The pan gesture
    @objc fileprivate func handlePanGestureOnCollectionViewCell (_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
    }
}

// MARK: - Collection View Data Source, Collection View Delegate, Collection View Delegate Flow Layout, Scroll View Delegate
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoListViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionViewCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let collectionViewCell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellId, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        collectionViewCell.setupView(todoListViewModels[indexPath.row]) {
            self.deleteCell(atIndexPath: indexPath)
        }
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let todoListViewController = ViewControllerFactory.makeTodoListViewController(withTransitioningDelegate: self, andViewModel: todoListViewModels[indexPath.row])
        self.present(todoListViewController, animated: true, completion: nil)
    }

    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionViewFlowLayout.minimumLineSpacing = 0
        
        configureCollectionViewLayoutItemSize()
    }
    
    func calculateSectionInset() -> CGFloat {
        return (self.view.bounds.width - collectionViewCellSize.width) / 2
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectionViewFlowLayout.itemSize = CGSize(width: collectionView.collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: collectionView.collectionViewLayout.collectionView!.frame.size.height)
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewFlowLayout.itemSize.width
        var proportionalOffset = collectionView.collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        
        if proportionalOffset < 0 {
            proportionalOffset = 0
        } else if proportionalOffset > CGFloat(collectionView.numberOfItems(inSection: 0)) { proportionalOffset = CGFloat(collectionView.numberOfItems(inSection: 0))
        }
        
        return Int(round(proportionalOffset))
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()
        
        // calculate conditions:
        let dataSourceCount = collectionView(collectionView!, numberOfItemsInSection: 0)
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSourceCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewFlowLayout.itemSize.width * CGFloat(snapToIndex)
            
            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: { (completed) in
                let from = self.todoListViewModels[self.indexOfCellBeforeDragging]
                let to = self.todoListViewModels[hasEnoughVelocityToSlideToTheNextCell ? self.indexOfCellBeforeDragging + 1 : self.indexOfCellBeforeDragging - 1]
                self.view.transitToGradient(from: from.getGradient(), to: to.getGradient())
            })
            
        } else {
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionView.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        let from = todoListViewModels[indexOfCellBeforeDragging]
        let to = todoListViewModels[indexOfMajorCell]
        self.view.transitToGradient(from: from.getGradient(), to: to.getGradient())
    }
}

// MARK: - View Controller Transitioning Delegate
extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let cellFrame = collectionView.cellForItem(at: selectedIndexPath)?.frame else { return nil }
        transition.originFrame = cellFrame
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
