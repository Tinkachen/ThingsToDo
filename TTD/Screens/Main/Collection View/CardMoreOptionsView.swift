//
//  CardMoreOptionsView.swift
//  TTD
//
//  Created by Catharina Herchert on 18.01.19.
//  Copyright © 2019 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private Constants
private enum Constants {
    
    /// The string for the view
    enum Strings {
        
        /// The localized delete info string
        static let deleteInfoStringLocalized = "MVC_CVC_deleteInfo".localized
        
        /// The localized lock list string
        static let lockListStringLocalized = "".localized
        
        /// The localized unlock list string
        static let unlockListStringLocalized = "".localized
    }
    
    /// The images for the view
    enum Images {
        
        /// The image for delete
        static let deleteImage = #imageLiteral(resourceName: "trash")
        
        /// The image for the lock state (lock)
        static let lockedImage = #imageLiteral(resourceName: "Lock")
        
        /// The image for the lock state (unlock)
        static let unlockedImage = #imageLiteral(resourceName: "Unlock")
    }
}

/// The more options view
class CardMoreOptionsView: UIView, NibLoadable {
    
    // MARK: - Outlets
    
    /// Elements for the icon change option
    @IBOutlet fileprivate weak var changeIconContainerView: UIView!
    @IBOutlet fileprivate weak var changeIconImageViewContainer: UIView!
    @IBOutlet fileprivate weak var changeIconImageView: UIImageView!
    @IBOutlet fileprivate weak var changeIconInfoLabel: UILabel!
    
    /// Elements for the lock list option
    @IBOutlet fileprivate weak var lockListContainerView: UIView!
    @IBOutlet fileprivate weak var lockListImageViewContainer: UIView!
    @IBOutlet fileprivate weak var lockListImageView: UIImageView!
    @IBOutlet fileprivate weak var lockListInfoLabel: UILabel!
    
    /// Elements for the delete option
    @IBOutlet fileprivate weak var deleteContainerView: UIView!
    @IBOutlet fileprivate weak var deleteImageViewContainer: UIView!
    @IBOutlet fileprivate weak var deleteImageView: UIImageView!
    @IBOutlet fileprivate weak var deleteInfoLabel: UILabel!
    
    // MARK: - Variables
    
    /// The view model
    var viewModel: TodoListViewModel!
    
    /// The callback for un/lock the list
    var lockListCallback: (()->Void)!
    
    /// The callback for the delete
    var deleteCallback: (()->Void)!
    
    /// Sets up the view with the passed informatoins
    ///
    /// - Parameters:
    ///   - viewModel: The viewmodel
    ///   - cancelCallback: The callback for the cancel action
    ///   - deleteCallback: The callback for the delete action
    public func setupMoreOptions (WithViewModel viewModel: TodoListViewModel,
                                  AndDeleteCallback deleteCallback: @escaping (()->Void)) {
        self.viewModel = viewModel

        self.deleteCallback = deleteCallback
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLockList()
        setupDelete()
    }
    
    /// Sets up elements for 'lock'
    private func setupLockList () {
        lockListContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lockListViewTouched(_:))))
        lockListImageViewContainer.layer.cornerRadius = deleteImageViewContainer.frame.height / 2
        lockListImageViewContainer.layer.borderColor = UIColor.lightGray.cgColor
        lockListImageViewContainer.layer.borderWidth = 1.0
        lockListImageView.image = viewModel.passcode != nil ? Constants.Images.lockedImage : Constants.Images.unlockedImage
        lockListImageView.tintColor = viewModel.getMainColor()
        lockListInfoLabel.text = viewModel.passcode != nil ? Constants.Strings.unlockListStringLocalized : Constants.Strings.lockListStringLocalized
    }
    
    /// Sets up elements for 'delete'
    private func setupDelete () {
        deleteContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteViewTouched(_:))))
        deleteImageViewContainer.layer.cornerRadius = deleteImageViewContainer.frame.height / 2
        deleteImageViewContainer.layer.borderColor = UIColor.lightGray.cgColor
        deleteImageViewContainer.layer.borderWidth = 1.0
        deleteImageView.image = Constants.Images.deleteImage
        deleteImageView.tintColor = viewModel.getMainColor()
        deleteInfoLabel.text = Constants.Strings.deleteInfoStringLocalized
        
    }
    
    // MARK: - Actions
    
    /// Called when the un/lock button touched
    ///
    /// - Parameter sender: The sender of the event
    @objc fileprivate func lockListViewTouched (_ sender: UIGestureRecognizer) {
        lockListCallback()
    }
    
    /// Called whent the dleete button touched
    ///
    /// - Parameter sender: The sender of the event
    @objc fileprivate func deleteViewTouched (_ sender: UIGestureRecognizer) {
        deleteCallback()
    }
}
