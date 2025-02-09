////
////  AlertPresenter.swift
////  ToDoTasks
////
////  Created by Максим on 06.10.2024.
////
//
//import UIKit
//
//protocol AlertStrategy {
//    var viewController: UIViewController { get }
//    func showAlert(title: String, message: String, completion: @escaping(String?, String?) -> Void?)
//}
//
//class AddTaskAlertStrategy: AlertStrategy {
//    var viewController: UIViewController
//    
//    init(viewController: UIViewController) {
//        self.viewController = viewController
//    }
//    
////    func showAlert(title: String = "Task", message: String = "", completion: @escaping(String?, String?) -> Void? ) {
////        var taskAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
////        taskAlertController.addTextField { nameTextfield in
////            nameTextfield.placeholder = "add name of your task"
////        }
////        taskAlertController.addTextField { taskTextfield in
////            taskTextfield.placeholder = "describe your task"
////        }
////        let okAction = UIAlertAction(title: "add", style: .default) { action in
////            guard let nameTextfield = taskAlertController.textFields?[0], let taskTextfield = taskAlertController.textFields?[1] else {return}
////            completion(nameTextfield.text, taskTextfield.text)
////        }
////        
////        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
////        taskAlertController.addAction(okAction)
////        taskAlertController.addAction(cancelAction)
////        viewController.present(taskAlertController, animated: true)
////    }
////}
//
//    class AlertNetworkErrorStrategy: AlertStrategy {
//        var viewController: UIViewController
//        
//        init(viewController: UIViewController) {
//            self.viewController = viewController
//        }
//        
//        //    func showAlert(title: String, message: String, completion: @escaping(String?, String?) -> Void?) {
//        //        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        //        let alertAction = UIAlertAction(title: "OK", style: .default)
//        //        alert.addAction(alertAction)
//        //        viewController.present(alert, animated: true)
//        //    }
//        //}
//        
//        class AlertStrategyPresenter {
//            var strategy: AlertStrategy?
//            
//            func showNetworkErrorAlert(viewController: UIViewController, title: String, message: String) {
//                strategy = AlertNetworkErrorStrategy(viewController: viewController)
//                strategy?.showAlert(title: title, message: message ) { _, _ in
//                }
//            }
//            
//            func showAddTaskAlert(viewController: UIViewController, title: String, message: String, completion: @escaping(String?, String?) -> Void) {
//                strategy = AddTaskAlertStrategy(viewController: viewController)
//                strategy?.showAlert(title: title, message: message, completion: completion)
//            }
//        }
//    }
