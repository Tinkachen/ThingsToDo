//
//  EmptyView.swift
//  TTD
//
//  Created by Catharina Herchert on 09.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The Empty View
class EmptyView: UIView {
    
    // MARK: - Outlets
    
    /// The no cards label
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    /// The button
    @IBOutlet fileprivate weak var button: UIButton!
    
    // MARK: - Variables
    
    /// The button callback
    private var callback: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// Creates the empty collection view with passed informations
    ///
    /// - Parameters:
    ///   - message: The message
    ///   - callback: The button callback
    func createWithMessage (_ message: String, AndButtonTitle buttonTitle: String, AndCallback callback: (() -> Void)?) {
        self.callback = callback
        self.button.setTitle(buttonTitle, for: .normal)
        self.titleLabel.text = message
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.tintColor = .white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    // MARK: - Button Actions
    
    /// The action for the button
    ///
    /// - Parameter sender: The sender of the event
    @IBAction func buttonPressed () {
        callback?()
    }
}
