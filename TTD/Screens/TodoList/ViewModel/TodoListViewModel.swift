//
//  TodoListViewModel.swift
//  TTD
//
//  Created by Catharina Herchert on 17.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// The view model for the todo list
struct TodoListViewModel {
    
    /// The id (primary key)
    var id: String!
    
    /// The gradient
    var gradient: Gradient!
    
    /// The icon
    var icon: Icon!
    
    /// The title
    var title: String!
    
    /// The passcode
    var passcode: Int?
    
    /// The tasks
    var tasks: [TodoTaskViewModel]?
    
    /// Updates the tasks
    mutating func updateTasks () {
        tasks = TodoTaskService.getTaskViewModels(forList: id)
    }
    
    /// Reloads the view model
    mutating func reloadViewModel () {
        self = TodoListService.reloadListViewModel(self)
    }
    
    /// Updates the stored list view model
    func updateListViewModel () {
        TodoListService.updateListViewModel(self)
    }
    
    /// Deletes the stored list view model
    func deleteListViewModel () {
        TodoListService.deleteListViewModel(self)
    }
    
    /// Deletes the task view model with the passed index
    ///
    /// - Parameter atIndex: The index of the task view model that should be deleted
    mutating func deleteTaskViewModel (atIndex: Int) {
        guard let tasksUnwrapped = tasks else { return }
        if tasksUnwrapped.count > atIndex {
            tasks?.remove(at: atIndex)
            TodoTaskService.deleteTaskViewModel(tasksUnwrapped[atIndex])
        }
    }
    
    /// Calculates the percentage of the done state
    ///
    /// - Returns: The done percentage raw value
    func getDonePercentage () -> Float {
        var doneItems = 0
        
        if let tasksUnwrapped = tasks {
            tasksUnwrapped.forEach {
                doneItems = doneItems + ($0.isDone ? 1 : 0)
            }

            return tasksUnwrapped.count == 0 ? Float(0) : Float(doneItems)/Float(tasksUnwrapped.count)
        }

        return Float(doneItems)
    }
    
    /// Requests the image of the view model
    ///
    /// - Returns: The image
    func image () -> UIImage? {
        return Icons.getIcon(icon)
    }
    
    /// Requests the main color of the gradient
    ///
    /// - Returns: The color
    func getMainColor () -> UIColor {
        return gradient.main
    }
    
    /// Requests the gradient informations
    ///
    /// - Returns: The gradient
    func getGradient () -> [CGColor] {
        return gradient.gradient
    }
}
