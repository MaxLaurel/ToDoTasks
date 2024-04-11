//
//  ModuleFactory.swift
//  ToDoTasks
//
//  Created by Максим on 29.03.2024.
//

import UIKit

class ViewControllerFactory: UIViewController {

    func createLoginViewController() -> LoginViewController {
        return LoginViewController()
    }
    
    func createTabBarController() -> TabBarController {
        return TabBarController()
    }
    
    func createTaskViewController() -> TaskViewController {
        return TaskViewController()
    }
    
    func createCalculateViewController() -> CalculationViewController {
        return CalculationViewController()
    }
    
    func createSecondFlowViewControllerOne() -> SecondFlowViewControllerOne {
        return SecondFlowViewControllerOne()
    }
    
    func createSecondFlowViewControllerTwo() -> SecondFlowViewControllerTwo {
        return SecondFlowViewControllerTwo()
    }
}
