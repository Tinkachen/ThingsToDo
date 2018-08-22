//
//  TodoTaskViewModel.swift
//  TTD
//
//  Created by Catharina Herchert on 11.06.18.
//  Copyright © 2018 Catharina Herchert. All rights reserved.
//

import Foundation
import CoreData

/// Private constants
private enum Constants {
    
    /// The key paths for the todo list entity
    enum KeyPaths {
        
        /// Key for the entity
        static let taskKey = "Task"
        
        /// Key for list id
        static let listIdKey = "listId"
        
        /// Key for task id
        static let taskIdKey = "taskId"
        
        /// Key for the description
        static let taskDescriptionKey = "taskDescriptionKey"
        
        /// Key for the end date
        static let taskEndDateKey = "taskEndDate"
        
        /// Key for the timer set indicator
        static let isTimerSetKey = "isTimerSet"
        
        /// Key for the priority
        static let priorityKey = "priority"
        
        /// Key for the is done indicator
        static let isDoneKey = "isDone"
    }
}

/// The service for creating a new task to a todo list
struct TodoTaskService: MainService {
    
    /// The task objects
    private static var taskObjects = [NSManagedObject]()
    
    /// The task view models
    private static var taskViewModels = [TodoTaskViewModel]()
    
    /// Reads the local stored view models for todo tasks of the passed list id
    ///
    /// - Parameter listId: The list id
    /// - Returns: An array of the todo tasks view models
    static func getTaskViewModels (forList listId: String) -> [TodoTaskViewModel] {
        
        guard let contextUnwrapped = context else {
            return [TodoTaskViewModel]()
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.KeyPaths.taskKey)
        
        do {
            taskObjects = try contextUnwrapped.fetch(fetchRequest)
        } catch let error as Error {
            print("Could not fetch. \(error), \(String(describing: error._userInfo))")
            return [TodoTaskViewModel]()
        }
        
        if taskObjects.count > 0 { taskViewModels.removeAll() }
        
        taskObjects.forEach {
            taskViewModels.append(TodoTaskViewModel(listId: $0.value(forKey: Constants.KeyPaths.listIdKey) as? String,
                                                    taskId: $0.value(forKey: Constants.KeyPaths.taskIdKey) as? String,
                                                    taskDescription: $0.value(forKey: Constants.KeyPaths.taskDescriptionKey) as? String,
                                                    taskEndDate: $0.value(forKey: Constants.KeyPaths.taskEndDateKey) as? Date,
                                                    isTimerSet: $0.value(forKey: Constants.KeyPaths.isTimerSetKey) as? Bool ?? false,
                                                    priority: ($0.value(forKey: Constants.KeyPaths.priorityKey) as? Int).map { PriorityLevel(rawValue: $0) } ?? .none,
                                                    isDone: $0.value(forKey: Constants.KeyPaths.isDoneKey) as? Bool ?? false))
        }
        
        return taskViewModels
    }
    
    /// Saves the passed new todo task view model to the local storage
    ///
    /// - Parameters:
    ///   - viewModel: The new todo taks view model
    ///   - completion: Completion handler for successful saving to the local storage
    static func saveNewTaskViewModel (_ viewModel: TodoTaskViewModel, completion: @escaping ((_ error: Error?)->Void)) {
        
        guard let contextUnwrapped = context else {
            completion(ErrorMessage.noContext)
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.KeyPaths.taskKey, in: contextUnwrapped) else {
            completion(ErrorMessage.noEntity)
            return
        }
        
        let vm = NSManagedObject(entity: entity, insertInto: contextUnwrapped)
        
        vm.setValue(viewModel.listId, forKey: Constants.KeyPaths.listIdKey)
        vm.setValue(UUID().uuidString, forKey: Constants.KeyPaths.taskIdKey)
        vm.setValue(viewModel.taskDescription, forKey: Constants.KeyPaths.taskDescriptionKey)
        vm.setValue(viewModel.taskEndDate, forKey: Constants.KeyPaths.taskEndDateKey)
        vm.setValue(viewModel.isTimerSet, forKey: Constants.KeyPaths.isTimerSetKey)
        vm.setValue(viewModel.priority, forKey: Constants.KeyPaths.priorityKey)
        vm.setValue(viewModel.isDone, forKey: Constants.KeyPaths.isDoneKey)
        
        do {
            try contextUnwrapped.save()
            taskObjects.append(vm)
            taskViewModels.append(viewModel)
            completion(nil)
        } catch let error as Error {
            completion(error)
        }
        
        completion(ErrorMessage.unknown)
    }
    
    /// Updates the passed view model in the local storage
    ///
    /// - Parameters:
    ///   - viewModel: The view model for the update
    static func updateTaskViewModel (_ viewModel: TodoTaskViewModel) {
        
        taskObjects.forEach {
            if ($0.value(forKey: Constants.KeyPaths.taskIdKey) as? String) == viewModel.taskId &&
               ($0.value(forKey: Constants.KeyPaths.listIdKey) as? String) == viewModel.listId {
                $0.setValue(viewModel.listId, forKey: Constants.KeyPaths.listIdKey)
                $0.setValue(viewModel.taskId, forKey: Constants.KeyPaths.taskIdKey)
                $0.setValue(viewModel.taskDescription, forKey: Constants.KeyPaths.taskDescriptionKey)
                $0.setValue(viewModel.taskEndDate, forKey: Constants.KeyPaths.taskEndDateKey)
                $0.setValue(viewModel.isTimerSet, forKey: Constants.KeyPaths.isTimerSetKey)
                $0.setValue(viewModel.priority, forKey: Constants.KeyPaths.priorityKey)
                $0.setValue(viewModel.isDone, forKey: Constants.KeyPaths.isDoneKey)
            }
        }
        
        for i in 0..<taskViewModels.count {
            taskViewModels[i] = viewModel
        }
    }
}
