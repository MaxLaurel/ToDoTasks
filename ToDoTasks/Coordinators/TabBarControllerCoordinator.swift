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
    
    func startInitialFlow() {
        let tabBarController = viewControllerFactory.instantiate(type: .tabBarVC)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
