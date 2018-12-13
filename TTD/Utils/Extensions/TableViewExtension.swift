//
//  TableViewExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 13.12.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Sets an empty view with a passed message and button callback
    ///
    /// - Parameters:
    ///   - message: The message
    ///   - callback: The button callback
    func setEmptyViewWithMessage (_ message: String, AndButtonTitle buttonTitle: String, AndCallback callback: (() -> Void)?) {
        let emptyView: EmptyView = .fromNib()
        emptyView.createWithMessage(message, AndButtonTitle: buttonTitle, AndCallback: callback)
    }
    
    /// Restores the collection view background to default value
    func restore () {
        self.backgroundView = nil
    }
}
