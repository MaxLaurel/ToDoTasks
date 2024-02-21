


//
//  TaskViewController.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate{
    
    let dataBaseRef = Database.database().reference()
    let currentUser = Auth.auth().currentUser?.uid
    var arrayOfTasks: [Task] = []
    
    
    
    private lazy var taskTableView: UITableView = {
        var tableView = UITableView()
        tableView.frame = view.bounds
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AddTask", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightBurButtonItemTapped))
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        taskTableView.addGestureRecognizer(longPressGestureRecognizer)
        
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
        arrayOfTasks.removeAll()
        let taskReference = dataBaseRef.child("users").child(currentUser!).child("tasks")
        taskReference.observe(DataEventType.value) { [self] snapshot in
            for child in snapshot.children {
                guard let childSnapshot = child as? DataSnapshot,
                      let dictValue = childSnapshot.value as? [String: Any],
                      let title = dictValue["title"] as? String,
                      let description = dictValue["description"] as? String,
                      let taskID = dictValue["taskID"] as? String else {return}
                
                let task = Task(taskName: title, description: description, taskID: taskID)
                
                if !arrayOfTasks.contains(where: { $0.taskID == taskID }) {
                    arrayOfTasks.append(task)
                }
                
                taskTableView.reloadData()
            }
        }
    }
    
}
extension TaskViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let task = arrayOfTasks[indexPath.row]
        //cell.task = task // Устанавливаем значение task для ячейки
        cell.taskTitleLabel.text = task.taskName
        cell.descriptionTaskLabel.text = task.description
        toggleCompletion(cell: cell, isCompleted: task.isCompleted)
        cell.configureConstraints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
    
    //MARK: метод снизуне понятно длячего нужно разобраться
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Edit", handler: <#T##UIContextualAction.Handler#>)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let IndexTaskToRemove = arrayOfTasks[indexPath.row]
            guard let currentUser = currentUser, let taskID = IndexTaskToRemove.taskID else { return }
            let taskReference = dataBaseRef.child("users").child(currentUser).child("tasks").child(taskID)
            
            taskReference.removeValue { error, reference in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    self.arrayOfTasks.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                
            }
        }
    }
    //MARK: по тапу на ячейку ставится/снимается галочка указывающая на выполнение задачи
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = arrayOfTasks[indexPath.row]
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
                self.arrayOfTasks[indexPath.row].isCompleted = revertIsCompleted
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func toggleCompletion(cell: CustomTableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
    
    //MARK: реализация долгого нажатия на ячейку
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            print("Long press recognized")
            
            let touchPoint = sender.location(in: taskTableView)
            if let indexPath = taskTableView.indexPathForRow(at: touchPoint) {
                //setupPopover(for: indexPath) - здесь вызываем поповер при длительном нажатии на ячейку
                requestContextMenu(indexPath: indexPath) //вызываем контекстное меню при долгом нажатии на ячейку
            }
        }
    }
    func setupPopover(for indexPath: IndexPath) {
        let popOver = PopoverViewController()
        popOver.modalPresentationStyle = .popover
        popOver.preferredContentSize = CGSize(width: 250, height: 150)
        
        guard let popOverVC = popOver.popoverPresentationController, let cell = taskTableView.cellForRow(at: indexPath) else {return}
        
        popOverVC.sourceView = cell
        popOverVC.permittedArrowDirections = []
        let screenWidth = UIScreen.main.bounds.width
        let sourceRectX = screenWidth - 50
        popOverVC.sourceRect = CGRect(x: sourceRectX, y: 100, width: 0, height: 0)
        popOverVC.delegate = popOver
        
        present(popOver, animated: true, completion: nil)
    }
    
    func requestContextMenu(indexPath: IndexPath) {
        let contextMenu = UIContextMenuInteraction(delegate: self)
        
        guard let cell = taskTableView.cellForRow(at: indexPath ) else {return}
        cell.addInteraction(contextMenu)
        
        
    }
}
extension TaskViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let like = UIAction(title: "Like", image: UIImage(systemName: "hand.thumbsup")) { _ in
                print("like")
            }
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.slash"), attributes: .destructive) { _ in
                print("delete")
            }
            let recalculate = UIAction(title: "recalculate", image: UIImage(systemName: "plus.forwardslash.minus")) { _ in
                print("recalkulated")
            }
            
            let compensate = UIAction(title: "Compensate", image: UIImage(systemName: "tree.circle")) { _ in
                print("compensated")
            }
            let menuForCompensate = UIMenu(title: "ways to compensate", options: .displayInline, children: [compensate])
            
            return UIMenu.init(title: "ContextMenu", children: [menuForCompensate, like, recalculate, delete ])
        }
        return configuration
    }
}


