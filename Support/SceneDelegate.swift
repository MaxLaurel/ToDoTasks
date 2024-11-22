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
 
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        appCoordinator = AppCoordinator(navigationController: UINavigationController(), window: window!)
        window?.rootViewController = appCoordinator?.navigationController
        appCoordinator?.navigationController.setNavigationBarHidden(true, animated: false)
        window?.makeKeyAndVisible()
        appCoordinator?.startInitialFlow()
    }
    
>>>>>>> tik_2-NetworkSession
}

