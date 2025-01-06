//
//  AppCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation
import UIKit
import FirebaseAuth

class AppCoordinator: Coordinating, CoordinatingManager {
    
    var childCoordinators: [Coordinating] = []
    private var window: UIWindow
    private let animationHandler: AnimationHandler
    private let container: DIContainer
    private let loginViewControllerCoordinator: LoginViewControllerCoordinator?
    
    init(window: UIWindow, container: DIContainer) {
        self.window = window
        self.animationHandler = AnimationHandler()
        self.container = container
        self.loginViewControllerCoordinator = container.resolveLoginViewControllerCoordinator(with: window, UINavigationController(), animationHandler)
    }
    
    func start() {//MARK: это первый метод который запускается в SceneDelegate. C него начинается стек координаторов
        
        //MARK: далее идет метод-слушатель Firebase, который срабатывает каждый раз когда происходит смена состояния пользователя(например, регистрация, вход или выход из системы) автоматически
        Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                self.startTabBarControllerFlow()//если юзер найден в системе срабат. этот метод и переходим на TabBar
            } else {
                self.startLoginFlow()//если не найден перекидывает на контроллер с логином
            }
        }
    }
    
     func startLoginFlow() {
       // let navigationController = UINavigationController()
//        let loginViewControllerCoordinator = DIContainer.shared.diContainer.resolve(LoginViewControllerCoordinator.self, arguments: window, navigationController, animationHandler)
         
        window.rootViewController = loginViewControllerCoordinator?.navigationController
        window.makeKeyAndVisible()
        loginViewControllerCoordinator?.startLoginViewControllerFlow()
        addChildCoordinator(loginViewControllerCoordinator!)
    }
    
     func startTabBarControllerFlow() {
        let navigationController = UINavigationController()
//        let tabBarControllerCoordinator = DINetworkContainer.shared.container.resolve( TabBarControllerCoordinator.self, arguments: window, navigationController)
         
         let tabBarControllerCoordinator = TabBarControllerCoordinator(window: window, navigationController: navigationController, taskViewControllerCoordinator: TaskViewControllerCoordinator(navigationController: UINavigationController()), calculatorViewControllerCoordinator: CalculateViewControllerCoordinator(navigationController: UINavigationController()), newsViewControllerCoordinator: NewsViewControllerCoordinator(navigationController: UINavigationController()))

        tabBarControllerCoordinator.startTabBarViewControllerFlow()
        addChildCoordinator(tabBarControllerCoordinator)
    }
}

