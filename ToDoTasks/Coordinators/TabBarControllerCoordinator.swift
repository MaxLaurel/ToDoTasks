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
    
    var viewControllerFactory = ViewControllerFactory()
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = viewControllerFactory.createTabBarController()
        tabBarController.tabBarControllerCoordinator = self
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
