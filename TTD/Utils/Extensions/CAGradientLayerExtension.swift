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
    
    private struct Properties {
        static let start = CGPoint(x: 0, y: 0.5)
        static let end = CGPoint(x: 1, y: 0.5)
    }
    
    /// Creates a gradient and fills up the view
    ///
    /// - Parameters:
    ///   - frame: The frame where the gradient will be displayed
    ///   - colors: The colors for the gradient
    convenience init (frame: CGRect, colors: [CGColor]) {
        self.init()
        self.frame = frame
        
        self.colors = colors
        startPoint = Properties.start
        endPoint = Properties.end
    }
    
    /// Creates a gradient and fills up the view
    ///
    /// - Parameters:
    ///   - size: The size of the gradient
    ///   - colors: The colors for the gradient
    convenience init (size: CGSize, colors: Gradient) {
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.colors = Themes.getTheme(colors).gradient
        startPoint = Properties.start
        endPoint = Properties.end
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
