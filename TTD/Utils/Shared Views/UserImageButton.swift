//
//  UserImageButton.swift
//  TTD
//
//  Created by Catharina Herchert on 13.12.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private Constants
private enum Constants {
    
    static let titleLabelString = "UIB_title".localized
}

/// The user image button
class UserImageButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageView = imageView,
              let titleLabel = titleLabel else { return }
        
        let padding: CGFloat = 15
        imageEdgeInsets = UIEdgeInsets(top: 5,
                                       left: titleLabel.frame.width - padding,
                                       bottom: 5,
                                       right: -titleLabel.frame.width - padding)
        titleEdgeInsets = UIEdgeInsets(top: 0,
                                       left: -imageView.frame.width,
                                       bottom: 0,
                                       right: imageView.frame.width)
        
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1.0
        
    }
    
}
