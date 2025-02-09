//
//  D.swift
//  ToDoTasks
//
//  Created by Максим on 24.01.2025.
//
extension DIContainer {
    
    func registerAnimationHandler() {
        container.register(AnimationHandlerManagable.self) { _ in
            return AnimationHandler()
        }
    }
    
    func resolveAnimationHandler() -> AnimationHandlerManagable {
        guard let animationHandler = container.resolve(AnimationHandlerManagable.self) else {
            fatalError("Failed to resolve AnimationHandler")
        }
        return animationHandler
    }
}
