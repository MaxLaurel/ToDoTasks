


//
//  TaskViewController.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
<<<<<<< HEAD
    
    let dataBaseRef = Database.database().reference()
    let currentUser = Auth.auth().currentUser?.uid
    var arrayOfTasks: [Task] = []
    var selectedIndexPath: IndexPath?
=======
    private let dataBaseRef = Database.database().reference()
    private let currentUser = Auth.auth().currentUser?.uid
    private var arrayOfTasks: [TaskModel] = []
    private var selectedIndexPath: IndexPath?
>>>>>>> tik_2-NetworkSession
    weak var taskViewControllerCoordinator: TaskViewControllerCoordinator?
    
    private lazy var taskTableView: UITableView = {
        var tableView = UITableView()
        tableView.frame = view.bounds
        tableView.separatorStyle = .singleLine
<<<<<<< HEAD
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    lazy var taskAlertController: UIAlertController = {
        var taskAlertController = UIAlertController(title: "Task", message: nil, preferredStyle: .alert)
        taskAlertController.addTextField { textfield in
            textfield.placeholder = "add name of your task"
        }
        taskAlertController.addTextField { textfield in
            textfield.placeholder = "describe your task"
        }
        let okAction = UIAlertAction(title: "add", style: .default) { action in
            self.addTaskToDatabase()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        taskAlertController.addAction(okAction)
        taskAlertController.addAction(cancelAction)
        
        return taskAlertController
    }()
    
=======
        return tableView
    }()
    
>>>>>>> tik_2-NetworkSession
    lazy var leftBarButtonItem: UIBarButtonItem = {
        var leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        return leftBarButtonItem
    }()
    
    lazy var accountBarButtonItem: UIBarButtonItem = {
        var accountBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: #selector(accountBarButtonItemTapped))
        return accountBarButtonItem
    }()
    
<<<<<<< HEAD
    lazy var rightBarButtonItem: UIBarButtonItem = {
        var rightBarButtonItem = UIBarButtonItem(title: "AddTask", style: .plain, target: self, action: #selector(rightBurButtonItemTapped))
=======
    lazy var addTaskButtonItem: UIBarButtonItem = {
        var rightBarButtonItem = UIBarButtonItem(title: "AddTask", style: .plain, target: self, action: #selector(addTaskAction))
>>>>>>> tik_2-NetworkSession
        return rightBarButtonItem
    }()
    
    lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        var longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        return longPressGestureRecognizer
    }()
    
<<<<<<< HEAD
    //    lazy var recalculateViewController: PopoverRcalculateViewController = {
    //        var recalculateViewController = PopoverRcalculateViewController()
    //        recalculateViewController.modalPresentationStyle = .popover
    //        let popoverViewController = recalculateViewController.popoverPresentationController
    //        guard let popoverViewController = popoverViewController else {return recalculateViewController}
    //
    //        popoverViewController.sourceView = taskTableView
    //        popoverViewController.sourceRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 50)
    //        popoverViewController.permittedArrowDirections = []
    //        popoverViewController.backgroundColor = .white
    //        popoverViewController.delegate = self
    //
    //
    //        return recalculateViewController
    //    }()
=======
>>>>>>> tik_2-NetworkSession
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        view.addSubview(taskTableView)
        
        navigationItem.setLeftBarButtonItems([leftBarButtonItem, accountBarButtonItem], animated: true)
<<<<<<< HEAD
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.tintColor = .systemGreen
        
        
        
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
        //let loginVC = LoginViewController()
        navigationController?.popToRootViewController(animated: true)
=======
        navigationItem.rightBarButtonItem = addTaskButtonItem
        navigationController?.navigationBar.tintColor = .systemGreen
        
        taskTableView.addGestureRecognizer(longPressGestureRecognizer)
        taskObserver()
        
        taskTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @objc func leftBarButtonItemTapped() {
        do {
            try Auth.auth().signOut()
            navigationController?.setViewControllers([], animated: false)
            navigateToLoginViewController() // Переход на стартовый экран
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    private func navigateToLoginViewController() {
        // Убедитесь, что у вас есть доступ к SceneDelegate
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let appcoordinator2 = sceneDelegate.appCoordinator {
            sceneDelegate.window?.rootViewController = appcoordinator2.navigationController
            sceneDelegate.window?.makeKeyAndVisible()
            appcoordinator2.startInitialFlow()
            
            //            let navigationController = UINavigationController()
            //            let appCoordinator = AppCoordinator(navigationController: navigationController, window:        sceneDelegate.window!)
            //            sceneDelegate.window?.rootViewController = appCoordinator.navigationController
            //            sceneDelegate.window?.makeKeyAndVisible()
            //            appCoordinator.startLoginFlow()
        }
>>>>>>> tik_2-NetworkSession
    }
    
    @objc func accountBarButtonItemTapped() {
        let accountViewController = UIViewController()
        accountViewController.view.backgroundColor = .white
        present(accountViewController, animated: true)
<<<<<<< HEAD
        present(taskAlertController, animated: true, completion: nil)
    }
    
    @objc func rightBurButtonItemTapped() {
        present(taskAlertController, animated: true, completion: nil)
    }
    
    func addTaskToDatabase() {
        guard let nameTaskTextfield = taskAlertController.textFields?[0].text, let descriptionTaskTextField = taskAlertController.textFields?[1].text, nameTaskTextfield != "", descriptionTaskTextField != "", let currentUser = currentUser else {return}
        
        let taskReference = dataBaseRef.child("users").child(currentUser).child("tasks").childByAutoId()
        
        let task = Task(taskName: nameTaskTextfield, description: descriptionTaskTextField, taskID: taskReference.key)
        
        taskReference.setValue(["title": task.taskName, "description": task.description, "taskID": task.taskID, "isCompleted": task.isCompleted])
        
        taskAlertController.textFields?.forEach({ textField in
            textField.text = ""
        })
=======
    }
    
        @objc func addTaskAction() {
        
        let taskAlertController = UIAlertController(title: "Task", message: nil, preferredStyle: .alert)
        taskAlertController.addTextField { nameTextfield in
            nameTextfield.placeholder = "add name of your task"
        }
        taskAlertController.addTextField { taskTextfield in
            taskTextfield.placeholder = "describe your task"
        }
        let okAction = UIAlertAction(title: "add", style: .default) { action in
            guard let nameTextfield = taskAlertController.textFields?[0], let taskTextfield = taskAlertController.textFields?[1] else {return}
            guard let name = nameTextfield.text, let task = taskTextfield.text, !name.isEmpty, !task.isEmpty else {return}
            
            self.addTaskToDatabase(nameTaskTextfield: name, descriptionTaskTextField: task)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        taskAlertController.addAction(okAction)
        taskAlertController.addAction(cancelAction)
        self.present(taskAlertController, animated: true)
        
    }
    
    func addTaskToDatabase(nameTaskTextfield: String, descriptionTaskTextField: String) {
        guard nameTaskTextfield != "", descriptionTaskTextField != "" else {return}
        guard let currentUser = currentUser else {return}
        
        let taskReference = dataBaseRef.child("users").child(currentUser).child("tasks").childByAutoId()
        
        let task = TaskModel(taskName: nameTaskTextfield, description: descriptionTaskTextField, taskID: taskReference.key ?? "")
        
        taskReference.setValue(["title": task.taskName, "description": task.description, "taskID": task.taskID, "isCompleted": task.isCompleted])
        
        //        alertPresenterData.textFields?.forEach({ textField in
        //            textField.text = ""
        //        })
>>>>>>> tik_2-NetworkSession
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
                
<<<<<<< HEAD
                let task = Task(taskName: title, description: description, taskID: taskID)
=======
                let task = TaskModel(taskName: title, description: description, taskID: taskID)
>>>>>>> tik_2-NetworkSession
                
                if !arrayOfTasks.contains(where: { $0.taskID == taskID }) {
                    arrayOfTasks.append(task)
                }
<<<<<<< HEAD
                
                taskTableView.reloadData()
            }
        }
    }
    
}
=======
            }
            taskTableView.reloadData()
        }
    }
    deinit {
        //taskTableView.removeGestureRecognizer(longPressGestureRecognizer)
        dataBaseRef.removeAllObservers()
        print("TaskViewController deinitialized")
    }
}
    
