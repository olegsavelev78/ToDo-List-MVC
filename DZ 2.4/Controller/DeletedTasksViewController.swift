
import UIKit

class DeletedTasksViewController: UIViewController {
    var tasksArray = PersistanceRealm.shared.getItems()

    @IBOutlet weak var recentlyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for item in tasksArray.filter("statusTask == Удалена") {
//            print(item)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recentlyTableView.reloadData()
    }

}

extension DeletedTasksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeletedCell") as! DeletedTableViewCell
        
        return cell
    }
    
    
}
