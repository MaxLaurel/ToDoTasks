
  ModuleFactory.swift
  ToDoTasks

  Created by Максим on 29.03.2024.


import UIKit

<<<<<<< HEAD
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
    
    func createNewsViewController() -> YouTubeNewsTableViewController {
        return YouTubeNewsTableViewController()
        
=======
protocol ViewControllerFactoryUsable {
}

class ViewControllerFactory: ViewControllerFactoryUsable {
    
    enum VCType {
        case loginVC
        case tabBarVC
        case taskVC
        case calculateVC
    }
    
    func instantiate(type: VCType) -> UIViewController {
        let animationHandler = AnimationHandler()
        
        switch type {
        case .loginVC: return LoginViewController(animationHandler: animationHandler)
        case .tabBarVC: return TabBarController()
        case .taskVC: return TaskViewController()
        case .calculateVC: return CalculationViewController()
        }
>>>>>>> tik_2-NetworkSession
    }
}
