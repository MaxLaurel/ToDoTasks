//
//  TaskViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 24.03.2024.
//

import UIKit

class TaskViewControllerCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
<<<<<<< HEAD

    let navigationController: UINavigationController
    
=======
    let navigationController: UINavigationController
>>>>>>> tik_2-NetworkSession
    var viewControllerFactory = ViewControllerFactory()
        
        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
        
<<<<<<< HEAD
        func start() {
            let taskViewController = viewControllerFactory.createTaskViewController()
            taskViewController.taskViewControllerCoordinator = self
=======
        func startInitialFlow() {
            let taskViewController = viewControllerFactory.instantiate(type: .taskVC)
>>>>>>> tik_2-NetworkSession
            navigationController.pushViewController(taskViewController, animated: true)
    }
}