>>>>>>> tik_2-NetworkSession
extension TaskViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
<<<<<<< HEAD
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let task = arrayOfTasks[indexPath.row]
        //cell.task = task // Устанавливаем значение task для ячейки
        cell.taskTitleLabel.text = task.taskName
        cell.descriptionTaskLabel.text = task.description
        toggleCompletion(cell: cell, isCompleted: task.isCompleted)
        cell.addGestureRecognizer(longPressGestureRecognizer)
        cell.configureConstraints()
=======
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskTableViewCell
        let task = arrayOfTasks[indexPath.row]
        //cell.task = task // Устанавливаем значение task для ячейки
        //cell.taskTitleLabel.text = task.taskName
        // cell.descriptionTaskLabel.text = task.description
        toggleCompletion(cell: cell, isCompleted: task.isCompleted)
        cell.configureCell(task: task)
        //cell.configureConstraints()
>>>>>>> tik_2-NetworkSession
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
    
    //MARK: метод снизуне понятно длячего нужно разобраться
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    //MARK: конфигурация и экшены для свайпа справа
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completion) in
            
            //let task = self?.arrayOfTasks[indexPath.row]
<<<<<<< HEAD
            self?.taskTableView.setEditing(true, animated: true)
=======
           // self?.taskTableView.setEditing(true, animated: true)
