//
//  PasscodeViewController.swift
//  TTD
//
//  Created by Catharina Herchert on 08.05.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

/// Private Constants of the class
private enum Constants {
    
    /// Strings for the outlets
    enum Strings {
        
        /// The text for a new passcode
        static let newPasscodeText =  NSLocalizedString("PCVC_new_passcode", comment: "Enter new passcode text")
        
        /// The text for repeating the new passcode
        static let repeatNewPasscodeText = NSLocalizedString("PCVC_repeat_new_passcode", comment: "Repeat new passcode text")
        
        /// The text for verifing the passcode
        static let verifyPasscodeText = NSLocalizedString("PCVC_verify_passcode", comment: "Verify saved passcode")
        
        /// The cancel button text
        static let cancelButtonText = NSLocalizedString("PCVC_cancel_btn", comment: "Cancel button text")
    }
    
    /// Constants for the password indicator stack view, shaking animation
    enum ShakePasswordIndicators {
        /// Maximum length for the password
        static let maxPasswordDigits = 4
        
        /// Animation duration for the shaking password stackview
        static let animationDuration = 0.07
        
        /// Repeat count for the animation
        static let animationRepeat: Float = 4
        
        /// Maximum shake distance value
        static let maxShakeDistanz: CGFloat = 10
        
        /// Key value for basic animation
        static let basicAnimationKey = "position"
    }
}

/// Screen for setting and entering a pin (Shortcut PCVC)
class PasscodeViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Title for the screen
    @IBOutlet fileprivate var titleLabel: UILabel!
    
    /// Button for the cancel action
    @IBOutlet fileprivate var cancelButton: UIButton!
    
    /// The stack view (container) of the pin indicators
    @IBOutlet fileprivate var indicatorStackView: UIStackView!
    
    /// The indicators for the pin
    @IBOutlet fileprivate var indicatorView: [UIView]!
    
    // MARK: - Variables
    
    /// The callback for setting a new passcode
    var callback: ((_ passcode: Int?)->Void)!
    
    /// The gradient of the pass code view
    var gradient: Gradient!
    
    /// The view model
    var viewModel: PasscodeViewModel!
    
    private var passcodeArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.applyGradient(colors: Themes.getTheme(gradient).gradient)
        
        indicatorView.forEach {
            $0.layer.cornerRadius = $0.bounds.height / 2
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    /// Set the text to the outlets individualized by the passed state
    ///
    /// - Parameter state: State for the screen
    func setText (forState state: PasscodeType) {
        switch state {
        case .new:
            self.titleLabel.text = Constants.Strings.newPasscodeText
            self.cancelButton.isHidden = false
            break
        case .verify:
            self.titleLabel.text = Constants.Strings.verifyPasscodeText
            self.cancelButton.isHidden = true
            break
        // case verifyNew and default
        default:
            self.titleLabel.text = Constants.Strings.repeatNewPasscodeText
            self.cancelButton.isHidden = false
        }
    }

    // MARK: - Button Actions
    
    /// Cancel action for the screen
    ///
    /// - Parameter sender: The sender of the action
    @IBAction fileprivate func cancelButtonAction (_ sender: UIButton) {
        callback(nil)
        dismissPasscodeView()
    }
    
    /// The action for the passcode button
    ///
    /// - Parameter sender: The sender of the action
    @IBAction fileprivate func passcodeButtonAction (_ sender: PasscodeButton) {
        guard let titleLabelText = sender.titleLabel?.text, let numPadDigit = Int(titleLabelText) else {
            return
        }
        appendPasscodeDigit(with: numPadDigit)
    }
    
    // MARK: - Private helper functions
    
    /// Fills the passcode array with the pressed numpad value
    ///
    /// - Parameter number: The integer value
    private func appendPasscodeDigit (with number: Int) {
        if passcodeArray.count <= Constants.ShakePasswordIndicators.maxPasswordDigits {
            passcodeArray.append(number)
            fillView(at: passcodeArray.count - 1)
            
            if passcodeArray.count == 4 {
                switch viewModel.passcodeType {
                case .new:
                    setNewPasscode(convertArrayToString())
                    break
                case .verifyNew:
                    verifyPasscode {
                        setNewPasscode(convertArrayToString())
                        self.dismissPasscodeView()
                    }
                    break
                default:
                    verifyPasscode {
                        self.dismissPasscodeView()
                    }
                    break
                }
            }
        }
    }
    
    /// Fills the password indicator view at a specific index
    ///
    /// - Parameter index: Index where the view should be filled
    private func fillView(at index: Int) {
        indicatorView[index].backgroundColor = .white
    }
    
    /// Shakes the password indicator stack view if the passcode is incorrect
    private func incorrectPasswordShake () {
        let animation = CABasicAnimation(keyPath: Constants.ShakePasswordIndicators.basicAnimationKey)
        animation.duration = Constants.ShakePasswordIndicators.animationDuration
        animation.repeatCount = Constants.ShakePasswordIndicators.animationRepeat
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: indicatorStackView.center.x - Constants.ShakePasswordIndicators.maxShakeDistanz, y: indicatorStackView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: indicatorStackView.center.x + Constants.ShakePasswordIndicators.maxShakeDistanz, y: indicatorStackView.center.y))
        
        indicatorStackView.layer.add(animation, forKey: Constants.ShakePasswordIndicators.basicAnimationKey)
        
        resetPasscodeIndicators()
    }
    
    // MARK: - Helper Functions
    
    /// Resets the passcode array and the background color of the indicators
    private func resetPasscodeIndicators () {
        passcodeArray.removeAll()
        indicatorView.forEach {
            $0.backgroundColor = .clear
        }
    }
    
    /// Converts the passcode array to a string
    ///
    /// - Returns: The array as a string
    private func convertArrayToString () -> String {
        var passcode = ""
        
        passcodeArray.forEach {
            passcode += String($0)
        }
        
        return passcode
    }
    
    // MARK: - Helper Functions for state
    
    /// Checks if the passcode is equal to the actual stored passcode or the temporary new passcode
    ///
    /// - Parameter completion: Methods that should be performed if the verification is successful
    private func verifyPasscode (completion: () -> Void) {
        let passcode = convertArrayToString()
        var passcodeVerified: Bool
        if viewModel.passcodeType == .verifyNew {
            if (self.viewModel.temporaryNewPasscode == passcode) {
                passcodeVerified = true
            } else {
                passcodeVerified = false
            }
            
        } else {
            passcodeVerified = self.viewModel.passcode == passcode ? true : false
        }
        
        if passcodeVerified {
            completion()
        } else {
            incorrectPasswordShake()
        }
    }
    
    /// Sets a new passcode for the application
    ///
    /// - Parameter passcode: The new passcode
    private func setNewPasscode (_ passcode: String) {
        if viewModel.passcodeType == .new {
            self.viewModel.temporaryNewPasscode = passcode
            resetPasscodeIndicators()
            setText(forState: .verifyNew)
            self.viewModel.passcodeType = .verifyNew
        } else {
            viewModel.passcode = passcode
        }
    }
    
    /// Dismisses the passcode view
    private func dismissPasscodeView () {
        if let navigationControllerUnwrapped = self.navigationController {
            navigationControllerUnwrapped.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
