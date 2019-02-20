//
//  TodoListViewModel.swift
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
        
        /// Key for the Entity
        static let listKey = "List"
        
        /// Key for id
        static let idKey = "id"
        
        /// Key for gradient
        static let gradientKey = "gradient"
        
        /// Key for icon
        static let iconKey = "icon"
        
        /// Key for title
        static let titleKey = "title"
        
        /// Key for passcode
        static let passcodeKey = "passcode"
    }
}

/// The service for a new todo list
struct TodoListService: MainService {
    
    /// The managed objects for the todo lists
    private static var listObjects = [NSManagedObject]()
    
    /// The todo list view models
    private static var listViewModels = [TodoListViewModel]()
    
    /// Reads the local stored view models for todo lists
    ///
    /// - Returns: An array of the todo list view models
    static func getListViewModels () -> [TodoListViewModel] {
        
        guard let contextUnwrapped = context else {
            return [TodoListViewModel]()
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.KeyPaths.listKey)
        
        do {
            listObjects = try contextUnwrapped.fetch(fetchRequest)
        } catch let error {
            print("Could not fetch. \(error), \(String(describing: error._userInfo))", self)
            return [TodoListViewModel]()
        }
        
        if listObjects.count > 0 { listViewModels.removeAll() }
        
        listObjects.forEach {
            
            guard let gradient = (($0.value(forKey: Constants.KeyPaths.gradientKey) as? Int).map { Theme.gradientForId($0)}),
                  let icon = (($0.value(forKey: Constants.KeyPaths.iconKey) as? Int).map { Icon(rawValue: $0) }) as? Icon,
                  let id = $0.value(forKey: Constants.KeyPaths.idKey) as? String else  {
                return
            }
            
            listViewModels.append(TodoListViewModel(id: id,
                                                    gradient: gradient,
                                                    icon: icon,
                                                    title: $0.value(forKey: Constants.KeyPaths.titleKey) as? String,
                                                    passcode: $0.value(forKey: Constants.KeyPaths.passcodeKey) as? Int,
                                                    tasks: TodoTaskService.getTaskViewModels(forList: id)))
        }
        
        return listViewModels
    }
    
    /// Reloads the passed view model
    ///
    /// - Parameter viewModel: The view model that need to be reloaded
    /// - Returns: The reloaded todo list view model
    static func reloadListViewModel (_ viewModel: TodoListViewModel) -> TodoListViewModel {
        let newViewModel = getListViewModels().filter { $0.id == viewModel.id }.first
        return newViewModel!
    }
    
    /// Saves the passed new view model to the local storage
    ///
    /// - Parameters:
    ///   - viewModel: The new todo list view model
    ///   - completion: Completion handler for successful saving to the local storage
    static func saveNewListViewModel (_ viewModel: TodoListViewModel, completion: @escaping ((_ error: Error?)->Void)) {
        
        guard let contextUnwrapped = context else {
            completion(ErrorMessage.noContext)
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.KeyPaths.listKey, in: contextUnwrapped) else {
            completion(ErrorMessage.noEntity)
            return
        }
        
        let vm = NSManagedObject(entity: entity, insertInto: contextUnwrapped)
        
        vm.setValue(viewModel.id, forKey: Constants.KeyPaths.idKey)
        vm.setValue(viewModel.gradient.id, forKey: Constants.KeyPaths.gradientKey)
        vm.setValue(viewModel.icon.rawValue, forKey: Constants.KeyPaths.iconKey)
        vm.setValue(viewModel.title, forKey: Constants.KeyPaths.titleKey)
        vm.setValue(viewModel.passcode, forKey: Constants.KeyPaths.passcodeKey)
        
        do {
            try contextUnwrapped.save()
            listObjects.append(vm)
            listViewModels.append(viewModel)
            completion(nil)
            return
        } catch let error {
            completion(error)
        }
        
        completion(ErrorMessage.unknown)
    }
    
    /// Updates the passed view model in the local storage
    ///
    /// - Parameters:
    ///   - viewModel: The view model for the update
    static func updateListViewModel (_ viewModel: TodoListViewModel) {
        
        guard let contextUnwrapped = context else {
            print(ErrorMessage.noContext, self)
            return
        }
        
        listObjects.forEach {
            if ($0.value(forKey: Constants.KeyPaths.idKey) as? String) == viewModel.id {
                $0.setValue(viewModel.gradient.id, forKey: Constants.KeyPaths.gradientKey)
                $0.setValue(viewModel.icon.rawValue, forKey: Constants.KeyPaths.iconKey)
                $0.setValue(viewModel.title, forKey: Constants.KeyPaths.titleKey)
                $0.setValue(viewModel.passcode, forKey: Constants.KeyPaths.passcodeKey)
            }
        }
        
        for i in 0..<listViewModels.count {
            listViewModels[i] = viewModel
        }
        
        do {
            try contextUnwrapped.save()
        } catch let error {
            print(error.localizedDescription, self)
        }
    }
    
    /// Deletes the list view model
    ///
    /// - Parameter viewModel: The view model to be deleted
    static func deleteListViewModel (_ viewModel: TodoListViewModel) {
        guard let contextUnwrapped = context else {
            print(ErrorMessage.noContext, self)
            return
        }
        
        listObjects.forEach {
            if ($0.value(forKey: Constants.KeyPaths.idKey) as? String) == viewModel.id {
                contextUnwrapped.delete($0)
                listViewModels = getListViewModels()
            }
        }
        
        do {
            try contextUnwrapped.save()
        } catch let error {
            print(error.localizedDescription, self)
        }
    }
    
    /// Delivers the total count of tasks that have to be finsched today
    ///
    /// - Returns: The total count
    static func getTotalCountOfTodayTasks () -> Int {
        var totalTodayTaskCount = 0
        listViewModels.forEach { (listViewModel) in
            listViewModel.tasks?.forEach({ (taskViewModel) in
                totalTodayTaskCount += taskViewModel.mustBeFinishedToday() ? 1 : 0
            })
        }
        
        return totalTodayTaskCount;
    }
}
