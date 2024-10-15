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
    
    var navigationController: UINavigationController
    let animationHandler: AnimationHandler
    
    init(navigationController: UINavigationController, animationHandler: AnimationHandler) {
        self.navigationController = navigationController
        self.animationHandler = animationHandler
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
    
    private func startLoginFlow() {
        let loginControllerCoordinator = LoginViewControllerCoordinator(navigationController: navigationController)
        loginControllerCoordinator.startInitialFlow()
        
        //let loginControllerCoordinator =  CoordinatorFactory().createLoginCoordinator(navigationController: navigationController)
        //add(coordinator: loginControllerCoordinator)
        
    }
    private func startTabBarControllerFlow() {
        let tabBarControllerCoordinator = TabBarControllerCoordinator(navigationController: navigationController)
        add(coordinator: tabBarControllerCoordinator)
        tabBarControllerCoordinator.startInitialFlow()
        
        //let tabBarControllerCoordinator = CoordinatorFactory().createTabBarControllerCoordinator(navigationController: navigationController)
    }
}
