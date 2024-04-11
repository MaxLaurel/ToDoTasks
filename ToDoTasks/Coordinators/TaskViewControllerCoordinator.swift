//
//  TaskViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 24.03.2024.
//

import UIKit

class TaskViewControllerCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []

        let navigationController: UINavigationController
        
        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
        
        func start() {
            let taskViewController = TaskViewController()
            taskViewController.taskViewControllerCoordinator = self
            navigationController.pushViewController(taskViewController, animated: true)
    }
}
