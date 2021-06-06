//
//  DeletedTableViewCell.swift
//  DZ 2.4
//
//  Created by Олег Савельев on 01.05.2021.
//

import UIKit

class DeletedTableViewCell: UITableViewCell {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var taskDateLabel: UILabel!
    @IBOutlet weak var dlLabel: UILabel!
    
    func initCell(item: Task) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy  HH:mm"
       
        let formatteddate = formatter.string(from: item.dataTask! as Date)
        
        let formattedDLDate = formatter.string(from: item.deadline!)
        
        headLabel.text = item.headName
        taskTextView.text = item.textTask
        dlLabel.text = formattedDLDate
        taskDateLabel.text = formatteddate
    }
}
