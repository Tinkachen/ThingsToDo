//
//  ButtonExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 24.08.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

// MARK: - UIButton Extension
extension UIButton {
    
    /// Privagte properties
    private struct Properties {
        
        /// The space
        static var _space: CGFloat = 10.0
    }
    
    /// Space between the image and the title (default 10,0)
    var space: CGFloat {
        set (newValue) {
            Properties._space = newValue
        }
        get {
            return Properties._space
        }
    }
    
    /// Left positioned image and place the title right of the image
    func leftImage () {
        let insetAmount = space / 2
        guard let imageView = self.imageView  else {
            return
        }
        self.imageView?.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y, width: imageView.frame.width, height: self.titleLabel?.frame.height ?? imageView.frame.height)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
    }
}
