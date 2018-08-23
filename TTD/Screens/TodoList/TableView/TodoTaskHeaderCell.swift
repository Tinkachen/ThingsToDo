//
//  TodoTaskHeaderCell.swift
//  TTD
//
//  Created by Catharina Herchert on 17.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The header cell for the todo tasks
class TodoTaskHeaderCell: UIView {
    
    /// The label for the date
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white
    }
    
    /// Sets the title for the header view
    ///
    /// - Parameter title: The title for the header view (date)
    func setTitle (_ title: String) {
        self.dateLabel.text = title
        self.dateLabel.textColor = .lightGray
    }
}
