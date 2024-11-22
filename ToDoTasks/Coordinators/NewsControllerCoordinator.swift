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
    let viewControllerFactory = ViewControllerFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startInitialFlow() {
        let newsViewController = viewControllerFactory.instantiate(type: .newsVC)
        navigationController.pushViewController(newsViewController, animated: true)
  
    }
}
