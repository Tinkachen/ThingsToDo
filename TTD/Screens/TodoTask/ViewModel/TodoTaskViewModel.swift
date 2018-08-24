//
//  TodoTaskViewModel.swift
//  TTD
//
//  Created by Catharina Herchert on 22.08.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation

/// The priority level of the tasks
///
/// - low: Low priority level
/// - middle: Middle priority level
/// - high: High priority level
/// - none: No priority level
enum PriorityLevel: Int {
    case no = 0
    case low
    case middle
    case high
}

/// Private constants
private enum Constants {
    
    /// The human readable date format
    static let dateFormat = "dd.MM.YYYY, HH:mm"
    
    /// The local identifier for the date format
    static let localIdentifer = Locale(identifier: "de")
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
    
    /// Indicator if a time has been set
    var isTimerSet: Bool = false
    
    /// The priority level
    var priority: PriorityLevel!
    
    /// Indicator if the task has been done
    var isDone: Bool = false
    
    /// The notes
    var notes: String = ""
    
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
    
    /// Date for sorting without time
    ///
    /// - Returns: The  date without time
    func dateForSorting () -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: taskEndDate)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }
    
    /// Updates the stored list view model
    func updateTaskViewModel () {
        TodoTaskService.updateTaskViewModel(self)
    }
}
