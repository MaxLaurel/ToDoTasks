//
//  ModuleFactory.swift
//  ToDoTasks
//
//  Created by Максим on 29.03.2024.
//

import UIKit

class ModuleFactory: UIViewController {

    func createLoginViewController() -> LoginViewController {
        return LoginViewController()
    }
    
    func createTabBarController() -> TabBarController {
        return TabBarController()
    }
    
    func createSecondFlowViewControllerOne() -> SecondFlowViewControllerOne {
        return SecondFlowViewControllerOne()
    }
    
    func createSecondFlowViewControllerTwo() -> SecondFlowViewControllerTwo {
        return SecondFlowViewControllerTwo()
    }
}
