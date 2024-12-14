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
   var loginViewControllerCoordinator: LoginViewControllerCoordinator?
    let container: DINetworkContainer
    let animationHandler: AnimationHandler

    init(navigationController: UINavigationController, window: UIWindow, container: DINetworkContainer) {
        self.navigationController = navigationController
        self.window = window
        self.container = container
        self.animationHandler = AnimationHandler()
    }

    func startInitialFlow() {//это первый метод который запускается в SceneDeergate. C него начинается стек координаторов
        Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                self.startTabBarControllerFlow()//если юзер найден в системе срабатывает этот метод
            } else {
                self.startLoginFlow()//если не найден перекидывает на конnроллер с логином
            }
        }
    }

    func startLoginFlow() {//здесь создаем координатор для loginViewController который бует запускать сам вьб
        // Если координатор уже создан, используем его, иначе создаем новый
        if loginViewControllerCoordinator == nil {
            loginViewControllerCoordinator = LoginViewControllerCoordinator(navigationController: navigationController, animationHandler: animationHandler, container: container)
        }
        loginViewControllerCoordinator?.startInitialFlow()
    }

    private func startTabBarControllerFlow() {
        let tabBarControllerCoordinator = TabBarControllerCoordinator(container: container)
        tabBarControllerCoordinator.startInitialFlow()
        let tabBarVC = TabBarController(container: container)
        window.rootViewController = tabBarVC 
        add(coordinator: tabBarControllerCoordinator)
    }
}

