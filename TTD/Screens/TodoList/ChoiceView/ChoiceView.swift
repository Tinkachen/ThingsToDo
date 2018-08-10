//
//  ChoiceView.swift
//  TTD
//
//  Created by Catharina Herchert on 10.08.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import UIKit

/// Private constants
private enum Constants {
    
    /// The id of the collection view cell
    static let collectionViewCellId = "ChoiceViewCollectionViewCell"
    
    /// The size of the collection view cell
    static let collectionViewCellSize = CGSize(width: 50, height: 50)
    
    /// The strings
    enum Strings {
        
        /// The title for the icon view
        static let iconViewTitle = NSLocalizedString("CV_icon_view_title", comment: "The view title for icons")
        
        /// The title for the gradient view
        static let gradientViewTitle = NSLocalizedString("CV_gradient_view_title", comment: "The view title for gradients")
        
        /// The title for the done button
        static let doneButtonText = NSLocalizedString("CV_done_button", comment: "Done button text")
    }
}

/// Collection view to pick up a specific value (icon / gradient)
class ChoiceView: UIView {
    
    // MARK: - Outlets
    
    /// The collection view
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    /// The label for the title of the view
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    /// The finish button for the view
    @IBOutlet fileprivate weak var doneButton: UIButton!
    
    // MARK: - Variables
    var forGradients: Bool = false
    
    /// The callback for selecting a gradient
    var gradientCallback: ((_ gradient: Gradient)->Void)!
    
    /// The callback for selecting an icon
    var iconCallback: ((_ icon: Icon)->Void)!
    
    /// The callback for closing the view
    var closeCallback: (()->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Title
        self.titleLabel.text = forGradients ? Constants.Strings.gradientViewTitle : Constants.Strings.iconViewTitle
        
        // Setup collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.collectionViewCellId, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCellId)
        
        // Done Button
        doneButton.setTitle(Constants.Strings.doneButtonText, for: .normal)
        doneButton.addTarget(self, action: #selector(closeViewButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    /// Closes the view
    @objc fileprivate func closeViewButtonPressed () {
        closeCallback()
    }
}

// MARK: - Collection View Extension
extension ChoiceView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.collectionViewCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forGradients ? Array(Themes.allThemes.keys).count : Array(Icons.allIcons.keys).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellId, for: indexPath) as? ChoiceViewCollectionViewCell else {
            fatalError("Could not instanciate collection view cell!")
        }
        
        let image = forGradients ? CAGradientLayer(size: Constants.collectionViewCellSize, colors: Array(Themes.allThemes.keys)[indexPath.row]).createGradientImage() : Icons.getIcon(Array(Icons.allIcons.keys)[indexPath.row])
        
        cell.applyData(image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        forGradients ? gradientCallback(Array(Themes.allThemes.keys)[indexPath.row]) : iconCallback(Array(Icons.allIcons.keys)[indexPath.row])
    }
}
