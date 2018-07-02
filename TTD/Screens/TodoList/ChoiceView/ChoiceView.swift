//
//  ChoiceView.swift
//  TTD
//
//  Created by Catharina Herchert on 11.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The id of the collection view cell
    static let collectionViewCellId = "ChoiceViewCollectionViewCell"
    
    /// The size of the collection view cell
    static let collectionViewCellSize = CGSize(width: 20, height: 20)
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
    private var forGradients: Bool = false
    
    /// The gradient data
    private var gradients: [Gradient : Theme] = [:]
    
    /// The callback for selecting a gradient
    private var gradientCallback: ((_ gradient: Gradient)->Void)!
    
    /// The icon data
    private var icons: [Icon : UIImage?] = [:]
    
    /// The callback for selecting an icon
    private var iconCallback: ((_ icon: Icon)->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setup collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.collectionViewCellId, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCellId)
        
        doneButton.addTarget(self, action: #selector(closeViewButtonPressed), for: .touchUpInside)
    }
    
    /// Sets up the view with the passed informations for gradients
    ///
    /// - Parameter title: The title of the view
    /// - Parameter data: The data for the collection view
    func setupForGradients (_ title: String, andData data: [Gradient : Theme], callback: @escaping ((_ gradient: Gradient)->Void)) {
        forGradients = true
        self.titleLabel.text = title
        self.gradientCallback = callback
    }
    
    /// Sets up the view with the passed informations for icons
    ///
    /// - Parameter title: The title of the view
    /// - Parameter data: The data for the collection view
    func setupForIcons (_ title: String, andData data: [Icon : UIImage?], callback: @escaping ((_ icon: Icon)->Void)) {
        forGradients = false
        self.titleLabel.text = title
        self.iconCallback = callback
    }
    
    // MARK: - Actions
    
    /// Closes the view
    @objc fileprivate func closeViewButtonPressed () {
        
    }
}

// MARK: - Collection View Extension
extension ChoiceView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.collectionViewCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forGradients ? Array(gradients.keys).count : Array(icons.keys).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellId, for: indexPath) as? ChoiceViewCollectionViewCell else {
            fatalError("Could not instanciate collection view cell!")
        }
        
        return cell
    }
}
