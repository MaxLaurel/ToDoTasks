//
//  TabBarControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 17.03.2024.
//

import Foundation
import UIKit

class TabBarControllerCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    
    var moduleFactory = ModuleFactory()
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        var taskTabBarController = TabBarController()
        taskTabBarController = moduleFactory.createTabBarController()
        taskTabBarController.taskTabBarControllerCoordinator = self
        navigationController.pushViewController(taskTabBarController, animated: true)
    }
    
//     func startTaskViewController() {
//        let taskViewControllerCoordinator = TaskViewControllerCoordinator(navigationController: navigationController)
//         add(coordinator: taskViewControllerCoordinator)
//         taskViewControllerCoordinator.start()
//    }
//    
//    func startCalculateViewController() {
//        let calculateControllerCoordinator = TabBarControllerCoordinator(navigationController: navigationController)
//        add(coordinator: calculateControllerCoordinator)
//        calculateControllerCoordinator.start()
//    }
}
