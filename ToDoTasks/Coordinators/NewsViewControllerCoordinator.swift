//
//  NewsControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 30.05.2024.
//

import Foundation
import UIKit

final class NewsViewControllerCoordinator: Coordinating, ChildCoordinating {
    var childCoordinators = [ChildCoordinating]()
    let networkManager: NetworkRequestPerforming
    let imageFetcher: URLtoImageFetcherProtocol
    var navigationController: UINavigationController
    let container: DIContainer

    init(navigationController: UINavigationController, imageFetcher: URLtoImageFetcherProtocol, networkManager: NetworkRequestPerforming) {
        self.container = DIContainer.shared
        self.networkManager = networkManager
        self.imageFetcher = imageFetcher
        self.navigationController = navigationController
    }

    func start() {
        let newsTableViewController = NewsTableViewController(networkManager: networkManager, imageFetcher: imageFetcher)
            navigationController.pushViewController(newsTableViewController, animated: true)
    }
}
