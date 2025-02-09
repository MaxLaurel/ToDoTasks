//
//  ServiceProvider.swift
//  ToDoTasks
//
//  Created by Максим on 09.11.2024.
//

import Foundation
import UIKit
import Swinject

final class DIContainer {
    static var shared = DIContainer()
    let container = Container()
    
    private init() {
        registerNetworkManagerDependancies()
        registerImageFetcher()
        registerAnimationHandler()
        registerCoordinators()
    }
}
