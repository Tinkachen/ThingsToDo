//
//  CollectionView.swift
//  TTD
//
//  Created by Catharina Herchert on 21.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// <#Description#>
class CollectionView: UICollectionViewCell {
    
    /// <#Description#>
    @IBOutlet fileprivate weak var containerView: UIView!
    
    /// <#Description#>
    @IBOutlet fileprivate weak var badgeImageContainerView: UIView!
    
    /// <#Description#>
    @IBOutlet fileprivate weak var badgeImageView: UIImageView!
    
    /// <#Description#>
    @IBOutlet fileprivate weak var taskLabel: UILabel!
    
    /// <#Description#>
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    /// <#Description#>
    @IBOutlet fileprivate weak var progressView: UIView!
    
    /// <#Description#>
    private var viewModel: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// <#Description#>
    ///
    /// - Parameter viewModel: <#viewModel description#>
    func setupView (_ viewModel: String) {
        self.viewModel = viewModel
    }
    
}
