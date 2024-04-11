//
//  FlowCalculationCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 29.03.2024.
//

import UIKit

class FlowCalculationCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    let moduleFactory = ModuleFactory()
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startCalculationFlow()
    }
    
    func startCalculationFlow() {
        let secondFlowViewControllerOne = moduleFactory.createSecondFlowViewControllerOne()
        secondFlowViewControllerOne.calculateControllerCoordinator = self
        navigationController.pushViewController(secondFlowViewControllerOne, animated: true)
    }
    
    
}
