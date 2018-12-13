//
//  NotificationService.swift
//  TTD
//
//  Created by Catharina Herchert on 13.12.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import UserNotifications

/// Service for sending / reciving notification
struct NotificationService {
    
    /// The notification center
    private static let notificationCenter = UNUserNotificationCenter.current()
    
    /// Asks the user for sending / reciving notification
    static func askForPermissions () {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: { (granted, error) in
            // Enable or disable features based on authorization
        })
    }
    
    /// Returns the authorization status for notification
    ///
    /// - Returns: The status of the authorization
    static func isNotificationGranted () -> Bool {
        var authorizationStatus = false
        notificationCenter.getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else {
                return
            }
            authorizationStatus = true
        }
        
        return authorizationStatus
    }
    
    static func addNotification () {
        
    }
}
