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
    
    /// <#Description#>
    func updateListViewModel () {
        TodoListService.updateListViewModel(self)
    }
    
    /// <#Description#>
    func deleteListViewModel () {
        TodoListService.deleteListViewModel(self)
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func getDonePercentage () -> CGFloat {
        var doneItems = 0
        
        if let tasksUnwrapped = tasks {
            tasksUnwrapped.forEach {
                doneItems = doneItems + ($0.isDone ? 1 : 0)
            }
            
            return tasksUnwrapped.count == 0 ? CGFloat(0) : CGFloat(doneItems/tasksUnwrapped.count)
        }
        
        return CGFloat(doneItems)
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func image () -> UIImage? {
        return Icons.getIcon(icon)
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    func getMainColor () -> UIColor {
        return Themes.getTheme(gradient).main
    }
    
    func getGradient () -> [CGColor] {
        return Themes.getTheme(gradient).gradient
    }
}
