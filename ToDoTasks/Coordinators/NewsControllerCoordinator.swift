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
    //let viewControllerFactory = ViewControllerFactory()
    let container: DINetworkContainer
    
    init(navigationController: UINavigationController, container: DINetworkContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func startInitialFlow() {
        guard let networkManager = container.resolve(
            type: NetworkRequestPerforming.self,
            endpoint: EndpointType.getForegroundData,
            retryPolicy: RetryPolicy.aggressive,
            session: SessionConfiguration.foregroundSession)
        else {
            Log.error("NetworkManager не был создан")
            return
        }
            
        guard let imageFetcher = container.resolveImageFetcherDependency(
            type: URLtoImageFetcherProtocol.self)
        else {
            Log.error("imageFetcher не был создан")
            return
        }
        
        let newsViewController = NewsTableViewController(networkManager: networkManager, imageFetcher: imageFetcher)
            navigationController.pushViewController(newsViewController, animated: true)
    }
}