>>>>>>> tik_2-NetworkSession
            
            //            guard let cell = self?.taskTableView.cellForRow(at: indexPath) as? CustomTableViewCell else {return}
            
            let editAlertController = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
            
            let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] action in
                guard let titleTextfield = editAlertController.textFields?[0].text,
                      let descriptionTextfield = editAlertController.textFields?[1].text else {return}
                
                self?.selectedIndexPath = indexPath
                self?.updateValue(indexPath: indexPath, title: titleTextfield, description: descriptionTextfield)
            }
            
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            
            editAlertController.addTextField { textfield in
                textfield.placeholder = "edit name of your task"
            }
            editAlertController.addTextField { textfield in
                textfield.placeholder = "edit description of your task"
            }
            editAlertController.addAction(editAction)
            editAlertController.addAction(cancelAction)
            
            self?.present(editAlertController, animated: true, completion: nil)
        }
        
<<<<<<< HEAD
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { action, view, completion in
            let IndexTaskToRemove = self.arrayOfTasks[indexPath.row]
            guard let currentUser = self.currentUser, let taskID = IndexTaskToRemove.taskID else { return }
            let taskReference = self.dataBaseRef.child("users").child(currentUser).child("tasks").child(taskID)
=======
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] action, view, completion in
            guard let IndexTaskToRemove = self?.arrayOfTasks[indexPath.row] else {return}
            guard let currentUser = self?.currentUser else { return }
            guard let taskID = IndexTaskToRemove.taskID else { return }
            guard let taskReference = self?.dataBaseRef.child("users").child(currentUser).child("tasks").child(taskID) else {return}
