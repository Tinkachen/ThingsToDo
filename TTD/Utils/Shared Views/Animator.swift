//
//  Animator.swift
//  TTD
//
//  Created by Catharina Herchert on 28.08.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

private enum Constants {
    
    static let duration: Double = 1
}

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // Variables
    
    var isPresenting = true
    
    var originFrame = CGRect.zero
    
    var dismissCompletion: (()->Void)!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let herbView = isPresenting ? toView : transitionContext.view(forKey: .from)!
        
        let initialFrame = isPresenting ? originFrame : herbView.frame
        let finalFrame = isPresenting ? herbView.frame : originFrame
        
        let xScaleFactor = isPresenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = isPresenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if isPresenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            herbView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: herbView)
        
        UIView.animate(withDuration: Constants.duration, delay:0.0,
                       usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,
                       animations: {
                        herbView.transform = self.isPresenting ? CGAffineTransform.identity : scaleTransform
                        herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            if !self.isPresenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })
    }
}
