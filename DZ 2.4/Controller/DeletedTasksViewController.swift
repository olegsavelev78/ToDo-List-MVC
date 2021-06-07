
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
    
    func showAlert(task: Task){
        let ac = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        
        let restoreTask = UIAlertAction(title: "Восстановить задачу", style: .default) { (action) in
            task.statusTask = "Создана"
            print(task.statusTask)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        ac.addAction(restoreTask)
        
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tasksArray[indexPath.row]
        showAlert(task: item)
    }
    
    
}
