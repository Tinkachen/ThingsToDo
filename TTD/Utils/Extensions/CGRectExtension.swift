//
//  CGRectExtension.swift
//  TTD
//
//  Created by Catharina Herchert on 21.12.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import UIKit

// MARK: - CGRect Extension
extension CGRect {
    
    /// The center value of the rect
    var center: CGPoint {
        return CGPoint(x: width/2 + minX, y: height/2 + minY)
    }
}
