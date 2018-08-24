//
//  TodoTaskTableViewCell.swift
//  TTD
//
//  Created by Catharina Herchert on 17.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The image for the checked status
    static let checkImage = #imageLiteral(resourceName: "check")
    
    /// The empty check box image
    static let checkEmptyImage = #imageLiteral(resourceName: "empty_check")
    
    /// The trash image
    static let trashImage = #imageLiteral(resourceName: "trash")
    
    /// The timer image
    static let timerImage = #imageLiteral(resourceName: "timer")
    
    /// The height of the strike through view
    static let strikethroughViewHeight: CGFloat = 2
}

/// The table view cell for the todo tasks
class TodoTaskTableViewCell: UITableViewCell {
    
    /// The button for the check box
    @IBOutlet fileprivate weak var checkBoxButton: UIButton!
    
    /// The alternate info button for timer/delete 
    @IBOutlet fileprivate weak var alternateInfoButton: UIButton!
    
    /// The label for the title
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    // Variables
    
    /// The view model
    private var viewModel: TodoTaskViewModel!
    
    /// The call back for deleting the task
    private var deleteCallback: (()->Void)!
    
    private var doneStateCallback: (()->Void)!
    
    /// The strikethrough view for the label
    private var strikethroughView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// Sets the passed data to the table view cell
    ///
    /// - Parameters:
    ///   - title: The title
    ///   - isTimerSet: The timer is set indicator
    ///   - isDone: The check box is on indicator
    func applyData (_ viewModel: TodoTaskViewModel, deleteCallback: @escaping (()->Void), doneStateCallback: @escaping (()->Void)) {
        self.viewModel = viewModel
        self.deleteCallback = deleteCallback
        self.doneStateCallback = doneStateCallback
        titleLabel.text = viewModel.taskDescription
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyAlternateInformation()
    }
    
    /// Apply informations to the button from the view model 
    private func applyAlternateInformation () {
        if viewModel.isDone {
            checkBoxButton.setImage(Constants.checkImage, for: .normal)
            strikethroughView = UIView(frame: CGRect(x: 0,
                                                     y: (titleLabel.frame.height / 2) - 1.0,
                                                     width: 0,
                                                     height: Constants.strikethroughViewHeight))
            strikethroughView?.layer.cornerRadius = Constants.strikethroughViewHeight / 2
            strikethroughView?.backgroundColor = .lightGray
            titleLabel.addSubview(strikethroughView!)
            UIView.animate(withDuration: 0.3) {
                self.strikethroughView?.frame.size.width = self.titleLabel.frame.width
            }
            alternateInfoButton.setImage(Constants.trashImage, for: .normal)
            alternateInfoButton.tintColor = .midGray
        } else {
            checkBoxButton.setImage(Constants.checkEmptyImage, for: .normal)
            strikethroughView?.removeFromSuperview()
            strikethroughView = nil
            alternateInfoButton.setImage(viewModel.isTimerSet ? Constants.timerImage : nil, for: .normal)
            alternateInfoButton.tintColor = .midGray
        }
    }
    
    // Actions
    
    /// Called when the check box is selected
    @IBAction private func didSelectCheckBox () {
        viewModel.isDone = !viewModel.isDone
        checkBoxButton.setImage(viewModel.isDone ? Constants.checkImage : Constants.checkEmptyImage, for: .normal)
        applyAlternateInformation()
        viewModel.updateTaskViewModel()
        
        doneStateCallback()
    }
    
    @IBAction private func deleteTask () {
        if alternateInfoButton.imageView?.image == Constants.trashImage {
            deleteCallback()
        }
    }
}
