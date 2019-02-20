//
//  CollectionViewExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 09.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

// MARK: - UICollectionView Extension
extension UICollectionView {
    
    /// Sets an empty view with a passed message and button callback
    ///
    /// - Parameters:
    ///   - message: The message
    ///   - callback: The button callback
    func setEmptyViewWithMessage (_ message: String, AndButtonTitle buttonTitle: String, AndCallback callback: (() -> Void)?) {
        let emptyView: EmptyView = .fromNib()
        emptyView.createWithMessage(message, AndButtonTitle: buttonTitle, AndCallback: callback)
        self.backgroundView = emptyView
    }
    
    /// Restores the collection view background to default value
    func restore () {
        self.backgroundView = nil
    }
}
