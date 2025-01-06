//
//  ServiceProvider.swift
//  ToDoTasks
//
//  Created by Максим on 09.11.2024.
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

final class DIContainer {
    static var shared = DIContainer()
    let сontainer = Container()
    
    private init() {
        registerNetworkManagerDependancies()
        registerImageFetcher()
        registerCoordinators()
    }
    
    func resolveEndpointConfigurable(type: EndpointType, token: String, image: UIImage, text: String) -> EndpointConfigurable {
        guard let dependency = сontainer.resolve(EndpointConfigurable.self, arguments: type, token, image, text) else {
            fatalError("Failed to resolve EndpointConfigurable with arguments")
        }
        return dependency
    }
    
    func resolveRetryConfigurable(policy: RetryPolicy) -> RetryConfigurable {
        guard let dependency = сontainer.resolve(RetryConfigurable.self, argument: policy) else {
            fatalError("Failed to resolve RetryConfigurable with argument \(policy)")
        }
        return dependency
    }
    
    func resolveSessionConfigurable(type: SessionConfiguration, delegate: URLSessionDelegate?) -> SessionConfigurable {
        guard let dependency = сontainer.resolve(SessionConfigurable.self, arguments: type, delegate) else {
            fatalError("Failed to resolve SessionConfigurable with arguments")
        }
        return dependency
    }
    
    func resolveNetworkRequestPerforming(endpoint: EndpointConfigurable, retryPolicy: RetryConfigurable, session: SessionConfigurable) -> NetworkRequestPerforming {
        guard let dependency = сontainer.resolve(NetworkRequestPerforming.self, arguments: endpoint, retryPolicy, session) else {
            fatalError("Failed to resolve NetworkRequestPerforming with arguments")
        }
        return dependency
    }
    
    func resolveAppCoordinator(window: UIWindow, container: DIContainer) -> AppCoordinator {
        guard let appCoordinator = сontainer.resolve(AppCoordinator.self, arguments: window, container) else {
            fatalError("Failed to resolve AppCoordinator")
        }
        return appCoordinator
    }
    
    func resolveLoginViewControllerCoordinator(with window: UIWindow,_ navigationController: UINavigationController, _ animationHandler: AnimationHandler) -> LoginViewControllerCoordinator {
        guard let LoginViewControllerCoordinator = сontainer.resolve(LoginViewControllerCoordinator.self, arguments: window, navigationController, animationHandler) else {
            fatalError("Failed to resolve LoginViewControllerCoordinator")
        }
        return LoginViewControllerCoordinator
    }
    
    func resolveTabBarControllerCoordinator(window: UIWindow, navigationController: UINavigationController) -> TabBarControllerCoordinator {
        guard let tabBarCoordinator = сontainer.resolve(TabBarControllerCoordinator.self, arguments: window, navigationController) else {
            fatalError("Failed to resolve TabBarControllerCoordinator")
        }
        return tabBarCoordinator
    }
}

private extension DIContainer {//MARK: здесь все методы для регистрации зависимостей NetworkManager(сеть)
    
    func registerNetworkManagerDependancies() {
        
        сontainer.register(ErrorUsable.self) { _ in
            ErrorHandler()
        }
        сontainer.register(EndpointConfigurable.self) { (_, type: EndpointType, token: String, image: UIImage, text: String) in
            switch type {
            case .getForegroundData:
                return EndpointType.getForegroundData
            case .getForegroundDataWithToken:
                return EndpointType.getForegroundDataWithToken(token: token)
            case .uploadMultiPartData:
                return EndpointType.uploadMultiPartData(image: image, text: text)
            case .downloadBackgroundData:
                return EndpointType.downloadBackgroundData
            }
        }
        
        сontainer.register(RetryConfigurable.self) { (_, type: RetryPolicy) in
            switch type {
            case .aggressive:
                return RetryPolicy.aggressive
            case .moderate:
                return RetryPolicy.moderate
            }
        }
        
        сontainer.register(SessionConfigurable.self) { (_, type: SessionConfiguration, delegate: URLSessionDelegate) in
            switch type {
            case .foregroundSession:
                return SessionConfiguration.foregroundSession
            case .backgroundSession:
                return SessionConfiguration.backgroundSession(delegate: delegate)
            }
        }
        
        сontainer.register(NetworkRequestPerforming.self) {
            (resolver,
             endpoint: EndpointConfigurable,
             retryPolicy: RetryConfigurable,
             foregroundSession: SessionConfigurable) in
            guard let errorUsable = resolver.resolve(ErrorUsable.self) else { fatalError() }
            
            return NetworkManager(
                errorHandler: errorUsable,
                endpoint: endpoint,
                retryPolicy: retryPolicy,
                foregroundSession: foregroundSession)
        }.inObjectScope(.container)
    }
}

