//
//  AppDelegate.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var backgroundSessionCompletionHandler: (() -> Void)?//обраблтчик фоновой сессии
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.keyboardDistance = 150
        FirebaseApp.configure()
        return true
    }

    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
   
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {//это обработчик фоновой сессии, в нем мы сохраняем backgroundSessionCompletionHandler чтобы позже использовать его в urlSessionDidFinishEvents
        backgroundSessionCompletionHandler = completionHandler
    }
}

