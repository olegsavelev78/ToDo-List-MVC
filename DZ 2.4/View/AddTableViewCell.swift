

import UIKit

class AddTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headName: UILabel!
    @IBOutlet weak var taskTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    func initCell(item: Task) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy  HH:mm"
       
        let formatteddate = formatter.string(from: item.dataTask! as Date)
        
        let formattedDLDate = formatter.string(from: item.deadline!)
        
        headName.text = item.headName
        taskTextLabel.text = item.textTask
        deadlineLabel.text = formattedDLDate
        dateLabel.text = formatteddate
    }
    
}
