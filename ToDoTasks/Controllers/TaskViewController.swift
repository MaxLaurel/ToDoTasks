


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
    
    let DataBaseRef = Database.database().reference()
    let currentUser = Auth.auth().currentUser?.uid
    var tableViewTasks: [Task] = []
    
    private lazy var taskTableView: UITableView = {
        var tableView = UITableView()
        tableView.frame = view.bounds
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
        let alertController = UIAlertController(title: "AddTask", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "add", style: .default) { action in
            self.addTaskToDatabase()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
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
        
        let taskReference = DataBaseRef.child("users").child(currentUser).child("tasks").childByAutoId()
        
        let task = Task(taskName: nameTaskTextfield, description: descriptionTaskTextField, taskID: taskReference.key)
        
        taskReference.setValue(["title": task.taskName, "description": task.description, "taskID": task.taskID])
        
        alertController.textFields?.forEach({ textField in
            textField.text = ""
        })
    }
    func taskObserver() {
        self.tableViewTasks.removeAll()
        let taskReference = DataBaseRef.child("users").child(currentUser!).child("tasks")
        taskReference.observe(DataEventType.value) { snapshot in
            for child in snapshot.children {
                guard let childSnapshot = child as? DataSnapshot,
                      let dictValue = childSnapshot.value as? [String: Any],
                      let title = dictValue["title"] as? String,
                      let description = dictValue["description"] as? String,
                      let taskID = dictValue["taskID"] as? String else {return}
                
                let task = Task(taskName: title, description: description, taskID: taskID)
                
                if !self.tableViewTasks.contains(where: { $0.taskID == taskID }) {
                    self.tableViewTasks.append(task)
                }
                
                self.taskTableView.reloadData()
            }
            
            
        }
    }
}
extension TaskViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tableViewTasks[indexPath.row].taskName
        cell.textLabel?.text = task
        return cell
    }
}
