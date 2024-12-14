import Foundation
import UIKit

class TabBarControllerCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    //var viewControllerFactory = ViewControllerFactory()
    let container: DINetworkContainer
    
    init(container: DINetworkContainer) {
        self.container = container
    }
    
    func startInitialFlow() {
        // Создаем экземпляр UITabBarController
        let tabBarVC = TabBarController(container: container)
        //SceneDelegate.window?.rootViewController = tabBarVC

        // Создаем координаторы для каждого таба
        let taskCoordinator = TaskViewControllerCoordinator(navigationController: UINavigationController())
        taskCoordinator.startInitialFlow()
        
        let calculateCoordinator = CalculateControllerCoordinator(navigationController: UINavigationController())
        calculateCoordinator.startInitialFlow()
        
        let newsCoordinator = NewsControllerCoordinator(navigationController: UINavigationController(), container: container)
        newsCoordinator.startInitialFlow()

        // Устанавливаем viewControllers для таб-бар-контроллера
        tabBarVC.viewControllers = [taskCoordinator.navigationController, calculateCoordinator.navigationController, newsCoordinator.navigationController]

        // Добавляем координаторы в массив
//        coordinators.append(taskCoordinator)
//        coordinators.append(calculateCoordinator)
//        coordinators.append(newsCoordinator)
    }
}
