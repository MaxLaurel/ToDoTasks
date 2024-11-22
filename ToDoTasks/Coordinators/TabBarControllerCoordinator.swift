<<<<<<< HEAD
//
//  TabBarControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 17.03.2024.
//

=======
>>>>>>> tik_2-NetworkSession
import Foundation
import UIKit

class TabBarControllerCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
<<<<<<< HEAD
    
    var viewControllerFactory = ViewControllerFactory()
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = viewControllerFactory.createTabBarController()
        tabBarController.tabBarControllerCoordinator = self
        navigationController.pushViewController(tabBarController, animated: true)
=======
    var viewControllerFactory = ViewControllerFactory()
    
    func startInitialFlow() {
        // Создаем экземпляр UITabBarController
        guard let tabBarController = viewControllerFactory.instantiate(type: .tabBarVC) as? TabBarController else {return}
        
        // Создаем координаторы для каждого таба
        let taskCoordinator = TaskViewControllerCoordinator(navigationController: UINavigationController())
        taskCoordinator.startInitialFlow()
        
        let calculateCoordinator = CalculateControllerCoordinator(navigationController: UINavigationController())
        calculateCoordinator.startInitialFlow()
        
        let newsCoordinator = NewsControllerCoordinator(navigationController: UINavigationController())
        newsCoordinator.startInitialFlow()

        // Устанавливаем viewControllers для таб-бар-контроллера
        tabBarController.viewControllers = [taskCoordinator.navigationController, calculateCoordinator.navigationController, newsCoordinator.navigationController]

        // Добавляем координаторы в массив
//        coordinators.append(taskCoordinator)
//        coordinators.append(calculateCoordinator)
//        coordinators.append(newsCoordinator)
>>>>>>> tik_2-NetworkSession
    }
}
