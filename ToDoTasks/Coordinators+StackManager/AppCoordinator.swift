//
//  AppCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//


import UIKit
import FirebaseAuth
import Combine

class AppCoordinator: Coordinating, ChildCoordinating {
    
    var childCoordinators: [ChildCoordinating] = []
    var window: UIWindow
    private let animationHandler: AnimationHandlerManagable
    private let container: DIContainer
    private let loginViewControllerCoordinator: LoginViewControllerCoordinator
    var tabBarControllerCoordinator: TabBarControllerCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(window: UIWindow, tabBarControllerCoordinator: TabBarControllerCoordinator, loginViewControllerCoordinator: LoginViewControllerCoordinator, animationHandler: AnimationHandlerManagable) {
        self.window = window
        self.container = DIContainer.shared
        self.animationHandler = animationHandler
        self.loginViewControllerCoordinator = loginViewControllerCoordinator
        self.tabBarControllerCoordinator = tabBarControllerCoordinator
    }
    
    //MARK: - это первый метод который запускается в SceneDelegate. C него начинается стек координаторов /далее идет метод-слушатель Firebase, который срабатывает каждый раз когда происходит смена состояния пользователя(например, регистрация, вход или выход из системы) автоматически
    func start() {
        //        Auth.auth().addStateDidChangeListener { _, user in
        //            if user != nil {
        //                self.startTabBarControllerFlow()//если юзер найден в системе срабат. этот метод и переходим на TabBar
        //            } else {
        //                self.startLoginFlow()//если не найден перекидывает на контроллер с логином
        //            }
        //        }
        
        //MARK: - новый метод с комбайном
        AuthHelper.shared.authenticationStatePublisher
            .sink { [weak self] isAuthenticated in
                if isAuthenticated {
                    self?.startTabBarControllerFlow()
                } else {
                    self?.startLoginFlow()
                }
            }
            .store(in: &cancellables)
        
        // Начинаем слушать изменения аутентификации
        AuthHelper.shared.addFirebaseListener()
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
//        
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            for window in windowScene.windows {
//                if let navController = window.rootViewController as? UINavigationController {
//                    navController.setViewControllers([], animated: false)
//                }
//            }
//        }
        
        childCoordinators.forEach { $0.removeAllChildCoordinators() }//рекурсивно проходим по всем координаторам чтобы удалить их
        childCoordinators.removeAll()//после удаления подчищаем массив координаторов
        startLoginFlow()
    }
}


