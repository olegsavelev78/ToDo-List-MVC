import UIKit

class TasksViewController: UIViewController {
    
    var tasksArray = PersistanceRealm.shared.getItems().filter({
        $0.statusTask == "Активна"
    })
    
    @IBOutlet weak var addTableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    
//MARK: IBAction
    @IBAction func addTaskButton(_ sender: Any) {
        let vcAdd = storyboard?.instantiateViewController(identifier: "AddTask") as? AddTaskViewController
        present(vcAdd!, animated: true, completion: nil)
    }
    @IBAction func deleteTasksButton(_ sender: Any) {
        performSegue(withIdentifier: "DeleteTasks", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        addTableView.reloadData()
    }
    
    func updateView(){
        addTaskButton.setTitle("Новая задача", for: .normal)
    }
    
}

//MARK: Extensions
extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCell") as! AddTableViewCell
        let item = tasksArray[indexPath.row]
        cell.initCell(item: item)
        return cell
    }
    
    // Обработка нажатий на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tasksArray[indexPath.row]
        showAlert(task: item, index: indexPath)
    }
    
    // MARK: Alert
        func showAlert(task: Task, index: IndexPath){
            let ac = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
            let cancelTask = UIAlertAction(title: "Закрыть задачу", style: .default) { (action) in
                PersistanceRealm.shared.changeTask(item: task)
                self.addTableView.deleteRows(at: [index], with: .fade)
                print(task.statusTask)
            }
            let deletedTask = UIAlertAction(title: "Удалить задачу", style: .default) { (action) in
                PersistanceRealm.shared.deletedTask(item: task)
                self.addTableView.deleteRows(at: [index], with: .fade)
                print(task.statusTask)
            }
        
            let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            ac.addAction(cancelTask)
            ac.addAction(deletedTask)
            ac.addAction(cancel)
            present(ac, animated: true, completion: nil)
        }

}
