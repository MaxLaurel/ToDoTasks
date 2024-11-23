//
//  AppCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation
import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {
    
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
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.startTabBarControllerFlow()
            } else {
                self.startLoginFlow()
            }
        }
    }

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

