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
    
    /// The strings for the priority label
    enum PriorityString {
        
        /// The low priority string
        static let lowString = "!"
        
        /// The middle priority string
        static let middleString = "!!"
        
        /// The high priority string
        static let highString = "!!!"
    }
}

/// The table view cell for the todo tasks
class TodoTaskTableViewCell: UITableViewCell {
    
    /// The button for the check box
    @IBOutlet fileprivate weak var checkBoxButton: UIButton!
    
    /// The alternate info button for timer/delete 
    @IBOutlet fileprivate weak var alternateInfoButton: UIButton!
    
    /// The priority label
    @IBOutlet fileprivate weak var priorityLabel: UILabel!
    
    /// The label for the title
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    // Variables
    
    /// The view model
    private var viewModel: TodoTaskViewModel!
    
    /// The call back for deleting the task
    private var deleteCallback: (()->Void)!
    
    /// The call back for the done state
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
        applyAlternateInformation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyPriority()
    }
    
    /// Apply informations to the button from the view model 
    private func applyAlternateInformation () {
        if viewModel.isDone {
            checkBoxButton.setImage(Constants.checkImage, for: .normal)
            if strikethroughView == nil {
                strikethroughView = UIView(frame: CGRect(x: 0,
                                                         y: (titleLabel.frame.height / 2) - 1.0,
                                                         width: 0,
                                                         height: Constants.strikethroughViewHeight))
                strikethroughView?.layer.cornerRadius = Constants.strikethroughViewHeight / 2
                strikethroughView?.backgroundColor = .midGray
                titleLabel.addSubview(strikethroughView!)
                self.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.3) {
                    self.strikethroughView?.frame.size.width = self.titleLabel.frame.width
                    self.titleLabel.textColor = .midGray
                }
            }
            
            alternateInfoButton.setImage(Constants.trashImage, for: .normal)
            alternateInfoButton.isUserInteractionEnabled = true
            alternateInfoButton.tintColor = .midGray
            
        } else {
            checkBoxButton.setImage(Constants.checkEmptyImage, for: .normal)
            strikethroughView?.removeFromSuperview()
            strikethroughView = nil
            alternateInfoButton.setImage(viewModel.isTimerSet ? Constants.timerImage : nil, for: .normal)
            alternateInfoButton.isUserInteractionEnabled = false
            alternateInfoButton.tintColor = .midGray
            titleLabel.textColor = .black
        }
    }
    
    /// Apply priority indicator to button
    private func applyPriority () {
        
        priorityLabel.textColor = .midGray
        
        switch viewModel.priority {
        case .low?:
            priorityLabel.text = Constants.PriorityString.lowString
            titleLabel.font = UIFont.systemFont(ofSize: titleLabel.font.pointSize, weight: .semibold)
            break
        case .middle?:
            priorityLabel.text = Constants.PriorityString.middleString
            titleLabel.font = UIFont.systemFont(ofSize: titleLabel.font.pointSize, weight: .bold)
            break
        case .high?:
            priorityLabel.text = Constants.PriorityString.highString
            titleLabel.font = UIFont.systemFont(ofSize: titleLabel.font.pointSize, weight: .heavy)
            break
        default:
            priorityLabel.text = ""
            titleLabel.font = UIFont.systemFont(ofSize: titleLabel.font.pointSize, weight: .regular)
            break
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
    
    /// Called when the task should be deleted
    @IBAction private func deleteTask () {
        if alternateInfoButton.imageView?.image == Constants.trashImage {
            deleteCallback()
        }
    }
}
