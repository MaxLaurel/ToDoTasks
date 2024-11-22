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
    
    
<<<<<<< HEAD
    func start() {
        let calculationViewController = viewControllerFactory.createCalculateViewController()
        calculationViewController.calculateControllerCoordinator = self
=======
    func startInitialFlow() {
        let calculationViewController = viewControllerFactory.instantiate(type: .calculateVC)
>>>>>>> tik_2-NetworkSession
        navigationController.pushViewController(calculationViewController, animated: true)
    }
}
