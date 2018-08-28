//
//  CustomAlertPresenter.swift
//  TTD
//
//  Created by Catharina Herchert on 10.08.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Custom Alert View for modal presenting
class CustomAlert: UIView, Modal {
    
    /// The view for the dialog
    var dialogView: UIView = UIView()
    
    /// The background view
    var backgroundView = UIView()
    
    /// Initializes the gradient picker
    convenience init (gradientCallback callback: @escaping ((_: Gradient)->Void)) {
        self.init(frame: UIScreen.main.bounds)
        initializeGradientView(selectionCallback: callback)
    }
    
    /// Initializes the icon picker
    convenience init (color: UIColor, iconCallback callback: @escaping ((_: Icon)->Void)) {
        self.init(frame: UIScreen.main.bounds)
        initializeIconView(color: color, selectionCallback: callback)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initalizes the view for loading indicator
    private func initializeGradientView (selectionCallback: @escaping ((_ gradient: Gradient)->Void)) {
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        addSubview(backgroundView)
        
        let gradientView: ChoiceView = .fromNib()
        gradientView.forGradients = true
        gradientView.gradientCallback = selectionCallback
        gradientView.closeCallback = {
            self.dismissView()
        }
        
        let dialogWidth = frame.width - 64.0
        let dialogHeight: CGFloat = 300.0
        
        dialogView = gradientView
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: dialogWidth, height: dialogHeight)
        
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    /// Initalizes the view for loading indicator
    private func initializeIconView (color: UIColor, selectionCallback: @escaping ((_ icon: Icon)->Void)) {
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        addSubview(backgroundView)
        
        let gradientView: ChoiceView = .fromNib()
        gradientView.color = color
        gradientView.forGradients = false
        gradientView.iconCallback = selectionCallback
        gradientView.closeCallback = {
            self.dismissView()
        }
        
        let dialogWidth = frame.width - 64.0
        let dialogHeight: CGFloat = 300.0
        
        dialogView = gradientView
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: dialogWidth, height: dialogHeight)
        
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    /// Dismisses the view
    @objc private func dismissView () {
        dismiss(animated: true)
    }
}
