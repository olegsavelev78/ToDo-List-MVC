//
//  DataBase.swift
//  DZ 2.4
//
//  Created by Олег Савельев on 26.04.2021.
//

import RealmSwift

class Task: Object{
    @objc dynamic var headName = ""
    @objc dynamic var textTask = ""
    @objc dynamic var dateTask = ""
    @objc dynamic var deadline = ""
    @objc dynamic var statusTask = ""
    
    convenience init(item: Tasks){
        self.init()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy  HH:mm"
        let formatteddate = formatter.string(from: item.dateTask as Date)
        let formattedDLDate = formatter.string(from: item.deadline)
        self.headName = item.headName
        self.textTask = item.textTask
        self.dateTask = formatteddate
        self.deadline = formattedDLDate
        self.statusTask = item.statusTask
    }

}

class PersistanceRealm {
    static let shared = PersistanceRealm()
    
    let realm = try! Realm()
    
    func getItems() -> Results<Task>{
        realm.objects(Task.self)
    }

    func addTask(item: Task){
        try! realm.write {
            realm.add(item)
        }
    }
    
    func deletedTask(item: Task){
        try! realm.write {
            item.statusTask = "Удалена"
        }
    }
    
    func changeTask(item: Task){
        try! realm.write {
            item.statusTask = "Завершена"
        }
    }
    func changeTask2(item: Task){
        try! realm.write {
            item.statusTask = "Активна"
        }
    }
    
    func remove(item: Task) {
        try! realm.write {
            realm.delete(item)
        }
    }
}
