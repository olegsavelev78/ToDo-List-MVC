
import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var headNameTask: UITextField!
    @IBOutlet weak var taskTextview: UITextView!
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var saveTaskButton: UIButton!
    
    @IBAction func saveTaskButton(_ sender: Any) {
        if headNameTask.text != "" && taskTextview.text != "" {
            let date = NSDate()
            
            let task = Tasks(headName: headNameTask.text ?? "", textTask: taskTextview.text, dataTask: date as Date, deadline: dataPicker.date, statusTask: "Создана")
            
            let item = Task()
            
            item.headName = task.headName
            item.textTask = task.textTask
            item.dataTask = task.dataTask
            item.deadline = task.deadline
            item.statusTask = task.statusTask
            
            PersistanceRealm.shared.addTask(item: item)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        headNameTask.placeholder = "Введите заголовок"
        
        taskTextview.layer.cornerRadius = 5
        taskTextview.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        taskTextview.layer.borderWidth = 1
        taskTextview.delegate = self
        taskTextview.text = "Введите описание"
        taskTextview.textColor = UIColor.lightGray
        
        saveTaskButton.setTitle("Сохранить", for: .normal)
        saveTaskButton.layer.cornerRadius = 10
        
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.layer.cornerRadius = 10
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskTextview.text == "Введите описание" && taskTextview.textColor == UIColor.lightGray {
            taskTextview.text = ""
            taskTextview.textColor = UIColor.darkGray
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if taskTextview.text.isEmpty {
            taskTextview.text = "Введите описание"
            taskTextview.textColor = UIColor.lightGray
        }
    }
}

