import UIKit
import Firebase

class TabBarController: UITabBarController {

    
    private var taskBarButtonItem: UITabBarItem? = {
        UITabBarItem(title: "tasks", image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), tag: 0)
    }()
    
    private var calculateBarButtonItem: UITabBarItem? = {
        UITabBarItem(title: "calculate", image: UIImage(systemName: "arrow.forward.square"), tag: 1)
    }()
    
    private var newsBarButtonItem: UITabBarItem? = {
        UITabBarItem(title: "news", image: UIImage(systemName: "newspaper.circle"), tag: 2)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        let taskNavigationController = UINavigationController()
        let taskViewControllerCoordinator = TaskViewControllerCoordinator(navigationController: taskNavigationController)
        taskViewControllerCoordinator.startInitialFlow()

        let calculateNavigationController = UINavigationController()
        let calculateViewControllerCoordinator = CalculateControllerCoordinator(navigationController: calculateNavigationController)
        calculateViewControllerCoordinator.startInitialFlow()

        let newsNavigationController = UINavigationController()
        let newsViewControllerCoordinator = NewsControllerCoordinator(navigationController: newsNavigationController)
        newsViewControllerCoordinator.startInitialFlow()

        self.viewControllers = [taskNavigationController, calculateNavigationController, newsNavigationController]
        self.selectedViewController = taskNavigationController

        taskNavigationController.tabBarItem = taskBarButtonItem
        calculateNavigationController.tabBarItem = calculateBarButtonItem
        newsNavigationController.tabBarItem = newsBarButtonItem
        
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = UIColor(red: 0.7, green: 0.5, blue: 0.5, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor(red: 0.5, green: 0.7, blue: 0.5, alpha: 1)
    }
    deinit {
            print("TabBarController was deallocated")
        }
}
