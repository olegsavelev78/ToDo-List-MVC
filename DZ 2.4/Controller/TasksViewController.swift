/*
 1. Нужен перенос удаленных и оконченных задач в другой массив
 2. Cделать алерт для удаления и окончания задач
 */


import UIKit

class TasksViewController: UIViewController {
    
    var tasksArray = PersistanceRealm.shared.getItems()
    
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
//        if item.statusTask == "Создана"{
            cell.initCell(item: item)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    // Действие с задачей
    func showAlert(task: Task, index: IndexPath){
        let ac = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        let cancelTask = UIAlertAction(title: "Закрыть задачу", style: .default) { (action) in
//            task.statusTask = "Окончена"
            print(task.statusTask)
        }
        let deletedTask = UIAlertAction(title: "Удалить задачу", style: .default) { (action) in
            PersistanceRealm.shared.remove(item: task)
            self.addTableView.deleteRows(at: [index], with: .automatic)
            self.addTableView.reloadData()
            print(task.statusTask)
        }
    
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        ac.addAction(cancelTask)
        ac.addAction(deletedTask)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    // Обработка нажатий на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tasksArray[indexPath.row]
        showAlert(task: item, index: indexPath)
    }
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let item = self.tasksArray[indexPath.row]
//        if editingStyle == .delete {
//            PersistanceRealm.shared.remove(item: item)
//            addTableView.deleteRows(at: [indexPath], with: .left)
//            addTableView.reloadData()
//        }
//    }
}
