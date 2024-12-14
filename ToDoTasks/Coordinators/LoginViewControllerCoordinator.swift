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
    //var viewControllerFactory = ViewControllerFactory()
    var navigationController: UINavigationController
    var loginViewController: LoginViewController? // Храним экземпляр LoginViewController
    let animationHandler: AnimationHandler?
    let container: DINetworkContainer
    
    init(navigationController: UINavigationController, animationHandler: AnimationHandler?, container: DINetworkContainer) {
        self.navigationController = navigationController
        self.animationHandler = animationHandler
        self.container = container

    }
    
    func startInitialFlow() {
        // Проверяем, если loginViewController уже создан
        if loginViewController == nil {
            // Инициализируем новый экземпляр и сохраняем его в свойстве класса
            guard let animationHanler = animationHandler else { return }
            loginViewController = LoginViewController(animationHandler: animationHanler, container: container)
            navigationController.pushViewController(loginViewController!, animated: true)
        }
        
        // Устанавливаем LoginViewController в стек навигации
        navigationController.setViewControllers([loginViewController!], animated: true)
    }
}
