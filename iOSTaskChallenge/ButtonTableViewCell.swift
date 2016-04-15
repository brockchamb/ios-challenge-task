//
//  ButtonTableViewCell.swift
//  iOSTaskChallenge
//
//  Created by admin on 4/15/16.
//  Copyright © 2016 Brock. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskButton: UIButton!
    
    var delegate: ButtonTableViewCellDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func taskButtonTapped(sender: AnyObject) {
        updateButton(true)
    }
    
    func updateButton(isComplete: Bool) {
        if isComplete {
            taskButton.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            taskButton.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }
}

protocol ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell)
    
}

extension ButtonTableViewCell {
    func updateTask(task: Task) {
        taskLabel.text = task.name
        updateButton(task.isComplete.boolValue)
    }
}
