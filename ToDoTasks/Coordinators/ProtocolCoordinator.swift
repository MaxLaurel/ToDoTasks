//
//  ProtocolCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation

protocol Coordinating: AnyObject  {
    func start()
}

protocol CoordinatingManager: Coordinating {
    var childCoordinators: [Coordinating] { get set }
    func addChildCoordinator(_ child: Coordinating)
    func removeChildCoordinator(_ child: Coordinating?)
    func removeAllChildCoordinators()
    func start()
}

extension CoordinatingManager {
    func addChildCoordinator(_ child: Coordinating) {
        childCoordinators.append(child)
        Log.info("Coordinator \(child) has been added. Coordinators include: \(child)")
    }
    
    //MARK: в этом методе удаляем определенный дочерний координатор из массива childCoordinators
    func removeChildCoordinator(_ child: Coordinating?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
        Log.info("Coordinator \(child) has been removed. Coordinators include: \(child)")
    }
    
    //MARK: в этом методе удаляем всю цепочку дочерних координаторов
    func removeAllChildCoordinators() {
        childCoordinators.forEach { coordinator in
            if let manager = coordinator as? CoordinatingManager {
                manager.removeAllChildCoordinators() // Рекурсивное удаление
            }
        }
        childCoordinators.removeAll()
        Log.info("All child coordinators removed from \(self). Current child coordinators: \(childCoordinators)")
    }
}
