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
    
    /// Instance for choice view
    convenience init (WithColor color: UIColor,
                      selectionCallback: @escaping ((_ gradient: Gradient?, _ icon: Icon?) -> Void)) {
        self.init(frame: UIScreen.main.bounds)
        initializeCustomizeTodoListView(WithColor: color, selectionCallback: selectionCallback)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Creates an instance of the choice view with passed data
    ///
    /// - Parameters:
    ///   - color: The current main color of the list
    ///   - selectionCallback: The callback for the selected icon and gradient values
    private func initializeCustomizeTodoListView (WithColor color: UIColor,
                                                  selectionCallback: @escaping ((_ gradient: Gradient?, _ icon: Icon?) -> Void)) {
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        addSubview(backgroundView)
        
        let customizeView: ChoiceView = .fromNib()
        customizeView.customizeCallback = selectionCallback
        customizeView.color = color
        customizeView.closeCallback = {
            self.dismissView()
        }
        
        let dialogWidth = frame.width - 64.0
        let dialogHeight: CGFloat = frame.height * 0.75
        
        dialogView = customizeView
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
