//
//  ChoiceViewCollectionViewCell.swift
//  TTD
//
//  Created by Catharina Herchert on 17.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

private enum Constants {
    
    static let borderWith: CGFloat = 1.0
}

/// The collection view cell for the choice view
class ChoiceViewCollectionViewCell: UICollectionViewCell {
    
    /// The container view
    @IBOutlet fileprivate weak var containerView: UIView!
    
    /// The image view
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = containerView.bounds.height / 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = Constants.borderWith
        
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        
    }
    
    /// Applys the passed data to the collection view cell
    ///
    /// - Parameter image: The image for the collection view cell
    func applyData (_ image: UIImage?) {
        self.imageView.image = image
    }
}
