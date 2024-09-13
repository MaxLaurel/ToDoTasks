//
//  CalculateControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 24.03.2024.
//

import UIKit

class CalculateControllerCoordinator: Coordinator {
    
    var viewControllerFactory = ViewControllerFactory()
    var coordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let calculationViewController = viewControllerFactory.createCalculateViewController()
        calculationViewController.calculateControllerCoordinator = self
        navigationController.pushViewController(calculationViewController, animated: true)
    }
}
