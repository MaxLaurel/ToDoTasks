<<<<<<< HEAD
//
//  FlowCalculationCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 29.03.2024.
//

import UIKit

class FlowCalculationCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    let viewControllerFactory = ViewControllerFactory()
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startCalculationFlow()
    }
    
    func startCalculationFlow() {
        let secondFlowViewControllerOne = viewControllerFactory.createSecondFlowViewControllerOne()
        secondFlowViewControllerOne.calculateControllerCoordinator = self
        navigationController.pushViewController(secondFlowViewControllerOne, animated: true)
    }
    
    
}
=======
////
////  FlowCalculationCoordinator.swift
////  ToDoTasks
////
////  Created by Максим on 29.03.2024.
////
//
//import UIKit
//
//class FlowCalculationCoordinator: Coordinator {
//    var coordinators: [Coordinator] = []
//    
//    let viewControllerFactory = ViewControllerFactory()
//    
//    let navigationController: UINavigationController
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func startInitialFlow() {
//        startCalculationFlow()
//    }
//    
//    func startCalculationFlow() {
//        let secondFlowViewControllerOne = viewControllerFactory.createSecondFlowViewControllerOne()
//        secondFlowViewControllerOne.calculateControllerCoordinator = self
//        navigationController.pushViewController(secondFlowViewControllerOne, animated: true)
//    }
//    
//    
//}
>>>>>>> tik_2-NetworkSession
