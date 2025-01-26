//
//  RegisterViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 19.12.2024.
//

import Foundation
import UIKit

final class RegisterViewControllerCoordinator: NSObject, Coordinating, CoordinatingManager {
    
    var childCoordinators: [Coordinating] = []
   private var registerViewController: RegisterViewController?
    var navigationController: UINavigationController
    private let animationHandler: AnimationHandlerManagable
    private let window: UIWindow
    let tabBarControllerCoordinator: TabBarControllerCoordinator
    
    init(animationHandler: AnimationHandlerManagable, navigationController: UINavigationController, window: UIWindow, tabBarControllerCoordinator: TabBarControllerCoordinator) {
        self.navigationController = navigationController
        self.animationHandler = animationHandler
        self.window = window
        self.tabBarControllerCoordinator = tabBarControllerCoordinator
    }
    
    func start() {
        
    }
    
    func startRegisterViewControllerFlow() {
        if registerViewController == nil {
            registerViewController = RegisterViewController(animationHandler: animationHandler, registerCoordinator: self)
            navigationController.pushViewController(registerViewController!, animated: true)
        }
    }
    
    //MARK: этот метод не вызываем при переходе из registerViewController в TabBarController потому-что файрбэйз делает это сам при смене состояния пользователя, но этот метод может пригодиться когда я съеду с файрбейза
    func startTabBarControllerFlow() {
        
        window.rootViewController = tabBarControllerCoordinator.navigationController
        tabBarControllerCoordinator.start()
        addChildCoordinator(tabBarControllerCoordinator)
    }
    
    func navigateBackToLogin() {
        navigationController.popViewController(animated: true)
        registerViewController = nil
        removeChildCoordinator(self)
    }
}

//extension RegisterViewControllerCoordinator: UINavigationControllerDelegate {
//
//    //MARK: В этом расширении только один метод делегата navigationController который следит за переходами между контроллерами. Сначала достаем вьюконтроллер с которого уходим, потом если массив childCoordinators содержит этот контроллер, мы находим принадлежащий ему координатор, и методом childDidFinish удаляем этот координатор из массива childCoordinators
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        if let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(fromViewController) {
//            if let childCoordinator = childCoordinators.first(where: {
//                guard let registerViewController = $0 as? RegisterViewControllerCoordinator else { return false }
//                return registerViewController.registerViewController === fromViewController })
//            {
//                removeChildCoordinator(childCoordinator)
//                Log.info("Coordinator \(childCoordinator) has been removed")
//            }
//        }
//    }
//}


