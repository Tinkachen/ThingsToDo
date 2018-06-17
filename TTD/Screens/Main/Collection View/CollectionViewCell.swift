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
    
    /// Test value for the progress view
    static let testValue: CGFloat = 0.5
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
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    /// The progress background view
    @IBOutlet fileprivate weak var progressBackgroundView: UIView!
    
    /// The progress percent label
    @IBOutlet fileprivate weak var progressPercentLabel: UILabel!
    
    // MARK: - Variables
    
    /// The progress indictator view
    fileprivate var progressIndicatorView: UIView!
    
    /// The view model
    private var viewModel: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskLabel.text = "bla"
        
        // Setup Progress View
        progressBackgroundView.layer.cornerRadius = progressBackgroundView.bounds.height / 2
        
        progressIndicatorView = UIView(frame:
            CGRect(x: 0, y: 0,
                   width: progressBackgroundView.bounds.width,
                   height: progressBackgroundView.bounds.height))
        progressIndicatorView.layer.cornerRadius = progressBackgroundView.layer.cornerRadius
        progressBackgroundView.addSubview(progressIndicatorView)
        
        progressPercentLabel.text = String(Int(Constants.testValue * 100))
        progressIndicatorView.applyGradient(colors: Themes.purple.gradient)
        progressIndicatorView.frame = CGRect(x: 0, y: 0,
                                              width: progressBackgroundView.bounds.width * Constants.testValue,
                                              height: progressIndicatorView.bounds.height)
    }
    
    /// Setup up the view with the passed informations
    ///
    /// - Parameter viewModel: The view model
    func setupView (_ viewModel: String) {
        self.viewModel = viewModel
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Setup Background and Container Views
        backgroundContainer.backgroundColor = .clear
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5.0
        
        // Setup Image View
        badgeImageContainerView.backgroundColor = .clear
        badgeImageContainerView.layer.borderColor = UIColor.lightGray.cgColor
        badgeImageContainerView.layer.borderWidth = 1.0
        badgeImageContainerView.layer.cornerRadius = badgeImageContainerView.frame.height / 2
    }
    
}
