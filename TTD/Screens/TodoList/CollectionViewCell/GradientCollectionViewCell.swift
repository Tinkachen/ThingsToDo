//
//  GradientCollectionViewCell.swift
//  TTD
//
//  Created by Catharina Herchert on 08.02.19.
//  Copyright © 2019 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The border width
    static let borderWidth: CGFloat = 1.0
}

/// Collection view cell for displaying gradients
class GradientCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    /// The container view
    @IBOutlet fileprivate weak var containerView: UIView!
    
    /// The selection state view
    @IBOutlet fileprivate weak var selectionStateView: UIView!
    
    /// The gradient colors
    var gradient: [CGColor]!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selectionStateView.layer.cornerRadius = selectionStateView.frame.height / 2
        selectionStateView.layer.borderColor = UIColor.white.cgColor
        selectionStateView.layer.borderWidth = Constants.borderWidth
        selectionStateView.backgroundColor = .clear
        
        containerView.createCircularGradient(colors: gradient)
        
    }
    
    /// Sets up the selection state view
    ///
    /// - Parameter bool: Indicator if the view should be setup or hidden
    private func setupSelectionStateView (_ bool: Bool) {
        selectionStateView.isHidden = !bool
        if !selectionStateView.isHidden {
            selectionStateView.layer.cornerRadius = selectionStateView.frame.height / 2
            selectionStateView.layer.borderColor = UIColor.white.cgColor
            selectionStateView.layer.borderWidth = Constants.borderWidth
            selectionStateView.backgroundColor = .clear
        }
    }
    
    /// Applies the passed data to the collection view cell
    ///
    /// - Parameter gradient: The gradient enum raw value
    func applyData (_ gradient: Gradient) {
        self.gradient = gradient.gradient
    }
    
    override var isSelected: Bool {
        didSet {
            setupSelectionStateView(isSelected)
        }
    }
}