private extension DIContainer {//MARK: здесь регистрация фетчера который ходит в сеть за картинкой для таблицы и кеширует ее
    
    func registerImageFetcher() {
        сontainer.register(URLtoImageFetcherProtocol.self) { _ in
            return URLtoImageFetcher()
        }
    }
}


private extension DIContainer {//MARK: В этом расширении регистрируем зависимости координаторов
    
    func registerCoordinators() {
        
        сontainer.register(AppCoordinator.self) { (resolver, window: UIWindow, container: DIContainer) in
            return AppCoordinator(window: window, container: container)
        }.inObjectScope(.container)
        
        сontainer.register(LoginViewControllerCoordinator.self) { (resolver, window: UIWindow, navigationController: UINavigationController, animationHandler: AnimationHandler) in
            
//            guard let registerViewControllerCoordinator = resolver.resolve(RegisterViewControllerCoordinator.self) else {fatalError("Failed to resolve RegisterViewControllerCoordinator")}
            return LoginViewControllerCoordinator(window: window, animationHandler: animationHandler/*, registerViewControllerCoordinator: registerViewControllerCoordinator*/)
        }
        
        сontainer.register(TaskViewControllerCoordinator.self) { _ in
            return TaskViewControllerCoordinator(navigationController: UINavigationController())
        }
        
        сontainer.register(NewsViewControllerCoordinator.self) { resolver in
            guard let networkManager = resolver.resolve(NetworkRequestPerforming.self),
                    let imageFetcher = resolver.resolve(URLtoImageFetcherProtocol.self)
            else {fatalError("Failed to resolve dependencies for NewsControllerCoordinator")}
            
            return NewsViewControllerCoordinator(
//                networkManager: networkManager,
//                imageFetcher: imageFetcher,
                navigationController: UINavigationController()
            )
        }
        
        сontainer.register(CalculateViewControllerCoordinator.self) { _ in
            return CalculateViewControllerCoordinator(navigationController: UINavigationController())
        }
        
        сontainer.register(TabBarControllerCoordinator.self) { (resolver, window: UIWindow, navigationController: UINavigationController) in
            let taskViewControllerCoordinator = resolver.resolve(TaskViewControllerCoordinator.self)
            let calculateViewControllerCoordinator = resolver.resolve(CalculateViewControllerCoordinator.self)
            let newsControllerCoordinator = resolver.resolve(NewsViewControllerCoordinator.self)
            
            guard let taskViewControllerCoordinator = taskViewControllerCoordinator,
                  let calculateViewControllerCoordinator = calculateViewControllerCoordinator,
                  let newsControllerCoordinator = newsControllerCoordinator else {fatalError()}
            
            return TabBarControllerCoordinator(
                window: window,
                navigationController: navigationController,
                taskViewControllerCoordinator: taskViewControllerCoordinator,
                calculatorViewControllerCoordinator: calculateViewControllerCoordinator,
                newsViewControllerCoordinator: newsControllerCoordinator)
        }
        
        сontainer.register(RegisterViewControllerCoordinator.self) { (_,
                animationHandler: AnimationHandler,
                navigationController: UINavigationController,
                window: UIWindow) in
            
            return RegisterViewControllerCoordinator(
                animationHandler: animationHandler,
                navigationController: navigationController,
                window: window)
        }
    }
}
