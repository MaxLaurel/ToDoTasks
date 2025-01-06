//
//  TaskViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 24.03.2024.
//

import UIKit

final class TaskViewControllerCoordinator: Coordinating {
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start()  {
        let taskViewController = TaskViewController()
        navigationController.pushViewController(taskViewController, animated: true)
    }
    
}
