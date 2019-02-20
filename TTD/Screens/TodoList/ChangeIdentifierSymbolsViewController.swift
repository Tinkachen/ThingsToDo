//
//  ChangeIdentifierSymbolsViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 29.01.19.
//  Copyright © 2019 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The collection view informations
    enum CollectionView {
        
        /// The size of the collection view cells
        static let size = CGSize(width: 50, height: 50)
        
        /// The gradient cell id
        static let gradientCellId = "GradientCollectionViewCell"
        
        /// The icon cell id
        static let iconCellId = "IconCollectionViewCell"
    }

}

/// The view controller for changing the identifier symbols of the todo list
class ChangeIdentifierSymbolsViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Elements for the symbols
    @IBOutlet fileprivate weak var symbolContainerView: UIView!
    @IBOutlet fileprivate weak var gradientContainerView: UIView!
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    
    /// Elements for the segmented control
    @IBOutlet fileprivate weak var segmentedControlContainerView: UIView!
    @IBOutlet fileprivate weak var segmentedControl: UISegmentedControl!
    
    /// Elements for the collection view
    @IBOutlet fileprivate weak var collectionViewContainer: UIView!
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    
    /// The view model
    var viewModel: TodoListViewModel!
    
    /// The last selected gradient cell
    private var lastSelectedGradientCell: GradientCollectionViewCell?
    
    /// The last selected icon cell
    private var lastSelectedIconCell: IconCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Gradient and Image View
        gradientContainerView.layer.cornerRadius = gradientContainerView.frame.height / 2
        iconImageView.tintColor = .white
        
        // Register Collection View Cell
        collectionView.register(UINib(nibName: Constants.CollectionView.gradientCellId, bundle: nil),
                                forCellWithReuseIdentifier: Constants.CollectionView.gradientCellId)
        collectionView.register(UINib(nibName: Constants.CollectionView.iconCellId, bundle: nil),
                                forCellWithReuseIdentifier: Constants.CollectionView.iconCellId)
        collectionView.delegate = self
        collectionView.dataSource = self

        applyDataInformationsToElements()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.updateListViewModel()
    }
    
    /// Applys the data form the view model to the elements
    private func applyDataInformationsToElements () {
        gradientContainerView.applyGradient(colors: viewModel.getGradient(),
                                            WithCornerRadius: gradientContainerView.layer.cornerRadius)
        iconImageView.image = viewModel.image()
    }
    
    // MARK: - Actions
    
    /// Called when the value of the segmented control changed
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func segmentDidChange (_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
}

// MARK: - Collection View Delegate & DataSource
extension ChangeIdentifierSymbolsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.CollectionView.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? Icons.allIcons.count : Theme.allThemes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentedControl.selectedSegmentIndex == 0 { // Icon
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.iconCellId, for: indexPath) as? IconCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let icon = Icons.getIcon(Array(Icons.allIcons.keys)[indexPath.row])
            if icon == viewModel.image() {
                cell.isSelected = true
                lastSelectedIconCell = cell
            }
            
            cell.applyData(icon)
            
            return cell
        } else { // Gradient
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.gradientCellId, for: indexPath) as? GradientCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let gradient = Theme.allThemes[indexPath.row]
            if viewModel.gradient == gradient {
                cell.isSelected = true
                lastSelectedGradientCell = cell
            }
            
            cell.applyData(gradient)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 { // Icons
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.iconCellId, for: indexPath) as? IconCollectionViewCell else {
                return
            }
            
            viewModel.icon = Array(Icons.allIcons.keys)[indexPath.row]
            lastSelectedIconCell?.isSelected = false
            cell.isSelected = true
            lastSelectedIconCell = cell
            
        } else { // Gradient
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.gradientCellId, for: indexPath) as? GradientCollectionViewCell else {
                return
            }
            
            viewModel.gradient = Theme.allThemes[indexPath.row]
            lastSelectedGradientCell?.isSelected = false
            cell.isSelected = true
            lastSelectedGradientCell = cell

        }
        applyDataInformationsToElements()
    }
}
