//
//  LoginViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation
import UIKit

class LoginViewControllerCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    var viewControllerFactory = ViewControllerFactory()
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
     func start() {
       // let loginViewController = LoginViewController()
        let loginViewController = viewControllerFactory.createLoginViewController()
        loginViewController.loginViewControllerCoordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
}
