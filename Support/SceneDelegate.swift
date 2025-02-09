//
//  SceneDelegate.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
<<<<<<< HEAD
    
    var window: UIWindow?
    
    let appCoordinator = CoordinatorFactory().createAppCoordinator(navigationController: UINavigationController())
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        //guard let window = window else {return}
        //appCoordinator = AppCoordinator(window: window)
        window?.rootViewController = appCoordinator.navigationController
        appCoordinator.navigationController.setNavigationBarHidden(true, animated: false)
        window?.makeKeyAndVisible()
        appCoordinator.start()
    }
=======
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    let container = DIContainer.shared //MARK: изначально здесь создаем контейнер
 
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
//        appCoordinator = AppCoordinator(/*navigationController: UINavigationController(),*/ window: window!, container: container)//передаем контейнер в координатора
        
        
        appCoordinator = container.resolveAppCoordinator(window: window)
//        window?.rootViewController = appCoordinator?.navigatioExtranController
//        appCoordinator?.navigationController.setNavigationBarHidden(true, animated: false)
//        window?.makeKeyAndVisible()
        appCoordinator?.start()
    }
    
>>>>>>> tik_2-NetworkSession
}

