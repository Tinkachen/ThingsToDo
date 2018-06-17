//
//  TodoListViewModel.swift
//  TTD
//
//  Created by Catharina Herchert on 17.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

/// The priority level of the tasks
///
/// - low: Low priority level
/// - middle: Middle priority level
/// - high: High priority level
/// - none: No priority level
enum PriorityLevel {
    case low
    case middle
    case high
    case none
}

/// Private constants
private enum Constants {
    
    /// The human readable date format
    static let dateFormat = "dd.MM.YYYY, HH:mm"
    
    /// The local identifier for the date format
    static let localIdentifer = Locale(identifier: "de")
}

/// The view model for the todo list
struct TodoListViewModel {
    
    /// The id (primary key)
    var id: String!
    
    /// The gradient
    var gradient: Gradient!
    
    /// The icon
    var iconName: String!
    
    /// The title
    var title: String!
    
    /// The passcode
    var passcode: Int?
    
    /// The tasks
    var tasks: [TodoTaskViewModel]?
}

/// The view model for the todo task
struct TodoTaskViewModel {
    
    /// The id of the todo list
    var listId: String!
    
    /// The id (primary key)
    var taskId: String!
    
    /// The description
    var taskDescription: String!
    
    /// The end date
    var taskEndDate: Date!
    
    var isTimerSet: Bool = false
    
    /// The priority level
    var priority: PriorityLevel!
    
    var isDone: Bool = false
    
    /// The date formatter
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        formatter.locale = Constants.localIdentifer
        return formatter
    }
    
    /// Formattes the end date of the task to human readable string
    ///
    /// - Returns: The formatted date
    func formattedDate () -> String {
        return "\(dateFormatter.string(from: taskEndDate)) Uhr"
    }
}
