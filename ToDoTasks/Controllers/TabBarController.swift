<<<<<<< HEAD
//
//  TaskTabBarController.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

=======
>>>>>>> tik_2-NetworkSession
import UIKit
import Firebase

class TabBarController: UITabBarController {
<<<<<<< HEAD
    
    lazy var taskBarButtonItem: UITabBarItem = {
        var taskBarButtonItem = UITabBarItem(title: "tasks", image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), tag: 0)
        return taskBarButtonItem
    }()
    
    lazy var calculateBarButtonItem: UITabBarItem = {
        var calculateBarButtonItem = UITabBarItem(title: "calculate", image: UIImage(systemName: "arrow.forward.square"), tag: 1)
        return calculateBarButtonItem
    }()
    
    var newsBarButtonItem: UITabBarItem = {
        var newsBarButtonItem = UITabBarItem(title: "news", image: UIImage(systemName: "newspaper.circle"), tag: 2)
        return newsBarButtonItem
    }()

    weak var tabBarControllerCoordinator: TabBarControllerCoordinator?
    
//    navigationController.navigationBar.barTintColor = .blue
//    navigationController.navigationBar.tintColor = .white
//                navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
//            navigationController.navigationBar.topItem?.backBarButtonItem = backButton
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskNavigationControllerCoordinator = TaskViewControllerCoordinator(navigationController: UINavigationController())
        taskNavigationControllerCoordinator.start()
        
        let calculateViewControllerCoordinator = CalculateControllerCoordinator(navigationController: UINavigationController())
        calculateViewControllerCoordinator.start()
        
        let newsViewControllerCoordinator = NewsControllerCoordinator(navigationController: UINavigationController())
        newsViewControllerCoordinator.start()
        
        self.viewControllers = [taskNavigationControllerCoordinator.navigationController, calculateViewControllerCoordinator.navigationController, newsViewControllerCoordinator.navigationController]
        self.selectedViewController = taskNavigationControllerCoordinator.navigationController
        
        taskNavigationControllerCoordinator.navigationController.tabBarItem = taskBarButtonItem
        calculateViewControllerCoordinator.navigationController.tabBarItem = calculateBarButtonItem
        newsViewControllerCoordinator.navigationController.tabBarItem = newsBarButtonItem
        
        self.tabBar.tintColor = UIColor(red: 0.7, green: 0.5, blue: 0.5, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor(red: 0.5, green: 0.7, blue: 0.5, alpha: 1)
        //        taskNavController.tabBarItem.badgeValue = "\(tableViewController.arrayOfTasks.count)"
        //        taskNavController.tabBarItem.badgeColor = .systemGreen
        
        //           loginTabBarController.tabBarItem = UITabBarItem.init(title: "log In", image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), tag: 1)
        
        
        //нужно подумать почему некорректно отображается
        
    }
=======

    
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
>>>>>>> tik_2-NetworkSession
}
