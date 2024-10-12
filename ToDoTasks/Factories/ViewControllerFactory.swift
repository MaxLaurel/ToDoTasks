//
//  ModuleFactory.swift
//  ToDoTasks
//
//  Created by Максим on 29.03.2024.
//

import UIKit

protocol ViewControllerFactoryUsable {
}

 class ViewControllerFactory: ViewControllerFactoryUsable {
     
     enum VCType {
     case loginVC
     case tabBarVC
     case taskVC
     case calculateVC
     case secondFlowVCone
     case secondFlowVCTwo
     case newsVC
     }

     func instantiate(type: VCType) -> UIViewController {
         switch type {
         case .loginVC: return LoginViewController()
         case .tabBarVC: return TabBarController()
         case .taskVC: return TaskViewController()
         case .calculateVC: return CalculationViewController()
         case .secondFlowVCone: return SecondFlowViewControllerOne()
         case .secondFlowVCTwo: return SecondFlowViewControllerTwo()
         case .newsVC: return YouTubeNewsTableViewController()
         }
     }
    
//    func createLoginViewController() -> LoginViewController {
//        return LoginViewController()
//    }
//    
//    func createTabBarController() -> TabBarController {
//        return TabBarController()
//    }
    
//    func createTaskViewController() -> TaskViewController {
//        return TaskViewController()
//    }
    
//    func createCalculateViewController() -> CalculationViewController {
//        return CalculationViewController()
//    }
//     func createNewsViewController() -> YouTubeNewsTableViewController {
//         return YouTubeNewsTableViewController()
//     }
    
    func createSecondFlowViewControllerOne() -> SecondFlowViewControllerOne {
        return SecondFlowViewControllerOne()
    }
    
    func createSecondFlowViewControllerTwo() -> SecondFlowViewControllerTwo {
        return SecondFlowViewControllerTwo()
    }
    
}
