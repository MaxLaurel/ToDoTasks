//
//  BaseCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation

class BaseCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    func start() {
        fatalError("Child should implement function")
    }
}
