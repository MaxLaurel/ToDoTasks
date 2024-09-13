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
