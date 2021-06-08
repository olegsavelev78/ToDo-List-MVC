

import UIKit

class AddTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headName: UILabel!
    @IBOutlet weak var taskTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    func initCell(item: Task) {        
        headName.text = item.headName
        taskTextLabel.text = item.textTask
        deadlineLabel.text = item.dateTask
        dateLabel.text = item.deadline
    }
    
}
