//
//  SceneDelegate.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            let initialViewController = LoginViewController()
        
        
        let tabBarViewController = UITabBarController()

        //tabBarViewController.tabBar.isTranslucent = false
        
        let loginViewController = LoginViewController()
        let loginTabBarController = UINavigationController(rootViewController: loginViewController)
        //loginTabBarController.hidesBottomBarWhenPushed = true
       // loginTabBarController.tabBarController?.tabBar.isHidden = true
        

        let tableViewController = TaskViewController()
        let taskNavController = UINavigationController(rootViewController: tableViewController)

        let calculateViewController = CalculationViewController()
        let calculateNavBarController = UINavigationController(rootViewController: calculateViewController)

        tabBarViewController.viewControllers = [loginTabBarController, taskNavController, calculateNavBarController]
        tabBarViewController.selectedViewController = loginTabBarController
       //tableViewController.tabBarController?.tabBar.isHidden = true
        

        taskNavController.tabBarItem = UITabBarItem(title: "tasks", image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), tag: 0)
        taskNavController.tabBarItem.badgeValue = "\(tableViewController.arrayOfTasks.count)"
        taskNavController.tabBarItem.badgeColor = .systemGreen
        
        loginTabBarController.tabBarItem = UITabBarItem.init(title: "log In", image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), tag: 1)
        
        calculateNavBarController.tabBarItem = UITabBarItem.init(title: "calculate", image: UIImage.init(systemName: "arrow.forward.square"), tag: 2)


        tabBarViewController.tabBar.tintColor = UIColor.init(red: 0.7, green: 0.5, blue: 0.5, alpha: 1)
        tabBarViewController.tabBar.unselectedItemTintColor = UIColor.init(red: 0.5, green: 0.7, blue: 0.5, alpha: 1)
        tabBarViewController.tabBar.backgroundColor = UIColor.init(white: 1, alpha: 1)

        
            let navigationViewController = UINavigationController(rootViewController: tabBarViewController)
            window?.rootViewController = navigationViewController
            window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

