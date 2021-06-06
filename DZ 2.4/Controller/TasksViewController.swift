/*
 1. Нужен перенос удаленных и оконченных задач в другой массив
 2. Cделать алерт для удаления и окончания задач
 */


import UIKit

class TasksViewController: UIViewController {
    var tasksArray = PersistanceRealm.shared.getItems()
    
    @IBOutlet weak var addTableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBAction func addTaskButton(_ sender: Any) {
        let vcAdd = storyboard?.instantiateViewController(identifier: "AddTask") as? AddTaskViewController
        present(vcAdd!, animated: true, completion: nil)
    }
    @IBAction func deleteTasksButton(_ sender: Any) {
        performSegue(withIdentifier: "DeleteTasks", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskButton.setTitle("Новая задача", for: .normal)
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        addTableView.reloadData()
    }
    
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCell") as! AddTableViewCell
        
        let item = tasksArray[indexPath.row]
        if item.statusTask == "Создана"{
            cell.initCell(item: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.tasksArray[indexPath.row]
        if editingStyle == .delete {
            PersistanceRealm.shared.remove(item: item)
            addTableView.deleteRows(at: [indexPath], with: .left)
            addTableView.reloadData()
        }
    }
    
    
}
