//
//  ChoiceView.swift
//  TTD
//
//  Created by Catharina Herchert on 11.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Collection view to pick up a specific value (icon / gradient)
class ChoiceView: UIView {
    
    // MARK: - Outlets
    
    /// The collection view
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    /// The label for the title of the view
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    /// Sets up the view with the passed informations
    ///
    /// - Parameter title: The title of the view
    /// - Parameter data: The data for the collection view
    func setupWithTitle (_ title: String, andData data: [String : Any]) {
        self.titleLabel.text = title
    }
    
    // MARK: - Actions
    
    /// Closes the view
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func closeViewButtonPressed (_ sender: UIButton) {
        
    }
}

// MARK: - Collection View Extension
extension ChoiceView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
