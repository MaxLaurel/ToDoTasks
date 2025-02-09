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

protocol ChildCoordinating: AnyObject {
    var childCoordinators: [ChildCoordinating] { get set }
    func addChildCoordinator(_ child: ChildCoordinating)
    func removeChildCoordinator(_ child: ChildCoordinating)
    func removeAllChildCoordinators()
}

extension ChildCoordinating {
     func addChildCoordinator(_ child: ChildCoordinating) {
        childCoordinators.append(child)
        Log.info("Coordinator \(child) has been added. Coordinators include: \(childCoordinators)")
    }
    
    //MARK: в этом методе удаляем определенный дочерний координатор из массива childCoordinators
     func removeChildCoordinator(_ child: ChildCoordinating) {
        childCoordinators = childCoordinators.filter { $0 !== child }
        Log.info("Coordinator \(child) has been removed. Coordinators include: \(childCoordinators)")
    }
    
    //MARK: в этом методе удаляем всю цепочку дочерних координаторов
     func removeAllChildCoordinators() {
        childCoordinators.forEach { coordinator in
                coordinator.removeAllChildCoordinators() // Рекурсивное удаление
        }
        childCoordinators.removeAll()
        Log.info("All child coordinators removed from \(self). Current child coordinators: \(childCoordinators)")
    }
}
