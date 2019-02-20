//
//  NibLoadable.swift
//  TTD
//
//  Created by Catharina Herchert on 22.01.19.
//  Copyright © 2019 Catharina Herchert. All rights reserved.
//

import UIKit

/// Nibloadable protocol
protocol NibLoadable where Self: UIView {
    
    /// Loads the view from a nib
    ///
    /// - Returns: The view
    func fromNib () -> UIView?
}

// MARK: - NibLoadable extension
extension NibLoadable {
    
    /// Load the view from a nib
    ///
    /// - Returns: The view
    @discardableResult
    func fromNib () -> UIView? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { return nil }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.edges(to: self)
        return contentView
    }
}
