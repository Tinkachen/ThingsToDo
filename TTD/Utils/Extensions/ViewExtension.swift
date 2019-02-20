//
//  ViewExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 08.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The name for the gradient layer
    static let gradientLayerName = "gradientLayer"
}

// MARK: - UIView Extension
extension UIView {
    
    /// Applies a gradient on the view
    ///
    /// - Parameter colors: The colors for the gradient
    /// - Parameter cornerRadius: (optional) Corner radius for the layer
    func applyGradient (colors: [CGColor], WithCornerRadius cornerRadius: CGFloat = 0) {
        let gradientLayer = getGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// Removes the gradient layer
    func removeGradientLayer () {
        if let layers = self.layer.sublayers {
            for layer in layers {
                if (layer.name == Constants.gradientLayerName) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    /// Searches the sublayers for the gradient layer
    ///
    /// - Returns: The gradient layer
    func getGradientLayer () -> CAGradientLayer {
        if let layers = self.layer.sublayers {
            for layer in layers {
                if (layer.name == Constants.gradientLayerName) {
                    return layer as! CAGradientLayer
                }
            }
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = Constants.gradientLayerName
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        return gradientLayer
    }
    
    /// Updates the gradient layer with the passed new colors
    ///
    /// - Parameter gradient: An array of colors for the gradient
    func updateGradientLayer (toGradient gradient: [CGColor]) {
        let gradientLayer = getGradientLayer()
        gradientLayer.colors = gradient
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// Transits from the color set to another color set with percentage state
    ///
    /// - Parameters:
    ///   - from: An array for the 'from' colors
    ///   - to: An array for the 'to' colors
    ///   - percentage: The percentage of the transition between the colors
    func transitToGradient (from: [CGColor], to: [CGColor], percentage: CGFloat) {
        let percentage = max(min(percentage, 100), 0) / 100
        
        let gradientLayer = getGradientLayer()
        
        switch percentage {
        case 0:
            gradientLayer.colors = from
        case 1:
            gradientLayer.colors = to
        default:
            var (toR1, toG1, toB1, toA1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            UIColor(cgColor: to[0]).getRed(&toR1, green: &toG1, blue: &toB1, alpha: &toA1)
            
            var (toR2, toG2, toB2, toA2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            UIColor(cgColor: to[1]).getRed(&toR2, green: &toG2, blue: &toB2, alpha: &toA2)
            
            var (fromR1, fromG1, fromB1, fromA1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            UIColor(cgColor: from[0]).getRed(&fromR1, green: &fromG1, blue: &fromB1, alpha: &fromA1)
            
            var (fromR2, fromG2, fromB2, fromA2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            UIColor(cgColor: from[0]).getRed(&fromR2, green: &fromG2, blue: &fromB2, alpha: &fromA2)
            
            let newColor1 = UIColor(red: toR1 + (toR2 - toR1) * percentage,
                                    green: toG1 + (toG2 - toG1) * percentage,
                                    blue: toB1 + (toB2 - toB1) * percentage,
                                    alpha: toA1 + (toA2 - toA1) * percentage)
            let newColor2 = UIColor(red: fromR1 + (fromR2 - fromR1) * percentage,
                                    green: fromG1 + (fromG2 - fromG1) * percentage,
                                    blue: fromB1 + (fromB2 - fromB1) * percentage,
                                    alpha: fromA1 + (fromA2 - fromA1) * percentage)
            
            gradientLayer.colors = [newColor1, newColor2]
        }
        
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// Transits to gradient
    ///
    /// - Parameters:
    ///   - from: Gradient A
    ///   - to: Gradient B
    func transitToGradient (from: [CGColor], to: [CGColor]) {
        let gradientLayer = getGradientLayer()
        gradientLayer.colors = from
        self.layer.insertSublayer(gradientLayer, at: 0)
    
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            // Set to final colors when animation ends
            gradientLayer.colors = from
        })
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = 0.3
        animation.toValue = to
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "changeColors")
        CATransaction.commit()
    }
    
    /// Pins the edges of the view with constraints
    ///
    /// - Parameters:
    ///   - view: The view that will be modified
    ///   - top: The top constants
    ///   - left: The left/leading constants
    ///   - bottom: The bottom constants
    ///   - right: The right/trailing constants
    func edges(to view: UIView, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
    }
    
    /// Creates a circular gradient
    ///
    /// - Parameter colors: The color array
    func createCircularGradient (colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(gradient)
        
        
        let circularPath = CGMutablePath()
        circularPath.addArc(center: CGPoint.init(x: self.bounds.width / 2, y: self.bounds.height / 2), radius: self.bounds.width / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true, transform: .identity)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circularPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        maskLayer.fillColor = UIColor.red.cgColor
        self.layer.mask = maskLayer

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
