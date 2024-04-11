//
//  TaskTabBarController.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    
    lazy var taskBarButtonItem: UITabBarItem = {
        var taskBarButtonItem = UITabBarItem(title: "tasks", image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), tag: 0)
        return taskBarButtonItem
    }()
    
    lazy var calculateBarButtonItem: UITabBarItem = {
       var calculateBarButtonItem = UITabBarItem(title: "calculate", image: UIImage.init(systemName: "arrow.forward.square"), tag: 2)
        return calculateBarButtonItem
    }()
    
    let tableViewController = TaskViewController()
    let calculateViewController = CalculationViewController()
    
    weak var taskTabBarControllerCoordinator: TabBarControllerCoordinator?
    
    //navigationController.navigationBar.barTintColor = .blue
    //navigationController.navigationBar.tintColor = .white
//            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//    let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
//        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
//    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskNavController = UINavigationController(rootViewController: tableViewController)

        let calculateNavBarController = UINavigationController(rootViewController: calculateViewController)
        
        self.viewControllers = [taskNavController, calculateNavBarController]
        self.selectedViewController = taskNavController
        
        taskNavController.tabBarItem = taskBarButtonItem
        calculateNavBarController.tabBarItem = calculateBarButtonItem
        
        self.tabBar.tintColor = UIColor(red: 0.7, green: 0.5, blue: 0.5, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor(red: 0.5, green: 0.7, blue: 0.5, alpha: 1)
//        taskNavController.tabBarItem.badgeValue = "\(tableViewController.arrayOfTasks.count)"
//        taskNavController.tabBarItem.badgeColor = .systemGreen

//           loginTabBarController.tabBarItem = UITabBarItem.init(title: "log In", image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), tag: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Скрываем Navigation Bar
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//        navigationController?.setToolbarHidden(false, animated: true)
    }
    
//    @objc func leftBarButtonItemTapped() {
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print(error.localizedDescription)
//        }
//        navigationController?.popToRootViewController(animated: true)
//        
//    }
}
