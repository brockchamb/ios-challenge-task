//
//  TaskTableViewController.swift
//  iOSTaskChallenge
//
//  Created by admin on 4/15/16.
//  Copyright © 2016 Brock. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.sharedController.task.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! ButtonTableViewCell
        let task = TaskController.sharedController.task[indexPath.row]
        
        cell.delegate = self
        cell.updateTask(task)

        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let task = TaskController.sharedController.incompleteTask[indexPath.row]
            TaskController.sharedController.removeTask(task)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
        }    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue" {
            let destinationViewController = segue.destinationViewController as? TaskDetailTableViewController
            if let taskDetailViewController = destinationViewController {
                _ = taskDetailViewController.view
                if let selectedRow = tableView.indexPathForSelectedRow?.row {
                    taskDetailViewController.updateWithTask(TaskController.sharedController.incompleteTask[selectedRow])
                }
            }
        }
        
    }
}

extension TaskTableViewController: ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        
        let indexPath = tableView.indexPathForCell(sender)!
        
        let task = TaskController.sharedController.incompleteTask[indexPath.row]
        task.isComplete = !task.isComplete.boolValue
        TaskController.sharedController.saveToPersistentStore()
        
        tableView.reloadData()
    }
}
