//
//  AppCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation
import UIKit
import Firebase

class AppCoordinator: Coordinator {
    
<<<<<<< HEAD
    var coordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
=======
   var coordinators: [Coordinator] = []
   var navigationController: UINavigationController
   private var window: UIWindow
   var loginViewControllerCoordinator: LoginViewControllerCoordinator?  // Сохраняем координатор
   var factory: ViewControllerFactory?

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }

    func startInitialFlow() {
>>>>>>> tik_2-NetworkSession
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.startTabBarControllerFlow()
            } else {
                self.startLoginFlow()
            }
        }
    }
<<<<<<< HEAD
    
    private func startLoginFlow() {
        let loginControllerCoordinator =  CoordinatorFactory().createLoginCoordinator(navigationController: navigationController)
        //add(coordinator: loginControllerCoordinator)
        loginControllerCoordinator.start()
    }
    private func startTabBarControllerFlow() {
        let tabBarControllerCoordinator = CoordinatorFactory().createTabBarControllerCoordinator(navigationController: navigationController)
        add(coordinator: tabBarControllerCoordinator)
        tabBarControllerCoordinator.start()
    }
}
=======

    func startLoginFlow() {
        // Если координатор уже создан, используем его, иначе создаем новый
        if loginViewControllerCoordinator == nil {
            loginViewControllerCoordinator = LoginViewControllerCoordinator(navigationController: navigationController)
        }
        loginViewControllerCoordinator?.startInitialFlow()
    }

    private func startTabBarControllerFlow() {
        let tabBarControllerCoordinator = TabBarControllerCoordinator()
        tabBarControllerCoordinator.startInitialFlow()
        window.rootViewController = tabBarControllerCoordinator.viewControllerFactory.instantiate(type: .tabBarVC)
        add(coordinator: tabBarControllerCoordinator)
    }
}

>>>>>>> tik_2-NetworkSession
