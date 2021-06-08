//
//  DeletedTableViewCell.swift
//  DZ 2.4
//
//  Created by Олег Савельев on 01.05.2021.
//

import UIKit

class DeletedTableViewCell: UITableViewCell {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var textTaskLabel: UILabel!
    @IBOutlet weak var taskDateLabel: UILabel!
    @IBOutlet weak var dlLabel: UILabel!
    
    func initCell(item: Task) {
        headLabel.text = item.headName
        textTaskLabel.text = item.textTask
        dlLabel.text = item.dateTask
        taskDateLabel.text = item.deadline
    }
}
