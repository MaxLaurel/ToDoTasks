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
    var navigationController: UINavigationController
    var loginViewController: LoginViewController? // Храним экземпляр LoginViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startInitialFlow() {
        // Проверяем, если loginViewController уже создан
        if loginViewController == nil {
            // Инициализируем новый экземпляр и сохраняем его в свойстве класса
            loginViewController = viewControllerFactory.instantiate(type: .loginVC) as? LoginViewController
        }
        
        // Устанавливаем LoginViewController в стек навигации
        navigationController.setViewControllers([loginViewController!], animated: true)
    }
}
