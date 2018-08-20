//
//  ViewExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 08.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Applies a gradient on the view
    ///
    /// - Parameter colors: The colors for the gradient
    func applyGradient (colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// Applies a gradient on the view
    ///
    /// - Parameter colors: The colors for the gradient
    func applyGradient (colors: [CGColor], WithCornerRadius cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = cornerRadius
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradientLayer () {
        self.layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
    }
    
    /// Makes a instance of the passed class connected to the same name nib file
    ///
    /// - Returns: The instance of the class connected to the nib file
    class func fromNib<T: UIView> () -> T {
        let classString = String(describing: T.self)
        guard let nib = Bundle.main.loadNibNamed(classString, owner: nil, options: nil)![0] as? T else {
            fatalError("")
        }
        
        return nib
    }
}