>>>>>>> tik_2-NetworkSession
            
            taskReference.removeValue { error, reference in
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
<<<<<<< HEAD
                    self.arrayOfTasks.remove(at: indexPath.row)
=======
                    self?.arrayOfTasks.remove(at: indexPath.row)
>>>>>>> tik_2-NetworkSession
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
        deleteAction.image = UIImage(systemName: "trash.slash")
        editAction.image = UIImage(systemName: "square.and.pencil")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
<<<<<<< HEAD
    
=======
>>>>>>> tik_2-NetworkSession
    //MARK: метод редактирует задачу в базе данных Firebase при нажатии на кнопку "edit"
    func updateValue(indexPath: IndexPath, title: String, description: String) {
        //guard indexPath == selectedIndexPath else { return }
        guard indexPath.row < arrayOfTasks.count else {
            print("Index out of range")
            return
        }
        let task = arrayOfTasks[indexPath.row]
        
        guard let currentUser = currentUser, let task = task.taskID else {return}
        let reference = dataBaseRef.child("users").child(currentUser).child("tasks").child(task)
        
        reference.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else {return}
            reference.updateChildValues(["title": title, "description": description])
            self.arrayOfTasks[indexPath.row].taskName = title
            self.arrayOfTasks[indexPath.row].description = description
            // self.taskTableView.reloadData()
            self.taskTableView.reloadRows(at: [indexPath], with: .automatic)
            
            //            UIView.transition(with: self.taskTableView,
            //                              duration: 0.4,
            //                              options: .transitionCrossDissolve,
            //                              animations: {self.taskTableView.reloadRows(at: [indexPath], with: .none)}, completion: nil)
        }
    }
    
<<<<<<< HEAD
    
    //MARK: эти методы уже не актуальны так как разработали кастомные экшены для свайпов
    //    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    //        return .delete
    //    }
    //
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //
    //        if editingStyle == .delete {
    //            let IndexTaskToRemove = arrayOfTasks[indexPath.row]
    //            guard let currentUser = currentUser, let taskID = IndexTaskToRemove.taskID else { return }
    //            let taskReference = dataBaseRef.child("users").child(currentUser).child("tasks").child(taskID)
    //
    //            taskReference.removeValue { error, reference in
    //                if error != nil {
    //                    print(error?.localizedDescription)
    //                } else {
    //                    self.arrayOfTasks.remove(at: indexPath.row)
    //                    tableView.deleteRows(at: [indexPath], with: .fade)
    //                }
    //            }
    //        }
=======
>>>>>>> tik_2-NetworkSession
    //MARK: по тапу на ячейку ставится/снимается галочка указывающая на выполнение задачи
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = arrayOfTasks[indexPath.row]
        //let isCompleted = !task.isCompleted
        
        guard let currentUser = currentUser, let taskId = task.taskID else { return }
        
        let reference = dataBaseRef.child("users").child(currentUser).child("tasks").child(taskId)
        
