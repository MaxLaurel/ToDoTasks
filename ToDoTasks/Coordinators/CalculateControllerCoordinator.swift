//
//  CalculateControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 24.03.2024.
//

import UIKit

class CalculateControllerCoordinator: Coordinator {

    var moduleFactoru = ModuleFactory()
    var coordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        print("111")
    }
    
//    func startCalculateFlow() {
//        let flowCalculationController = moduleFactoru.createSecondFlowViewControllerOne()
//        //let calculateController = CalculationViewController()
//        flowCalculationController.calculateControllerCoordinator = self
//        navigationController.pushViewController(flowCalculationController, animated: true)
//    }
    
//    func startSecondFlow() {
//        let secondFlowController = SecondFlowViewControllerOne()
//        secondFlowController.calculateControllerCoordinator = self
//        navigationController.pushViewController(secondFlowController, animated: true)
//    }
}
