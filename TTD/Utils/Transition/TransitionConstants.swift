//
//  CardTransitionConstants.swift
//  TTD
//
//  Created by Catharina Herchert on 18.01.19.
//  Copyright © 2019 Catharina Herchert. All rights reserved.
//

import UIKit

/// Constants for transitions
enum TransitionConstants {
    
    /// The factor for highlighting the cards
    static let cardHighlightedFactor: CGFloat = 0.96
    
    /// The animation duration for the status bar
    static let statusBarAnimationDuration: TimeInterval = 0.4
    
    /// The corner radius for the cards
    static let cardCornerRadius: CGFloat = 16
    
    /// The dismissal animation duration
    static let dismissalAnimationDuration = 0.6
    
    /// Styles for the vertail expanding
    ///
    /// - fromTop: Expands from the top
    /// - fromCenter: Expands from center
    enum VerticalExpandingStyle {
        case fromTop
        case fromCenter
    }
    
    /// The vertical card expanding style
    static let cardVerticalExpandingStyle: VerticalExpandingStyle = .fromTop
    
    /// Indicator if the weird top inset should be fixed
    static let isEnabledWeirdTopInsetsFix = true
    
    /// Indicator if the debug animating view is enabled
    static let isEnabledDebugAnimatingViews = false
    
}
