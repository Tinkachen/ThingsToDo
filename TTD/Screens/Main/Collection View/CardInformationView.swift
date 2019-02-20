//
//  CardInformationView.swift
//  TTD
//
//  Created by Catharina Herchert on 18.01.19.
//  Copyright © 2019 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private Constants
private enum Constants {
    
    /// The strings for the view
    enum Strings {
        
        /// The localized Task string
        static let tasksStringLocalized = "MVC_CVC_tasks".localized
    }
    
    /// The height of the progress bar
    static let progressBarHeight: CGFloat = 5
}

/// The information view
class CardInformationView: UIView, NibLoadable {
    
    // MARK: - Outlets
    
    /// Elements for the top image view
    @IBOutlet fileprivate weak var imageContainerView: UIView!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    /// Elements for bottom image view
    @IBOutlet fileprivate weak var imageContainerView2: UIView!
    @IBOutlet fileprivate weak var imageView2: UIImageView!
    
    /// The tasks counter label
    @IBOutlet fileprivate weak var taskCounterLabel: UILabel!
    
    /// The list name label
    @IBOutlet fileprivate weak var listNameLabel: UILabel!
    
    /// Elements for the progress bar
    @IBOutlet fileprivate weak var progressBar: UIProgressView!
    @IBOutlet fileprivate weak var progressPercentageLabel: UILabel!
    
    
    // MARK: - Variables
    
    /// The view model
    private var viewModel: TodoListViewModel!
    
    /// The callback for touching the image
    private var imageCallback: (()->Void)!
    
    /// Fills the view with the passed data
    ///
    /// - Parameter viewModel: The view model
    public func fillWithData (_ viewModel: TodoListViewModel, forNormalView: Bool) {
        
        self.viewModel = viewModel
        self.updateImageConstraint(forNormalView: forNormalView)
    }
    
    /// Updates the view with the passed data
    ///
    /// - Parameter viewModel: The view model
    public func updateData (_ viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        commonSetup()
    }
    
    /// Adds a gesture recognizer on the bottom image
    ///
    /// - Parameter callback: The callback for touching the bottom image
    public func addGestureRecognizerToImage (WithCallback callback: @escaping (()->Void)) {
        imageCallback = callback
        imageContainerView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Setup Image View
        imageContainerView.backgroundColor = .clear
        imageContainerView.layer.borderColor = UIColor.lightGray.cgColor
        imageContainerView.layer.borderWidth = 1.0
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
        
        imageContainerView2.backgroundColor = .clear
        imageContainerView2.layer.borderColor = UIColor.lightGray.cgColor
        imageContainerView2.layer.borderWidth = 1.0
        imageContainerView2.layer.cornerRadius = imageContainerView2.frame.height / 2
        
        commonSetup()
    }
    
    // MARK: - UI Helper Methods
    
    /// The common setup for the ui elements
    private func commonSetup () {
        
        listNameLabel?.text = viewModel.title
        
        setupTaskLabel()
        
        imageView?.image = viewModel.image()
        imageView?.tintColor = viewModel.getMainColor()
        
        imageView2.image =  viewModel.image()
        imageView2.tintColor = viewModel.getMainColor()
        
        progressBar?.layer.cornerRadius = Constants.progressBarHeight / 2
        progressBar?.clipsToBounds = true
        progressBar?.layer.sublayers![1].cornerRadius = Constants.progressBarHeight / 2
        progressBar?.subviews[1].clipsToBounds = true
        progressBar?.trackTintColor = .lightGray
        progressBar?.progressImage = CAGradientLayer(frame: progressBar.frame, colors: viewModel.getGradient()).createGradientImage()
        
        updateProgressBar()
    }
    
    /// Sets up the task label
    private func setupTaskLabel () {
        
        if let tasks = viewModel.tasks {
            taskCounterLabel?.text = "\(tasks.count) \(Constants.Strings.tasksStringLocalized)"
        } else {
            taskCounterLabel?.text = "0 \(Constants.Strings.tasksStringLocalized)"
        }
    }
    
    // #TODO
    /// Updates the image constraint
    private func updateImageConstraint (forNormalView: Bool) {
        imageContainerView.isHidden = !forNormalView
        imageContainerView2.isHidden = forNormalView
    }
    
    /// Updates the progress bar with the new values
    private func updateProgressBar () {
        progressBar.setProgress(viewModel.getDonePercentage(), animated: true)
        progressPercentageLabel?.text = "\(Int(viewModel.getDonePercentage() * 100)) %"
    }
    
    /// Called when the image was touched
    @objc private func didTapImage () {
        imageCallback()
    }
}
