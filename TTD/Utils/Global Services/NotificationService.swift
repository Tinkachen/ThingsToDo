//
//  NotificationService.swift
//  TTD
//
//  Created by Catharina Herchert on 13.12.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import UserNotifications

/// The constants for notifications
enum NotificationConstants {
    
    /// The identifiers for notifications
    enum Identifier {
        
        /// The global identifier for notification names
        static let globalId = "TTDReminderLocalNotification"
        
        /// The categoriy identifier
        static let reminderCategoryId = "TTDReminderCategoryLocalNotification"
        
        /// The snooze action identifier
        static let snoozeId = "TTDSnoozeLocalNotification"
        
        /// The done action identifier
        static let doneId = "TTDDoneLocalNotification"
        
        /// The delete action identifier
        static let deleteId = "TTDDeleteLocalNotification"
    }
    
    /// The localized strings
    enum Strings {
        
        /// The localized snooze string
        static let snoozeKey = "NS_snooze".localized
        
        /// The localized done string
        static let doneKey = "NS_done".localized
        
        /// The localized delete string
        static let deleteKey = "NS_delete".localized
    }
    
    /// The content key for the notification user informations
    fileprivate enum Content {
        
        /// The task identifier key
        static let taskIdKey = "taskid"
        
        /// The list identifier key
        static let listIdKey = "listid"
    }
    
    /// The time for snoozing the task (9 min)
    fileprivate static let snoozeTime: TimeInterval = 9 * 60
    
}


/// Service for sending / reciving notification
struct NotificationService {
    
    /// The notification center
    private static let notificationCenter = UNUserNotificationCenter.current()
    
    /// The delegate for notifications
    private static let notificationDelegate = TTDReminderDelegate()
    
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
    static func isNotificationGranted (_ completion: @escaping ((_ granted: Bool) -> Void)) {
        notificationCenter.getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    /// Sets the delegate
    static func setDelegate () {
        notificationCenter.delegate = notificationDelegate
    }
    
    /// Returns the customized notification id for the passend taskId and listId
    ///
    /// - Parameters:
    ///   - taskId: The id of the task
    ///   - listId: The id of the list
    /// - Returns: The customized notification identifier
    private static func getNotficationId (_ listId: String, _ taskId: String) -> String {
        return "\(NotificationConstants.Identifier.globalId)+\(listId)+\(taskId)"
    }
    
    /// Adds a notification to the notification queue
    ///
    /// - Parameter task: The task
    static func addNotificationForTask (_ task: TodoTaskViewModel) {
        // Actions
        let snoozeAction = UNNotificationAction(identifier: NotificationConstants.Identifier.snoozeId,
                                                title: NotificationConstants.Strings.snoozeKey,
                                                options: [])
        let doneAction = UNNotificationAction(identifier: NotificationConstants.Identifier.doneId,
                                              title: NotificationConstants.Strings.doneKey,
                                              options: [])
        let deleteAction = UNNotificationAction(identifier: NotificationConstants.Identifier.deleteId,
                                                title: NotificationConstants.Strings.deleteKey,
                                                options: [.destructive])
        let category = UNNotificationCategory(identifier: NotificationConstants.Identifier.reminderCategoryId,
                                              actions: [snoozeAction, doneAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
        
        // Notification
        let content = UNMutableNotificationContent()
        content.title = task.taskDescription
        content.sound = UNNotificationSound.default()
        content.userInfo = [ NotificationConstants.Content.taskIdKey : task.taskId,
                             NotificationConstants.Content.listIdKey : task.listId
                            ]
        content.categoryIdentifier = NotificationConstants.Identifier.reminderCategoryId
        
        let customIdentifier = getNotficationId(task.listId, task.taskId)
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: task.taskEndDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    
        let request = UNNotificationRequest(identifier: customIdentifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription, self)
            }
        }
    }
    
    /// Removes the task from the list
    ///
    /// - Parameter task: The task view model
    static func removeNotificationFromTask (_ task: TodoTaskViewModel) {
        let customIdentifier = getNotficationId(task.listId, task.taskId)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [customIdentifier])
    }
    
    /// Updates the notification time for the passend view model
    ///
    /// - Parameter task: The task view model
    static func updateNotificationFromTask (_ task: TodoTaskViewModel) {
        removeNotificationFromTask(task)
        addNotificationForTask(task)
    }
    
    // MARK: - Notification Actions
    
    /// Snoozes the notification for the passed task
    ///
    /// - Parameter taskid: The id of the task
    /// - Parameter listId: The id of the list
    static func snoozeNotificationForTaskWithId (_ taskId: String, andListId listId: String) {
        guard var taskViewModel = TodoTaskService.getTaskViewModel(forList: listId, andTask: taskId) else { return }
        
        taskViewModel.taskEndDate = Date().addingTimeInterval(NotificationConstants.snoozeTime)
        taskViewModel.updateTaskViewModel()
        
        updateNotificationFromTask(taskViewModel)
    }
    
    /// Sets the task to the state done
    ///
    /// - Parameters:
    ///   - taskId: The task id
    ///   - andListId: The list id
    static func setTaskDoneForId (_ taskId: String, andListId listId: String) {
        guard var taskViewModel = TodoTaskService.getTaskViewModel(forList: listId, andTask: taskId) else { return }
        taskViewModel.isDone = true
        taskViewModel.updateTaskViewModel()
    }
    
    /// Deletes the task
    ///
    /// - Parameters:
    ///   - taskId: The task id
    ///   - listId: The list id
    static func deleteTaskForId (_ taskId: String, andListId listId: String) {
        guard let taskViewModel = TodoTaskService.getTaskViewModel(forList: listId, andTask: taskId) else { return }
        
        TodoTaskService.deleteTaskViewModel(taskViewModel)
    }
}

/// The delegate for reminder
class TTDReminderDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        guard let taskId = response.notification.request.content.userInfo[NotificationConstants.Content.taskIdKey] as? String,
            let listId = response.notification.request.content.userInfo[NotificationConstants.Content.listIdKey] as? String else {
                completionHandler()
                return
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismissed notification", self)
        case UNNotificationDefaultActionIdentifier:
            print("Opens the app - default notification", self)
        case NotificationConstants.Identifier.snoozeId:
            NotificationService.snoozeNotificationForTaskWithId(taskId, andListId: listId)
        case NotificationConstants.Identifier.doneId:
            NotificationService.setTaskDoneForId(taskId, andListId: listId)
        case NotificationConstants.Identifier.deleteId:
            NotificationService.deleteTaskForId(taskId, andListId: listId)
        default:
            print("Unknown action",self)
        }
        
        completionHandler()
    }
}
