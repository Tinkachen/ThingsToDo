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
    static let checkImage = UIImage(named: "")
    
    /// The image for the timer
    static let timerImage = UIImage(named: "")
    
    static let checkboxBorderWith: CGFloat = 1.0
}

/// The table view cell for the todo tasks
class TodoTaskTableViewCell: UITableViewCell {
    
    /// The view for the check box
    @IBOutlet fileprivate weak var checkBoxView: UIView!
    
    /// The image view for the checked status
    @IBOutlet fileprivate weak var checkImageView: UIImageView!
    
    /// The label for the title
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    /// The image view for the timer
    @IBOutlet fileprivate weak var timerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// Sets the passed data to the table view cell
    ///
    /// - Parameters:
    ///   - title: The title
    ///   - isTimerSet: The timer is set indicator
    ///   - isDone: The check box is on indicator
    func applyData (title: String, isTimerSet: Bool, isDone: Bool) {
        titleLabel.text = title
        timerImageView.image = isTimerSet ? Constants.timerImage : nil
        checkImageView.image = isDone ? Constants.checkImage : nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        checkBoxView.layer.borderColor = UIColor.lightGray.cgColor
        checkBoxView.layer.borderWidth = Constants.checkboxBorderWith
    }
    
}
