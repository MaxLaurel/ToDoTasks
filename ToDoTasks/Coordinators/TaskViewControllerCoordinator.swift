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
    //var viewControllerFactory = ViewControllerFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startInitialFlow()  {
        let taskViewController = TaskViewController()
        navigationController.pushViewController(taskViewController, animated: true)

    }
}
