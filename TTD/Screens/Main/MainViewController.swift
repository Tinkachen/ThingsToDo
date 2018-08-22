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
        static let welcomeUserKey = "MVC_welcome_user"
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
    var todoListViewModels = [TodoListViewModel]()
    
    /// The collection view cell size
    fileprivate var collectionViewCellSize = CGSize(width: 0, height: 0)
    
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
        
        self.view.applyGradient(colors: Themes.purple.gradient)
        
        // Setup Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: Constants.collectionViewCellId, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCellId)
        
        collectionView.backgroundColor = .clear
        
        collectionViewCellSize = CGSize(width: collectionView.frame.size.width * 0.8, height: collectionView.frame.size.height)
        
        getListViewModels()
        
    }
    
    /// <#Description#>
    private func getListViewModels () {
        todoListViewModels = TodoListService.getListViewModels()
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - viewModel1: <#viewModel1 description#>
    ///   - viewModel2: <#viewModel2 description#>
    fileprivate func fadeFromViewModel(_ viewModel1: TodoListViewModel, ToViewModel viewModel2: TodoListViewModel, withPercentage percentage: CGFloat) {
        
//        let from1 = UIColor(cgColor: viewModel1.getGradient()[0])
//        var fRed1: CGFloat = 0
//        var fGreen1: CGFloat = 0
//        var fBlue1: CGFloat = 0
//        var fAlpha1: CGFloat = 0
//        from1.getRed(&fRed1, green: &fGreen1, blue: &fBlue1, alpha: &fAlpha1)
//
//        let to1 = UIColor(cgColor: viewModel1.getGradient()[0])
//        var tRed1: CGFloat = 0
//        var tGreen1: CGFloat = 0
//        var tBlue1: CGFloat = 0
//        var tAlpha1: CGFloat = 0
//        to1.getRed(&tRed1, green: &tGreen1, blue: &tBlue1, alpha: &tAlpha1)
//
//        let red1 = (tRed1 - fRed1) * percentage + fRed1
//        let green1 = (tGreen1 - fGreen1) * percentage + fGreen1
//        let blue1 = (tBlue1 - fBlue1) * percentage + fBlue1
//        let alpha1 = (tAlpha1 - fAlpha1) * percentage + fAlpha1
//
//        let newTopGradient = UIColor(red: red1, green: green1, blue: blue1, alpha: alpha1)
//
//        let from2 = UIColor(cgColor: viewModel1.getGradient()[1])
//        var fRed2: CGFloat = 0
//        var fGreen2: CGFloat = 0
//        var fBlue2: CGFloat = 0
//        var fAlpha2: CGFloat = 0
//        from2.getRed(&fRed2, green: &fGreen2, blue: &fBlue2, alpha: &fAlpha2)
//
//        let to2 = UIColor(cgColor: viewModel1.getGradient()[1])
//        var tRed2: CGFloat = 0
//        var tGreen2: CGFloat = 0
//        var tBlue2: CGFloat = 0
//        var tAlpha2: CGFloat = 0
//        to2.getRed(&tRed2, green: &tGreen2, blue: &tBlue2, alpha: &tAlpha2)
//
//        let red2 = (tRed2 - fRed2) * percentage + fRed2
//        let green2 = (tGreen2 - fGreen2) * percentage + fGreen2
//        let blue2 = (tBlue2 - fBlue2) * percentage + fBlue2
//        let alpha2 = (tAlpha2 - fAlpha2) * percentage + fAlpha2
//
//        let newBottomGradient = UIColor(red: red2, green: green2, blue: blue2, alpha: alpha2)
//
//        self.view.removeGradientLayer()
//        self.view.applyGradient(colors: [newTopGradient.cgColor, newBottomGradient.cgColor])
        
    }
    
    // MARK: - Buttons Actions
    
    /// Adds a new to do list card
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func addNewTodoListButtonPressed (_ sender: UIButton) {
        let newTodoListViewController = ViewControllerFactory.makeTodoListViewController(WithViewModel: nil)
        self.navigationController?.present(newTodoListViewController, animated: true)
    }
    
    fileprivate func deleteCell (atIndexPath indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
            let vm = self.todoListViewModels[indexPath.row]
            vm.deleteListViewModel()
            self.todoListViewModels.remove(at: indexPath.row)
            self.collectionView.reloadData()
        }))
        
        self.present(alertController, animated: true, completion: nil)
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
        let todoListViewController = ViewControllerFactory.makeTodoListViewController(WithViewModel: todoListViewModels[indexPath.row])
        self.navigationController?.present(todoListViewController, animated: true, completion: nil)
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
    
    /*func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = indexOfMajorCell()
        var oldPage: Int = 0
        let currentPageX = CGFloat(page) * scrollView.frame.width
        
        if (scrollView.contentOffset.x >= currentPageX + scrollView.frame.width) { // right
            oldPage = page + 1
        } else { // left
            oldPage = page - 1
        }
        
        if page > todoListViewModels.count || page < 0 { return }
        if oldPage > todoListViewModels.count || oldPage < 0 { return }
        
        let maxHorizontalOffset = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset = scrollView.contentOffset.x
        
        let percentageHorizontalOffset = currentHorizontalOffset / self.view.frame.width - CGFloat(page)
        
        fadeFromViewModel(todoListViewModels[oldPage], ToViewModel: todoListViewModels[page], withPercentage: percentageHorizontalOffset)
    }*/
    
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
            }, completion: nil)
            
        } else {
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionView.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        let from = todoListViewModels[indexOfCellBeforeDragging]
        let to = todoListViewModels[indexOfMajorCell]
        self.view.removeGradientLayer()
        self.view.transitToGradient(from: from.getGradient(), to: to.getGradient())
    }
}
