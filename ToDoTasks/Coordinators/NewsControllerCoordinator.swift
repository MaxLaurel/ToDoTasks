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
    let viewControllerFctory = ViewControllerFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let newsViewController = viewControllerFctory.createNewsViewController()
        newsViewController.newsViewControllerCoordinator = self
        navigationController.pushViewController(newsViewController, animated: true)
    }
    
  
}
