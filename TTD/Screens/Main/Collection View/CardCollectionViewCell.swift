//
//  CardCollectionViewCell.swift
//  TTD
//
//  Created by Catharina Herchert on 21.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The images for the view
    enum Images {
        
        /// The cancel image
        static let cancelImage = #imageLiteral(resourceName: "CloseIcon")
        
        /// The more options image
        static let moreOptionsImage = #imageLiteral(resourceName: "more_dots")
    }
}

/// The Collection View Cell for the main view controller
class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    /// The background container
//    @IBOutlet fileprivate weak var backgroundContainer: UIView!
    
    /// The container view
    @IBOutlet fileprivate weak var containerView: UIView!
    
    /// The card information view
    @IBOutlet fileprivate weak var cardInformationView: CardInformationView!
    
    /// The card more options view
    @IBOutlet fileprivate weak var cardMoreOptionsView: CardMoreOptionsView!
    
    /// The more options button
    @IBOutlet fileprivate weak var moreOptionsButton: UIButton!
    
    // MARK: - Variables
    
    /// The view model
    private var viewModel: TodoListViewModel!
    
    /// The more option visability indicator
    private var moreOptionsIsVisible = false
    
    /// Indicator if the highlighten animation is disabled
    var disabledHighlightedAnimation = false
    
    /// Resets the transform that was applied to the view
    func resetTransform() {
        transform = .identity
    }
    
    /// Freeze sthe animations in the view
    func freezeAnimations() {
        disabledHighlightedAnimation = true
        layer.removeAllAnimations()
    }
    
    /// Unfreeses the animations in the view
    func unfreezeAnimations() {
        disabledHighlightedAnimation = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowRadius = 5
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5.0
        
    }
    
    /// Fills the cell with the passed informations
    ///
    /// - Parameters:
    ///   - viewModel: The view model
    ///   - deleteCallback: The callback for pressing the delete button
    func fillWithInformations (_ viewModel: TodoListViewModel, deleteCallback: @escaping (()->Void)) {
        self.viewModel = viewModel
        
        self.cardMoreOptionsView.setupMoreOptions(WithViewModel: viewModel,
                                              AndDeleteCallback: {
                                                deleteCallback() })
        
        
        self.cardInformationView.fillWithData(viewModel, forNormalView: true)
        
        cardMoreOptionsView.isHidden = true
    }
    
    // MARK: - Actions
    
    /// Called when the delete button was pressed
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func moreOptionsButtonPressed (_ sender: UIButton) {
        self.moreOptionsButton.setImage(moreOptionsIsVisible ? Constants.Images.moreOptionsImage : Constants.Images.cancelImage, for: .normal)
        self.cardMoreOptionsView.isHidden = moreOptionsIsVisible ? true : false
        self.cardInformationView.isHidden = moreOptionsIsVisible ? false : true
        
        moreOptionsIsVisible = !moreOptionsIsVisible
    }
    
}
