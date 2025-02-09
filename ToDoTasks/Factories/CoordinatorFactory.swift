//
//  CoordinatorFactory.swift
//  ToDoTasks
//
//  Created by Максим on 29.03.2024.
//

import UIKit

class CoordinatorFactory {

    func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        AppCoordinator(navigationController: navigationController)
    }
    
    func createLoginCoordinator(navigationController: UINavigationController) -> LoginViewControllerCoordinator {
        LoginViewControllerCoordinator(navigationController: navigationController)
    }
    
    func createTabBarControllerCoordinator(navigationController: UINavigationController) -> TabBarControllerCoordinator {
        TabBarControllerCoordinator(navigationController: navigationController)
    }
    
    func createTaskCoordinator(navigationController: UINavigationController) -> TaskViewControllerCoordinator {
        TaskViewControllerCoordinator(navigationController: navigationController)
    }
    
    func createCalculateCoordinator(navigationController: UINavigationController) -> CalculateControllerCoordinator {
        CalculateControllerCoordinator(navigationController: navigationController)
    }
    
    func createNewsCoordinator(navigationController: UINavigationController) -> NewsControllerCoordinator {
        NewsControllerCoordinator(navigationController: navigationController)
    }
}
