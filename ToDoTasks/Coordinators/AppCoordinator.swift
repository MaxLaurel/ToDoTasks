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
    
    var coordinators: [Coordinator] = []
    
    //    let window: UIWindow
    //
    var navigationController: UINavigationController
    //
    //    //navigationController.navigationBar.isHidden = true
    //
    //    init(window: UIWindow, navigationController: UINavigationController) {
    //        self.window = window
    //        self.navigationController = navigationController
    //        self.window.rootViewController = navigationController
    //        navigationController.setNavigationBarHidden(true, animated: false)
    //        self.window.makeKeyAndVisible()
    //    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.startTabBarControllerFlow()
            } else {
                self.startLoginFlow()
            }
        }
    }
    
    private func startLoginFlow() {
        //        let loginControllerCoordinator = LoginViewControllerCoordinator(navigationController: navigationController)
        let loginControllerCoordinator =  CoordinatorFactory().createLoginCoordinator(navigationController: navigationController)
        //add(coordinator: loginControllerCoordinator)
        loginControllerCoordinator.start()
    }
    private func startTabBarControllerFlow() {
        //        let tabBarControllerCoordinator = TabBarControllerCoordinator(navigationController: navigationController)
        //add(coordinator: tabBarControllerCoordinator)
        let tabBarControllerCoordinator = CoordinatorFactory().createTabBarControllerCoordinator(navigationController: navigationController)
        tabBarControllerCoordinator.start()
    }
}
