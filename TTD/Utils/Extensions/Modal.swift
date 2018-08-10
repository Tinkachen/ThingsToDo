//
//  Modal.swift
//  TTD
//
//  Created by Catharina Herchert on 10.08.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import UIKit

/// The protocol
protocol Modal {
    
    /// Presents the view
    ///
    /// - Parameter animated: Indicator if the view appearance should be animated
    func show (animated:Bool)
    
    /// Dismisses the view
    ///
    /// - Parameter animated:  Indicator if the view disappearance should be animated
    func dismiss (animated:Bool)
    
    /// The background view
    var backgroundView: UIView {get}
    
    /// The dialog view
    var dialogView: UIView {get set}
}

// MARK: - Presentation for a view
extension Modal where Self:UIView {
    
    /// Presents the view
    ///
    /// - Parameter animated: Indicator if the view appearance should be animated
    func show (animated:Bool) {
        self.backgroundView.alpha = 0
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0.66
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center  = self.center
            }, completion: { (completed) in
                
            })
        } else {
            self.backgroundView.alpha = 0.66
            self.dialogView.center  = self.center
        }
    }
    
    /// Dismisses the view
    ///
    /// - Parameter animated:  Indicator if the view disappearance should be animated
    func dismiss (animated:Bool) {
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in
                
            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        } else{
            self.removeFromSuperview()
        }
    }
}
