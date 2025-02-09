//
//  DIContainer+Network.swift
//  ToDoTasks
//
//  Created by Максим on 24.01.2025.
//

import Foundation
import UIKit

extension DIContainer {
    
    func registerCoordinators() {
        
        container.register(AppCoordinator.self) { (resolver, window: UIWindow) in
            let animationHandler = self.resolveAnimationHandler()
             let loginViewControllerCoordinator = self.resolveLoginViewControllerCoordinator(with: window)
            
             let tabBarControllerCoordinator = self.resolveTabBarControllerCoordinator(window: window, navigationController: UINavigationController())
            
            return AppCoordinator(window: window, tabBarControllerCoordinator: tabBarControllerCoordinator, loginViewControllerCoordinator: loginViewControllerCoordinator, animationHandler: animationHandler)
        }
        
        container.register(LoginViewControllerCoordinator.self) { (resolver, window: UIWindow) in
            let navigationController = UINavigationController()
            let animationHandler = self.resolveAnimationHandler()
            guard let registerViewControllerCoordinator = resolver.resolve(RegisterViewControllerCoordinator.self, arguments: window, navigationController ) else {
                Log.error("Failed to resolve RegisterViewControllerCoordinator")
                fatalError()
            }
            
            return LoginViewControllerCoordinator(window: window, animationHandler: animationHandler, registerViewControllerCoordinator: registerViewControllerCoordinator, navigationController: navigationController)
        }
        
        container.register(RegisterViewControllerCoordinator.self) { (resolver, window: UIWindow, navigationController: UINavigationController) in
             let tabBarControllerCoordinator = self.resolveTabBarControllerCoordinator(window: window, navigationController: navigationController)
            let animationHandler = self.resolveAnimationHandler()
            
            return RegisterViewControllerCoordinator(
                animationHandler: animationHandler,
                navigationController: navigationController,
                window: window,
                tabBarControllerCoordinator: tabBarControllerCoordinator
            )
        }
        
        container.register(TaskViewControllerCoordinator.self) { (_, window: UIWindow) in
            
            let navigationController = UINavigationController()
            return TaskViewControllerCoordinator(navigationController: navigationController, window: window, appCoordinator: nil)
        }
        //MARK: .initCompleted нужен когда нужно создать какую-то зависимость позже. В нашем случае была рекурсивная зависимость между AppCoordinator-TabBarCoordinator-TaskViewControllerCoordinator-AppCoordinator. Поэтому пришлось в TaskViewControllerCoordinator сделать слабую ссылку на AppCoordinator и делать его nil при инициализации. Далее когда TaskViewControllerCoordinator инициализировался мы в initCompleted резолвим AppCoordinator и добавляем его для TaskViewControllerCoordinator.
        .initCompleted { resolver, taskCoordinator in
            // После инициализации TaskViewControllerCoordinator назначаем AppCoordinator
            guard let appCoordinator = resolver.resolve(AppCoordinator.self, argument: taskCoordinator.window) else {
                Log.error("AppCoordinator not found")
                return
            }
            taskCoordinator.appCoordinator = appCoordinator
        }
        
        container.register(NewsViewControllerCoordinator.self) { resolver in
            let imageFetcher = self.resolveImageFetcher()
            
            let endpoint = EndpointType.getForegroundData
            let retryPolicy = RetryPolicy.aggressive
            let session = SessionConfiguration.foregroundSession
            
            //MARK: - networkManager остается гибким, так-как принимает нужные параметры а не захардкоживает их реализацию внутри себя. Например в другой координатор можно передать тот же самый менеджер но уже с другими кейсами EndpointType, RetryPolicy, SessionConfiguration и соответственно реализация этого менеджера будет уже совсем другой
            guard let networkManager = self.resolveNetworkManager(endpoint: endpoint, retryPolicy: retryPolicy, session: session) else {
                Log.error("Failed to resolve NetworkManager")
                fatalError()
            }
            return NewsViewControllerCoordinator(navigationController: UINavigationController(), imageFetcher: imageFetcher, networkManager: networkManager)
        }
        
        container.register(CalculateViewControllerCoordinator.self) { _ in
            return CalculateViewControllerCoordinator(navigationController: UINavigationController())
        }
        
        container.register(TabBarControllerCoordinator.self) { (_, window: UIWindow, navigationController: UINavigationController) in
             let taskViewControllerCoordinator = self.resolveTaskViewControllerCoordinator(window: window)
             let calculateViewControllerCoordinator = self.resolveCalculateTabBarCoordinator()
             let newsControllerCoordinator = self.resolveNewsViewCoordinator() 
            
            return TabBarControllerCoordinator(
                window: window,
                navigationController: navigationController,
                taskViewControllerCoordinator: taskViewControllerCoordinator,
                calculatorViewControllerCoordinator: calculateViewControllerCoordinator,
                newsViewControllerCoordinator: newsControllerCoordinator
            )
        }
    }
    
    func resolveAppCoordinator(window: UIWindow) -> AppCoordinator {
        guard let appCoordinator = container.resolve(AppCoordinator.self, argument: window) else {
            Log.error("Failed to resolve AppCoordinator")
            fatalError()
        }
        return appCoordinator
    }
    
    
    func resolveLoginViewControllerCoordinator(with window: UIWindow) -> LoginViewControllerCoordinator {
        guard let LoginViewControllerCoordinator = container.resolve(LoginViewControllerCoordinator.self, argument: window) else {
            Log.error("Failed to resolve LoginViewControllerCoordinator")
            fatalError()
        }
        return LoginViewControllerCoordinator
    }
    
    func resolveTabBarControllerCoordinator(window: UIWindow, navigationController: UINavigationController) -> TabBarControllerCoordinator {
        guard let tabBarCoordinator = container.resolve(TabBarControllerCoordinator.self, arguments: window, navigationController) else {
            Log.error("Failed to resolve TabBarControllerCoordinator")
            fatalError()
        }
        return tabBarCoordinator
    }
    
    func resolveTaskViewControllerCoordinator(window: UIWindow) -> TaskViewControllerCoordinator {
        guard let taskViewControllerCoordinator = container.resolve(TaskViewControllerCoordinator.self, argument: window) else {
            Log.error("Failed to resolve TaskViewControllerCoordinator")
            fatalError()
        }
        return taskViewControllerCoordinator
    }
    
    func resolveCalculateTabBarCoordinator() -> CalculateViewControllerCoordinator {
        guard let calculateViewControllerCoordinator = container.resolve(CalculateViewControllerCoordinator.self) else {
            Log.error("Failed to resolve CalculateTabBarCoordinator")
            fatalError()
        }
        return calculateViewControllerCoordinator
    }
    
    func resolveNewsViewCoordinator() -> NewsViewControllerCoordinator {
        guard let newsViewControllerCoordinator = container.resolve(NewsViewControllerCoordinator.self) else {
            Log.error("Failed to resolve NewsViewControllerCoordinator")
            fatalError()
        }
        return newsViewControllerCoordinator
    }
    
}
