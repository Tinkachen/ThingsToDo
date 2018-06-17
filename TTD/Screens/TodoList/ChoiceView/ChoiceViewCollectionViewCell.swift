//
//  ChoiceViewCollectionViewCell.swift
//  TTD
//
//  Created by Catharina Herchert on 17.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// The collection view cell for the choice view
class ChoiceViewCollectionViewCell: UICollectionViewCell {
    
    /// The image view
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// Applys the passed data to the collection view cell
    ///
    /// - Parameter image: The image for the collection view cell
    func applyData (_ image: UIImage?) {
        self.imageView.image = image
    }
}