<<<<<<< HEAD
        reference.observeSingleEvent(of: .value) { snapshot in
=======
        reference.observeSingleEvent(of: .value) { [weak self] snapshot in
>>>>>>> tik_2-NetworkSession
            guard let taskDict = snapshot.value as? [String: Any],
                  let isCompletedValue = taskDict["isCompleted"] as? Bool else { return }
            let revertIsCompleted = !isCompletedValue
            
            reference.updateChildValues(["isCompleted": revertIsCompleted]) { (error, _) in
                if let error = error {
                    print("Error updating isCompleted: \(error.localizedDescription)")
                    return
                }
<<<<<<< HEAD
                self.arrayOfTasks[indexPath.row].isCompleted = revertIsCompleted
=======
                self?.arrayOfTasks[indexPath.row].isCompleted = revertIsCompleted
>>>>>>> tik_2-NetworkSession
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
<<<<<<< HEAD
    func toggleCompletion(cell: CustomTableViewCell, isCompleted: Bool) {
=======
    func toggleCompletion(cell: TaskTableViewCell, isCompleted: Bool) {
>>>>>>> tik_2-NetworkSession
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
    
    //MARK: реализация долгого нажатия на ячейку
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            
            let touchPoint = sender.location(in: taskTableView)
            guard let indexPath = taskTableView.indexPathForRow(at: touchPoint),
                  let cell = taskTableView.cellForRow(at: indexPath) else { return }
            
            if cell.frame.contains(touchPoint) {
                selectedIndexPath = indexPath  //кладем indexPath во внешний скоуп чтобы из него потом вытащить для updateValue - метода который не имеет индекспаф но требует его
                requestContextMenu(indexPath: selectedIndexPath!) //вызываем контекстное меню при долгом нажатии на ячейку
            }
        }
    }
    
    //        func setupPopover(for indexPath: IndexPath) {
    //            let popOver = PopoverViewController()
    //            popOver.modalPresentationStyle = .popover
    //            popOver.preferredContentSize = CGSize(width: 250, height: 150)
    //
    //            guard let popOverVC = popOver.popoverPresentationController, let cell = taskTableView.cellForRow(at: indexPath) else {return}
    //
    //            popOverVC.sourceView = cell
    //            popOverVC.permittedArrowDirections = []
    //            let screenWidth = UIScreen.main.bounds.width
    //            let sourceRectX = screenWidth - 50
    //            popOverVC.sourceRect = CGRect(x: sourceRectX, y: 100, width: 0, height: 0)
    //            popOverVC.delegate = popOver
    //
    //            present(popOver, animated: true, completion: nil)
    //        }
    
    func setupRecalculateViewControllerPopover() {
        let popOver = PopoverRcalculateViewController()
        popOver.modalPresentationStyle = .popover
        let popoverViewController = popOver.popoverPresentationController
        guard let popoverViewController = popoverViewController else {return }
        
        popoverViewController.sourceView = taskTableView
        popoverViewController.sourceRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        popoverViewController.permittedArrowDirections = []
        popoverViewController.delegate = popOver
        popoverViewController.backgroundColor = .clear
<<<<<<< HEAD
//        
//        let blurEffect = UIBlurEffect(style: .dark)
//
//        let blurEffectView = UIVisualEffectView()
//        self.view.addSubview(blurEffectView)
//        
//        blurEffectView.effect = blurEffect
=======
        //
        //        let blurEffect = UIBlurEffect(style: .dark)
        //
        //        let blurEffectView = UIVisualEffectView()
        //        self.view.addSubview(blurEffectView)
        //
        //        blurEffectView.effect = blurEffect
>>>>>>> tik_2-NetworkSession
        //            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        //            blurEffectView.topAnchor.constraint(equalTo: self.taskTableView.topAnchor).isActive = true
        //            blurEffectView.bottomAnchor.constraint(equalTo: self.taskTableView.bottomAnchor).isActive = true
        //            blurEffectView.trailingAnchor.constraint(equalTo: self.taskTableView.trailingAnchor).isActive = true
        //            blurEffectView.leadingAnchor.constraint(equalTo:  self.taskTableView.leadingAnchor).isActive = true
<<<<<<< HEAD
//        blurEffectView.frame = self.view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
=======
        //        blurEffectView.frame = self.view.bounds
        //        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //
>>>>>>> tik_2-NetworkSession
        present(popOver, animated: true)
    }
    
    func requestContextMenu(indexPath: IndexPath) {
        let contextMenu = UIContextMenuInteraction(delegate: self)
        
        guard let cell = taskTableView.cellForRow(at: selectedIndexPath! ) else {return}
        cell.addInteraction(contextMenu)
        
        
    }
<<<<<<< HEAD
=======
    
>>>>>>> tik_2-NetworkSession
}
extension TaskViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        //guard let indexPath = self.taskTableView.indexPathForRow(at: location)  else { return nil }
        
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let likeAction = UIAction(title: "Like", image: UIImage(systemName: "hand.thumbsup")) { _ in
                print("like")
            }
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.slash"), attributes: .destructive) { _ in
                print("delete")
            }
            
            let recalculateAction = UIAction(title: "recalculate", image: UIImage(systemName: "plus.forwardslash.minus")) { _ in
                
                self.setupRecalculateViewControllerPopover()
            }
            
            let compensateAction = UIAction(title: "Compensate", image: UIImage(systemName: "tree.circle")) { _ in
                print("compensated")
            }
            
            let menuForCompensate = UIMenu(title: "ways to compensate", options: .displayInline, children: [compensateAction])
            
            return UIMenu.init(title: "ContextMenu", children: [menuForCompensate, likeAction, recalculateAction, deleteAction ])
        }
        return configuration
    }
}


