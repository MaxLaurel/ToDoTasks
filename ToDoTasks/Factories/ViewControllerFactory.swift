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
        case newsVC
    }
    
    func instantiate(type: VCType) -> UIViewController {
        let animationHandler = AnimationHandler()
        
        switch type {
        case .loginVC: return LoginViewController(animationHandler: animationHandler)
        case .tabBarVC: return TabBarController()
        case .taskVC: return TaskViewController()
        case .calculateVC: return CalculationViewController()
        case .newsVC: return YouTubeNewsTableViewController()
        }
    }
}
