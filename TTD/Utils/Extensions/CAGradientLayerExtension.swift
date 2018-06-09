//
//  CAGradientLayerExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 13.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit


// MARK: - Extension of CA Gradient Layer
extension CAGradientLayer {
    
    /// Creates a gradient and fills up the view
    ///
    /// - Parameters:
    ///   - frame: The frame where the gradient will be displayed
    ///   - colors: The colors for the gradient
    convenience init (frame: CGRect, colors: [CGColor]) {
        self.init()
        self.frame = frame
        
        self.colors = colors
        startPoint = CGPoint(x: 0, y: 0.5)
        endPoint = CGPoint(x: 1, y: 0.5)
    }
    
    /// Convertes the gradient to an image
    ///
    /// - Returns: The gradient as an image
    func createGradientImage () -> UIImage? {
        var image: UIImage? = nil
        
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        return image
    }
}
