//
//  AlertPresenter.swift
//  ToDoTasks
//
//  Created by Максим on 06.10.2024.
//

import UIKit

protocol AlertPresentable {
    var viewController: UIViewController { get }
    func showAlert(_ title: String, message: String)
}

 class addTaskAlertStrategy: AlertPresenter {
    var viewController: UIViewController
     
     init(viewController: UIViewController) {
         self.viewController = viewController
     }
     
    func showAlert(_ title: String, message: String) {
        var taskAlertController = UIAlertController(title: "Task", message: nil, preferredStyle: .alert)
        taskAlertController.addTextField { textfield in
            textfield.placeholder = "add name of your task"
        }
        taskAlertController.addTextField { textfield in
            textfield.placeholder = "describe your task"
        }
        let okAction = UIAlertAction(title: "add", style: .default) { action in
          //  self.addTaskToDatabase()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        taskAlertController.addAction(okAction)
        taskAlertController.addAction(cancelAction)
    }
}

class AlertNetworkErrorStrategy: AlertPresenter {
    var viewController: UIViewController
     
     init(viewController: UIViewController) {
         self.viewController = viewController
     }
    func showAlert(_ title: String = "Network Error", message: String = "An unexpected network error occurred. Please try again") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        viewController.present(alert, animated: true)
}
}
class AlertPresenter {
    var strategy: AlertPresenter?
    func setStrategy(strategy: AlertPresenter) {
        self.strategy = strategy
    }
    func showAlert(title: String, message: String) {
        strategy?.showAlert(title, message: message)
    }
}
