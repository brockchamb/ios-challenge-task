//
//  TaskController.swift
//  iOSTaskChallenge
//
//  Created by admin on 4/15/16.
//  Copyright © 2016 Brock. All rights reserved.
//

import UIKit
import CoreData

class TaskController {
    
    private let taskKey = "Task"
    
    static let sharedController = TaskController()
    
    var task: [Task] {
        let request = NSFetchRequest(entityName: "Task")
        
        do {
            if let array = try Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as? [Task] {
                return array
            } else {
                return []
            }
        } catch {
            return []
        }
        
    }
    
    var completeTask: [Task] {
        return task.filter({$0.isComplete.boolValue})
    }
    
    var incompleteTask: [Task] {
        return task.filter({$0.isComplete.boolValue})
    }
    
    func addTask(task: Task) {
        saveToPersistentStore()
    }
    
    func removeTask(task: Task) {
        task.managedObjectContext?.deleteObject(task)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error")
        }
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let documentsPath: AnyObject = directorySearchResults[0]
        let entriesPath = documentsPath.stringByAppendingString("/\(key).plist")
        return entriesPath
    }
    
    
    
}
