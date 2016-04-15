//
//  TaskDetailTableViewController.swift
//  iOSTaskChallenge
//
//  Created by admin on 4/15/16.
//  Copyright © 2016 Brock. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameEntryTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesEntryTextView: UITextView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var dueDate: NSDate?
    
    var task: Task?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dueTextField.inputView = dueDatePicker

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func dueDatePickerChanged(sender: AnyObject) {
        
        self.dueTextField.text = sender.date.stringValue()
        self.dueDate = sender.date
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        updateTask()
        navigationController?.popViewControllerAnimated(true)
    }
    
    func updateTask() {
        let name = nameEntryTextField.text!
        let due = dueDate
        let notes = notesEntryTextView.text
        
        if let task = self.task {
            task.name = name
            task.due = due
            task.notes = notes
        } else {
            let newTask = Task(name: name)
            TaskController.sharedController.addTask(newTask)
        }
    }
    
    func updateWithTask(task: Task) {
        self.task = task
        title = task.name
        nameEntryTextField.text = task.name
        if let due = task.due {
            dueTextField.text = due.stringValue()
        }
        if let notes = task.notes {
            notesEntryTextView.text = notes
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


}
