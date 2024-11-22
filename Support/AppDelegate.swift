//
//  AppDelegate.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
<<<<<<< HEAD
=======
import FirebaseAnalytics
>>>>>>> tik_2-NetworkSession

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

<<<<<<< HEAD
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 150
        FirebaseApp.configure()
=======
    var backgroundSessionCompletionHandler: (() -> Void)?//обраблтчик фоновой сессии
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistance = 150
        FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(false)
>>>>>>> tik_2-NetworkSession
        
        return true
    }

<<<<<<< HEAD

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
=======
    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
>>>>>>> tik_2-NetworkSession
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
<<<<<<< HEAD
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


=======
   
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {//это обработчик фоновой сессии, в нем мы сохраняем backgroundSessionCompletionHandler чтобы позже использовать его в urlSessionDidFinishEvents
        backgroundSessionCompletionHandler = completionHandler
    }
>>>>>>> tik_2-NetworkSession
}

