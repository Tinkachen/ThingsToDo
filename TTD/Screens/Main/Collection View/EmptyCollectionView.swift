//
//  EmptyCollectionView.swift
//  TTD
//
//  Created by Catharina Herchert on 09.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The Empty Collection View
class EmptyCollectionView: UIView {
    
    // MARK: - Outlets
    
    /// The no cards label
    @IBOutlet fileprivate weak var noCardsLabel: UILabel!
    
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
    func createWithMessage (_ message: String, AndCallback callback: (() -> Void)?) {
        self.callback = callback
        self.noCardsLabel.text = message
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - Buttons Actions
    
    /// The action for the button
    ///
    /// - Parameter sender: The sender of the event
    @IBAction func addNewCard (_ sender: UIButton) {
        callback?()
    }
}
