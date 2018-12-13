//
//  CollectionViewCell.swift
//  TTD
//
//  Created by Catharina Herchert on 21.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private Constants
private enum Constants {

    enum Strings {
        static let tasksStringKey = "MVC_CVC_tasks"
        
        static let deleteInfoStringKey = "MVC_CVC_deleteInfo"
        
        static let deleteButtonStringKey = "MVC_CVC_deleteButton"
    }
    
    static let progressBarHeight: CGFloat = 5
}

/// The Collection View Cell for the main view controller
class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    /// The background container
    @IBOutlet fileprivate weak var backgroundContainer: UIView!
    
    /// The container view
    @IBOutlet fileprivate weak var containerView: UIView!
    
    /// The badge image container view
    @IBOutlet fileprivate weak var badgeImageContainerView: UIView!
    
    /// The badge image view
    @IBOutlet fileprivate weak var badgeImageView: UIImageView!
    
    /// The task label
    @IBOutlet fileprivate weak var taskLabel: UILabel!
    
    /// The title label
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    /// The progress view
    @IBOutlet fileprivate weak var progressBar: UIProgressView!
    
    /// The progress percent label
    @IBOutlet fileprivate weak var progressPercentLabel: UILabel!
    
    // Delete the cell context
    
    /// The container view for deleting the cell
    @IBOutlet fileprivate weak var deleteContainerView: UIView!
    
    /// The delete button
    @IBOutlet fileprivate weak var deleteButton: UIButton!
    
    /// The delete information label
    @IBOutlet fileprivate weak var deleteInfoLabel: UILabel!
    
    /// The cancel delete button
    @IBOutlet fileprivate weak var cancelButton: UIButton!
    
    // MARK: - Variables
    
    /// The view model
    private var viewModel: TodoListViewModel!
    
    private var deleteCallback: (()->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setup Background View
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowRadius = 5
        
        // Setup Delete View
        deleteContainerView.layer.shadowColor = UIColor.black.cgColor
        deleteContainerView.layer.shadowOpacity = 0.5
        deleteContainerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        deleteContainerView.layer.shadowRadius = 5
        
        showDeleteOption(false)
    }
    
    /// Sets up the task label
    private func setupTaskLabel () {
        
        if let tasks = viewModel.tasks {
            taskLabel.text = "\(tasks.count) \(Constants.Strings.tasksStringKey.localized)"
        } else {
            taskLabel.text = "0 \(Constants.Strings.tasksStringKey.localized)"
        }
    }
    
    /// Setup up the view with the passed informations
    ///
    /// - Parameter viewModel: The view model
    func setupView (_ viewModel: TodoListViewModel, deleteCallback: @escaping (()->Void)) {
        self.viewModel = viewModel
        self.deleteCallback = deleteCallback
        
        descriptionLabel.text = viewModel.title
        
        setupTaskLabel()
        
        badgeImageView.image = viewModel.image()
        badgeImageView.tintColor = viewModel.getMainColor()
        
        progressPercentLabel.text = "\(Int(viewModel.getDonePercentage() * 100)) %"
        
        progressBar.layer.cornerRadius = Constants.progressBarHeight / 2
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = Constants.progressBarHeight / 2
        progressBar.subviews[1].clipsToBounds = true
        progressBar.setProgress(viewModel.getDonePercentage(), animated: true)
        progressBar.trackTintColor = .lightGray
        progressBar.progressImage = CAGradientLayer(frame: progressBar.frame, colors: viewModel.getGradient()).createGradientImage()
        
        // Delete option
        
        deleteInfoLabel.text = Constants.Strings.deleteInfoStringKey.localized
        deleteButton.setTitle(Constants.Strings.deleteButtonStringKey.localized, for: .normal)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Setup Background and Container Views
        backgroundContainer.backgroundColor = .clear
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5.0
        deleteContainerView.backgroundColor = .white
        deleteContainerView.layer.cornerRadius = 5.0
        
        // Setup Image View
        badgeImageContainerView.backgroundColor = .clear
        badgeImageContainerView.layer.borderColor = UIColor.lightGray.cgColor
        badgeImageContainerView.layer.borderWidth = 1.0
        badgeImageContainerView.layer.cornerRadius = badgeImageContainerView.frame.height / 2
    }
    
    // Actions
    
    /// Shows or hides the delete option container view
    ///
    /// - Parameter show: Indicator that shows or hide the delete option container view
    private func showDeleteOption (_ show: Bool) {
        
        deleteContainerView.isHidden = !show
        containerView.isHidden = show
        
    }
    
    /// Recognizes if the more button was touched up inside
    @IBAction fileprivate func showMoreButtonPressed () {
        showDeleteOption(true)
    }
    
    /// Called when the action button of the cell was pressed
    @IBAction fileprivate func cellActionButtonPressed () {
        deleteCallback()
    }
    
    /// Recognizes if the cancel button was touched up inside
    @IBAction fileprivate func cancelActionButtonPressed () {
        showDeleteOption(false)
    }
}
