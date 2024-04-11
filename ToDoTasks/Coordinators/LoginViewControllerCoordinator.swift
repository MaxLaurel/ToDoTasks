//
//  LoginViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation
import UIKit

class LoginViewControllerCoordinator: BaseCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let loginViewController = LoginViewController()
        loginViewController.loginViewControllerCoordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
}
