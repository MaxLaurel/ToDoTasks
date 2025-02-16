//
//  NavigationStackManager.swift
//  ToDoTasks
//
//  Created by Максим on 01.02.2025.
//

import UIKit

final class NavigationStackManager {
    
    static let shared = NavigationStackManager()
    
    private init() {}
    
    /// Получает все UINavigationController в приложении
    func getAllNavigationControllers() -> [UINavigationController] {
        guard let scenes = UIApplication.shared.connectedScenes as? Set<UIWindowScene> else {
            return []
        }
        
        var navControllers: [UINavigationController] = []
        
        for scene in scenes {
            for window in scene.windows {
                if let rootViewController = window.rootViewController {
                    navControllers.append(contentsOf: findNavigationControllers(in: rootViewController))
                }
            }
        }
        
        return navControllers
    }
    
    /// Рекурсивно ищет все UINavigationController в иерархии
    private func findNavigationControllers(in root: UIViewController) -> [UINavigationController] {
        var result: [UINavigationController] = []
        
        if let navController = root as? UINavigationController {
            result.append(navController)
        }
        
        if let tabBarController = root as? UITabBarController {
            for vc in tabBarController.viewControllers ?? [] {
                result.append(contentsOf: findNavigationControllers(in: vc))
            }
        }
        
        if let presentedVC = root.presentedViewController {
            result.append(contentsOf: findNavigationControllers(in: presentedVC))
        }
        
        return result
    }
    
    /// Выводит в лог все стеки UINavigationController
    func printAllNavigationStacks() {
        let allNavControllers = getAllNavigationControllers()
        
        for (index, navController) in allNavControllers.enumerated() {
            print("📌 NavigationController \(index):")
            for (vcIndex, vc) in navController.viewControllers.enumerated() {
                print("   - \(vcIndex): \(vc)")
            }
        }
    }
    
    /// Удаляет все экземпляры указанного UIViewController из стеков
    func removeViewController<T: UIViewController>(ofType type: T.Type) {
        for navController in getAllNavigationControllers() {
            navController.viewControllers.removeAll { $0 is T }
        }
    }
    
    func removeAllViewControllers() {
        for navController in getAllNavigationControllers() {
            navController.viewControllers.removeAll()  // Удаляем все контроллеры из стека
        }
    }
}
