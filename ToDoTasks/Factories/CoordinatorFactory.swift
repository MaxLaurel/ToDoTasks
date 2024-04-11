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
    
    func createTabBarControllerCoordinator(navigationController: UIViewController) -> TabBarControllerCoordinator {
        TabBarControllerCoordinator(navigationController: navigationController as! UINavigationController )
    }
    
    func createCalculateCoordinator(navigationController: UINavigationController) -> CalculateControllerCoordinator {
        CalculateControllerCoordinator(navigationController: navigationController)
    }
}
