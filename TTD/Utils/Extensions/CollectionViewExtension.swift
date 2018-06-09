//
//  CollectionViewExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 09.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Sets an empty view with a passed message and button callback
    ///
    /// - Parameters:
    ///   - message: The message
    ///   - callback: The button callback
    func setEmptyViewWithMessage (_ message: String, AndCallback callback: (() -> Void)?) {
        let emptyView: EmptyCollectionView = .fromNib()
        emptyView.createWithMessage(message, AndCallback: callback)
    }
    
    /// Restores the collection view background to default value
    func restore () {
        self.backgroundView = nil
    }
}
