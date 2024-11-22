import Foundation
import UIKit

class TabBarControllerCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
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
    }
}
