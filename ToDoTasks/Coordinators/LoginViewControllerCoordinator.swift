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
<<<<<<< HEAD
    
    let navigationController: UINavigationController
=======
    var navigationController: UINavigationController
    var loginViewController: LoginViewController? // Храним экземпляр LoginViewController
>>>>>>> tik_2-NetworkSession
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
<<<<<<< HEAD
     func start() {
       // let loginViewController = LoginViewController()
        let loginViewController = viewControllerFactory.createLoginViewController()
        loginViewController.loginViewControllerCoordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
=======
    func startInitialFlow() {
        // Проверяем, если loginViewController уже создан
        if loginViewController == nil {
            // Инициализируем новый экземпляр и сохраняем его в свойстве класса
            loginViewController = viewControllerFactory.instantiate(type: .loginVC) as? LoginViewController
        }
        
        // Устанавливаем LoginViewController в стек навигации
        navigationController.setViewControllers([loginViewController!], animated: true)
    }
>>>>>>> tik_2-NetworkSession
}
