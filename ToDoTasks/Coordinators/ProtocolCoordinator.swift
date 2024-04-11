//
//  ProtocolCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var coordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        coordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        coordinators = coordinators.filter { $0 !== coordinator} 
    }
}
