//
//  CalculateControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 24.03.2024.
//

import UIKit

final class CalculateViewControllerCoordinator: Coordinating {
    
   // var coordinators: [Coordinator] = []
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let calculationViewController = CalculationViewController()
        navigationController.pushViewController(calculationViewController, animated: true)
    }
}
