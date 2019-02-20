//
//  IconCollectionViewCell.swift
//  TTD
//
//  Created by Catharina Herchert on 08.02.19.
//  Copyright © 2019 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The corner radius
    static let cornerRadius: CGFloat = 5.0
}

/// The collection view cell for icons
class IconCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    /// The container view
    @IBOutlet fileprivate weak var containerView: UIView!
    
    /// The image view
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = Constants.cornerRadius
    }
    
    /// Applies the data to the collection view cell
    ///
    /// - Parameter image: The image
    func applyData (_ image: UIImage?) {
        self.imageView.image = image
        self.imageView.tintColor = .midGray
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? .lightGray : .white
        }
    }
}
