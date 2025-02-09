//import UIKit
//
//final class TabBarControllerCoordinator: Coordinating, ChildCoordinating {
//    
//    var childCoordinators: [ChildCoordinating] = []
//    let window: UIWindow
//    private var tabBarViewController: TabBarViewController?
//    let navigationController: UINavigationController
//     var taskViewControllerCoordinator: TaskViewControllerCoordinator
//     var calculatorViewControllerCoordinator: CalculateViewControllerCoordinator
//     var newsViewControllerCoordinator: NewsViewControllerCoordinator
//    weak var appCoordinator: AppCoordinator?
//    
//    init(window: UIWindow, navigationController: UINavigationController, taskViewControllerCoordinator: TaskViewControllerCoordinator, calculatorViewControllerCoordinator: CalculateViewControllerCoordinator, newsViewControllerCoordinator: NewsViewControllerCoordinator/*appCoordinator: AppCoordinator*/ ) {
//        self.window = window
//        self.navigationController = navigationController
//        self.taskViewControllerCoordinator = taskViewControllerCoordinator
//        self.calculatorViewControllerCoordinator = calculatorViewControllerCoordinator
//        self.newsViewControllerCoordinator = newsViewControllerCoordinator
//  }
//    
//    func start() {
//        
//    }
//    
//    func startTabBarViewControllerFlow() {
//        tabBarViewController = TabBarViewController()
//        guard let tabBarViewController else {
//            return
//        }
//        
//        let coordinatorsToAdd: [ChildCoordinating & Coordinating] = [taskViewControllerCoordinator, calculatorViewControllerCoordinator, newsViewControllerCoordinator]
//        
//        coordinatorsToAdd.forEach { addChildCoordinator($0) }
//        
//        coordinatorsToAdd.forEach { $0.start() }
//
//        tabBarViewController.setupTaskTab(with: taskViewControllerCoordinator.navigationController)
//        tabBarViewController.setupCalculatorTab(with: calculatorViewControllerCoordinator.navigationController)
//        tabBarViewController.setupNewsTab(with: newsViewControllerCoordinator.navigationController)
//        
//        tabBarViewController.setViewControllers([
//            taskViewControllerCoordinator.navigationController,
//            calculatorViewControllerCoordinator.navigationController,
//            newsViewControllerCoordinator.navigationController],
//            animated: false)
//        
//        window.rootViewController = tabBarViewController
//        window.makeKeyAndVisible()
//        
//    }
//}



import UIKit

final class TabBarControllerCoordinator: Coordinating, ChildCoordinating {
    
    var childCoordinators: [ChildCoordinating] = []
    let window: UIWindow
   // private var tabBarViewController: TabBarViewController?
    let navigationController: UINavigationController
    var taskViewControllerCoordinator: TaskViewControllerCoordinator
    var calculatorViewControllerCoordinator: CalculateViewControllerCoordinator
    var newsViewControllerCoordinator: NewsViewControllerCoordinator
    weak var appCoordinator: AppCoordinator?
    
    init(window: UIWindow, navigationController: UINavigationController, taskViewControllerCoordinator: TaskViewControllerCoordinator, calculatorViewControllerCoordinator: CalculateViewControllerCoordinator, newsViewControllerCoordinator: NewsViewControllerCoordinator/*appCoordinator: AppCoordinator*/ ) {
        self.window = window
        self.navigationController = navigationController
        self.taskViewControllerCoordinator = taskViewControllerCoordinator
        self.calculatorViewControllerCoordinator = calculatorViewControllerCoordinator
        self.newsViewControllerCoordinator = newsViewControllerCoordinator
    }
    
    func start() {
        // Логика инициализации координатора
    }
    
    func startTabBarViewControllerFlow() {
        let tabBarViewController = TabBarViewController()
//        guard let tabBarViewController else {
//            return
//        }
        
        let coordinatorsToAdd: [ChildCoordinating & Coordinating] = [taskViewControllerCoordinator, calculatorViewControllerCoordinator, newsViewControllerCoordinator]
        
        // Проверяем, существуют ли уже контроллеры в стеке навигации
        if navigationController.viewControllers.first(where: { $0 is TaskViewController }) == nil {
            taskViewControllerCoordinator.start()
            addChildCoordinator(taskViewControllerCoordinator)
        }
        
        if navigationController.viewControllers.first(where: { $0 is CalculationViewController }) == nil {
            calculatorViewControllerCoordinator.start()
            addChildCoordinator(calculatorViewControllerCoordinator)
        }
        
        if navigationController.viewControllers.first(where: { $0 is NewsTableViewController }) == nil {
            newsViewControllerCoordinator.start()
            addChildCoordinator(newsViewControllerCoordinator)
        }

        // Настройка вкладок
        tabBarViewController.setupTaskTab(with: taskViewControllerCoordinator.navigationController)
        tabBarViewController.setupCalculatorTab(with: calculatorViewControllerCoordinator.navigationController)
        tabBarViewController.setupNewsTab(with: newsViewControllerCoordinator.navigationController)
        
        // Устанавливаем view controllers для TabBar
        tabBarViewController.setViewControllers([
            taskViewControllerCoordinator.navigationController,
            calculatorViewControllerCoordinator.navigationController,
            newsViewControllerCoordinator.navigationController],
            animated: false)
        
        // Устанавливаем rootViewController
        window.rootViewController = tabBarViewController
        window.makeKeyAndVisible()
    }
}
