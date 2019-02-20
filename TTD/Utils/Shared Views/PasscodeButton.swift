//
//  PasscodeButton.swift
//  TTD
//
//  Created by Catharina Herchert on 08.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The pass code button
class PasscodeButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tintColor = .white
        setTitleColor(.white, for: .normal)
        
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.height, height: frame.size.height)
        layer.cornerRadius = frame.size.height / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
}
