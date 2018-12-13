//
//  OnboardingRequestViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 15.10.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private constants
private enum Constants {
    
    /// The button string for enabling request
    static let enableButtonString = "OVC_enable".localized
}

/// The onboarding request controller
class OnboardingRequestViewController: UIViewController {
    
    // Outlets
    
    /// The image view
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    /// The title label
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    /// The description label
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    
    /// The request button
    @IBOutlet fileprivate weak var requestButton: UIButton!
    
    /// The next button
    @IBOutlet fileprivate weak var nextButton: UIButton!
    
    // Variables
    
    /// The view model
    var viewModel: OnboardingViewModel!
    
    /// The callback for the request button
    var requestButtonCallback: (()->Void)?
    
    /// The callback for the next button
    var nextButtonCallback: (()->Void)?
    
    /// Sets up the callbacks for the buttons
    ///
    /// - Parameters:
    ///   - request: Callback for the passed request
    ///   - next: Callback for the next button
    func setupCallbacks (request: @escaping (()->Void), next: @escaping (()->Void)) {
        requestButtonCallback = request
        nextButtonCallback = next
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
    }
    
    /// Layout the view elements and fill them with data
    private func layoutView () {
        
        self.imageView.image = viewModel.image
        
        self.titleLabel.text = viewModel.title
        
        self.descriptionLabel.text = viewModel.description
        
        self.requestButton.setTitle(Constants.enableButtonString, for: .normal)
    }
    
    
    /// Called when the request button was pressed
    @IBAction fileprivate func requestButtonPressed () {
        requestButtonCallback?()
    }
    
    /// Calles when the next button was pressed
    @IBAction fileprivate func nextButtonPressed () {
        nextButtonCallback?()
    }
    
}
