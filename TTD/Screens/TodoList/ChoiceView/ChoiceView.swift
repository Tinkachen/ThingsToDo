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
    static let collectionViewCellSize = CGSize(width: 75, height: 75)
    
    /// The strings
    enum Strings {
        
        /// The title for the icon view
        static let iconViewTitleKey = "CV_icon_view_title".localized
        
        /// The title for the gradient view
        static let gradientViewTitleKey = "CV_gradient_view_title".localized
        
        /// The title for the done button
        static let doneButtonTextKey = "CV_done_button".localized
    }
}

/// Collection view to pick up a specific value (icon / gradient)
class ChoiceView: UIView {
    
    // MARK: - Outlets
    
    /// The collection view
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    /// The segmented controll
    @IBOutlet fileprivate weak var segmentedControl: UISegmentedControl!
    
    /// The finish button for the view
    @IBOutlet fileprivate weak var doneButton: UIButton!
    
    // MARK: - Variables
    var forGradients: Bool = false
    
    /// The optional color for the uiimageview
    var color: UIColor!
    
    /// The customized callback for gradient and icon that had been selected
    var customizeCallback: ((_ gradient: Gradient?, _ icon: Icon?) -> Void)!
    
    /// The selected icon
    private var selectedIcon: Icon?
    
    /// The selected gradient
    private var selectedgradient: Gradient?
    
    /// The callback for closing the view
    var closeCallback: (()->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setup collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.collectionViewCellId, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCellId)
        
        // Done Button
        doneButton.setTitle(Constants.Strings.doneButtonTextKey, for: .normal)
        doneButton.addTarget(self, action: #selector(closeViewButtonPressed), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.segmentedControl.setTitle(Constants.Strings.iconViewTitleKey, forSegmentAt: 0)
        self.segmentedControl.setTitle(Constants.Strings.gradientViewTitleKey, forSegmentAt: 1)
        
        self.segmentedControl.tintColor = .midGray
    }
    
    // MARK: - Actions
    
    /// Closes the view
    @objc fileprivate func closeViewButtonPressed () {
        customizeCallback(selectedgradient, selectedIcon)
        closeCallback()
    }
    
    /// Called when the segmented changed
    ///
    /// - Parameter sender: The sender of the event
    @IBAction fileprivate func segmentDidChange (_ sender: UISegmentedControl) {
        forGradients = !forGradients
        collectionView.reloadData()
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
        
        cell.applyData(image, withTintColor: forGradients ? nil : color)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if forGradients {
            selectedgradient = Array(Themes.allThemes.keys)[indexPath.row]
            if let selectedColor = selectedgradient {
                color = Themes.getTheme(selectedColor).main
            }
        } else {
            selectedIcon = Array(Icons.allIcons.keys)[indexPath.row]
        }
    }
}
