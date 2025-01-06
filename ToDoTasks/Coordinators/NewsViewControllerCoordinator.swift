//
//  NewsControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 30.05.2024.
//

import Foundation
import UIKit

final class NewsViewControllerCoordinator: Coordinating {
    var coordinators = [Coordinating]()
   // let networkManager: NetworkRequestPerforming
   // let imageFetcher: URLtoImageFetcherProtocol
    var navigationController: UINavigationController

    init(/*networkManager: NetworkRequestPerforming, imageFetcher: URLtoImageFetcherProtocol,*/ navigationController: UINavigationController) {
//        self.networkManager = networkManager
//        self.imageFetcher = imageFetcher
        self.navigationController = navigationController
    }

    func start() {
        let networkManager = DIContainer.shared.resolveNetworkRequestPerforming(endpoint: EndpointType.getForegroundData, retryPolicy: RetryPolicy.aggressive, session: SessionConfiguration.foregroundSession)
        
        let imageFetcher = DIContainer.shared.сontainer.resolve(URLtoImageFetcherProtocol.self)!

        let newsTableViewController = NewsTableViewController(networkManager: networkManager, imageFetcher: imageFetcher)
        
            navigationController.pushViewController(newsTableViewController, animated: true)
    }
}
