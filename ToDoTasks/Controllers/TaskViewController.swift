


//
//  TaskViewController.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let dataBaseRef = Database.database().reference()
    let currentUser = Auth.auth().currentUser?.uid
    var tableViewTasks: [Task] = []
    
    private lazy var taskTableView: UITableView = {
        var tableView = UITableView()
        tableView.frame = view.bounds
        tableView.separatorStyle = .singleLine
        //tableView.separatorColor = .gray
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
//        footerView.backgroundColor = .clear
//        tableView.tableFooterView = footerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var rightBurButtonItem: UIBarButtonItem = {
        var rightBurButtonItem = UIBarButtonItem(title: "AddTask",
                                                 style: UIBarButtonItem.Style.plain ,
                                                 target: self,
                                                 action: #selector(rightBurButtonItemTapped))
        return rightBurButtonItem
    }()
    
    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: "AddTask",
                                                message: nil,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "add",
                                     style: .default) { action in
            self.addTaskToDatabase()
        }
        let cancelAction = UIAlertAction(title: "cancel",
                                         style: .cancel,
                                         handler: nil)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "add name of your task"
        }
        alertController.addTextField { textfield in
            textfield.placeholder = "describe your task"
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        view.addSubview(taskTableView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(leftBarButtonItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AddTask",
                                                            style: UIBarButtonItem.Style.plain,
                                                            target: self,
                                                            action: #selector(rightBurButtonItemTapped))
        taskObserver()
        taskTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    @objc func leftBarButtonItemTapped() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
        //navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func rightBurButtonItemTapped() {
        present(alertController, animated: true, completion: nil)
    }
    
    func addTaskToDatabase() {
        guard let nameTaskTextfield = alertController.textFields?[0].text, let descriptionTaskTextField = alertController.textFields?[1].text, nameTaskTextfield != "", descriptionTaskTextField != "", let currentUser = currentUser else {return}
        
        let taskReference = dataBaseRef.child("users").child(currentUser).child("tasks").childByAutoId()
        
        let task = Task(taskName: nameTaskTextfield, description: descriptionTaskTextField, taskID: taskReference.key)
        
        taskReference.setValue(["title": task.taskName, "description": task.description, "taskID": task.taskID, "isCompleted": task.isCompleted])
        
        alertController.textFields?.forEach({ textField in
            textField.text = ""
        })
    }
    
    func taskObserver() {
        tableViewTasks.removeAll()
        let taskReference = dataBaseRef.child("users").child(currentUser!).child("tasks")
        taskReference.observe(DataEventType.value) { [self] snapshot in
            for child in snapshot.children {
                guard let childSnapshot = child as? DataSnapshot,
                      let dictValue = childSnapshot.value as? [String: Any],
                      let title = dictValue["title"] as? String,
                      let description = dictValue["description"] as? String,
                      let taskID = dictValue["taskID"] as? String else {return}
                
                let task = Task(taskName: title, description: description, taskID: taskID)
                
                if !tableViewTasks.contains(where: { $0.taskID == taskID }) {
                    tableViewTasks.append(task)
                }
                
                taskTableView.reloadData()
            }
        }
    }
   
}
extension TaskViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let task = tableViewTasks[indexPath.row]
        cell.taskTitleLabel.text = task.taskName
        cell.descriptionTaskLabel.text = task.description
        
//MARK: с этим клоужером ниже на удаление ячейки нужно разобраться
//        cell.deleteButtonClouser = { [weak self] in
//            guard let self = self else {return}
//            guard let indexPathForCell = tableView.indexPath(for: cell) else {return}
//            self.tableViewTasks.remove(at: indexPathForCell.row)
//            tableView.deleteRows(at: [indexPathForCell], with: .fade)
//            self.taskTableView.reloadData()
       // }
        toggleCompletion(cell: cell, isCompleted: task.isCompleted)
        
        cell.configureConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //нужно написать логику удаления объектов из файрбэйз
            //tableViewTasks.remove(at: indexPath.row)
            let task = tableViewTasks[indexPath.row]
            tableViewTasks.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tableViewTasks[indexPath.row]
        let isCompleted = !task.isCompleted

        guard let currentUser = currentUser, let taskId = task.taskID else { return }

        let reference = dataBaseRef.child("users").child(currentUser).child("tasks").child(taskId)

        reference.observeSingleEvent(of: .value) { snapshot in
            guard let taskDict = snapshot.value as? [String: Any],
                  let isCompletedValue = taskDict["isCompleted"] as? Bool else { return }
            let revertIsCompleted = !isCompletedValue
            reference.updateChildValues(["isCompleted": revertIsCompleted]) { (error, _) in
                if let error = error {
                    print("Error updating isCompleted: \(error.localizedDescription)")
                    return
                }
                // Update the model
                self.tableViewTasks[indexPath.row].isCompleted = revertIsCompleted
                // Reload only the selected row
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func toggleCompletion(cell: CustomTableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
    
}

