//
//  TaskViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 24.03.2024.
//

import UIKit
import FirebaseAuth

final class TaskViewControllerCoordinator: Coordinating, CoordinatingManager {
    
  // weak var parentDelegate: TabBarControllerCoordinator?
    var childCoordinators: [any Coordinating] = []
    let navigationController: UINavigationController
    let window: UIWindow
    weak var appCoordinator: AppCoordinator? //нам нужен родительский координатор чтобы сбросить все координаторы приложения и разлогиниться
    
    init(navigationController: UINavigationController, window: UIWindow, appCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.window = window
        self.appCoordinator = appCoordinator
    }
    
    func start()  {
        let taskViewController = TaskViewController(taskViewControllerCoordinator: self)
        navigationController.pushViewController(taskViewController, animated: true)
    }
    
    func backToLoginViewController() {
        do {
            guard let appCoordinator else {
                Log.error( "No appCoordinator found")
                return
            }
            appCoordinator.resetApplicationState()
            try Auth.auth().signOut()
            navigationController.setViewControllers([], animated: false)
            Log.info("All child coordinators removed from \(self). Current child coordinators: \(childCoordinators)")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
