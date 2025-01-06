import UIKit

final class TabBarControllerCoordinator: Coordinating {
   
    private let window: UIWindow
    private var tabBarController: TabBarViewController?
    let navigationController: UINavigationController
    let taskViewControllerCoordinator: TaskViewControllerCoordinator
    let calculatorViewControllerCoordinator: CalculateViewControllerCoordinator
    let newsViewControllerCoordinator: NewsViewControllerCoordinator
    
    
    init(window: UIWindow, navigationController: UINavigationController, taskViewControllerCoordinator: TaskViewControllerCoordinator, calculatorViewControllerCoordinator: CalculateViewControllerCoordinator, newsViewControllerCoordinator: NewsViewControllerCoordinator) {
        self.window = window
        self.navigationController = navigationController
        self.taskViewControllerCoordinator = taskViewControllerCoordinator
        self.calculatorViewControllerCoordinator = calculatorViewControllerCoordinator
        self.newsViewControllerCoordinator = newsViewControllerCoordinator
    }
    
    func start() {
        
    }
    
    func startTabBarViewControllerFlow() {
        let tabBarVC = TabBarViewController()
        tabBarController = tabBarVC
        
        let taskNavController = UINavigationController()
        let calculateNavController = UINavigationController()
        let newsNavController = UINavigationController()
        
        let taskCoordinator = TaskViewControllerCoordinator(navigationController: taskNavController)
        let calculateCoordinator = CalculateViewControllerCoordinator(navigationController: calculateNavController)
        let newsCoordinator = NewsViewControllerCoordinator(navigationController: newsNavController)
        
        taskCoordinator.start()
        calculateCoordinator.start()
        newsCoordinator.start()
        
        tabBarVC.setupTaskTab(with: taskNavController)
        tabBarVC.setupCalculatorTab(with: calculateNavController)
        tabBarVC.setupNewsTab(with: newsNavController)
        
        tabBarVC.setViewControllers([taskNavController, calculateNavController, newsNavController], animated: false)
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
    }
}
