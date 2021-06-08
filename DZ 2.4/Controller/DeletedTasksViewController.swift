
import UIKit

class DeletedTasksViewController: UIViewController {
    var tasksArray = PersistanceRealm.shared.getItems().filter({
        $0.statusTask != "Активна"
    })

    @IBOutlet weak var recentlyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recentlyTableView.reloadData()
    }

}

// MARK: Extension
extension DeletedTasksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeletedCell") as! DeletedTableViewCell
        let deletedTask = tasksArray[indexPath.row]
        cell.initCell(item: deletedTask)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tasksArray[indexPath.row]
        showAlert(task: item, index: indexPath)
    }
    
// MARK: Alert
    func showAlert(task: Task, index: IndexPath){
        let ac = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        
        let restoreTask = UIAlertAction(title: "Восстановить задачу", style: .default) { (action) in
            PersistanceRealm.shared.changeTask2(item: task)
            self.recentlyTableView.deleteRows(at: [index], with: .fade)
            print(task.statusTask)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        ac.addAction(restoreTask)
        
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}
