//
//  TaskViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 24.03.2024.
//

import UIKit
import FirebaseAuth

final class TaskViewControllerCoordinator: Coordinating, ChildCoordinating {
    var childCoordinators: [ChildCoordinating] = []
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
        guard let appCoordinator else {
            Log.error("No appCoordinator found")
            return
        }
        do {
//            NavigationStackManager.shared.printAllNavigationStacks()
            NavigationStackManager.shared.removeAllViewControllers()
            appCoordinator.resetApplicationState()
            navigationController.setViewControllers([], animated: false)
            try Auth.auth().signOut()
//            NavigationStackManager.shared.printAllNavigationStacks()
        } catch {
            Log.error("Error signing out: \(error.localizedDescription)")
        }
    }
    
    deinit {
        Log.info("TaskViewControllerCoordinator deinitialized")
    }
}
