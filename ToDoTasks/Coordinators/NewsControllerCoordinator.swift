//
//  NewsControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 30.05.2024.
//

import Foundation
import UIKit

class NewsControllerCoordinator: Coordinator {
    
    var coordinators = [Coordinator]()
    var navigationController = UINavigationController()
<<<<<<< HEAD
    let viewControllerFctory = ViewControllerFactory()
=======
    let viewControllerFactory = ViewControllerFactory()
>>>>>>> tik_2-NetworkSession
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
<<<<<<< HEAD
    func start() {
        let newsViewController = viewControllerFctory.createNewsViewController()
        newsViewController.newsViewControllerCoordinator = self
        navigationController.pushViewController(newsViewController, animated: true)
    }
    
  
=======
    func startInitialFlow() {
        let newsViewController = viewControllerFactory.instantiate(type: .newsVC)
        navigationController.pushViewController(newsViewController, animated: true)
  
    }
>>>>>>> tik_2-NetworkSession
}
