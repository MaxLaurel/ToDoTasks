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
    var window: UIWindow
    private let animationHandler: AnimationHandlerManagable
    private let container: DIContainer
    private let loginViewControllerCoordinator: LoginViewControllerCoordinator
    var tabBarControllerCoordinator: TabBarControllerCoordinator
    
    init(window: UIWindow, tabBarControllerCoordinator: TabBarControllerCoordinator, loginViewControllerCoordinator: LoginViewControllerCoordinator, animationHandler: AnimationHandlerManagable) {
        self.window = window
        self.container = DIContainer.shared
        self.animationHandler = animationHandler
        self.loginViewControllerCoordinator = loginViewControllerCoordinator
        self.tabBarControllerCoordinator = tabBarControllerCoordinator
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
        window.rootViewController = loginViewControllerCoordinator.navigationController
        window.makeKeyAndVisible()
        loginViewControllerCoordinator.startLoginViewControllerFlow()
        addChildCoordinator(loginViewControllerCoordinator)
    }
    
    func startTabBarControllerFlow() {
        tabBarControllerCoordinator.startTabBarViewControllerFlow()
        addChildCoordinator(tabBarControllerCoordinator)
    }
    
    
    func resetApplicationState() {
        // Удаляем всех дочерних координаторов
        childCoordinators.forEach { coordinator in
            (coordinator as? CoordinatingManager)?.removeAllChildCoordinators()
        }
        childCoordinators.removeAll()

        // Переключаем на экран логина
        startLoginFlow()
    }
}

