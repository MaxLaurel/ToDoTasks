//
//  LoginViewControllerCoordinator.swift
//  ToDoTasks
//
//  Created by Максим on 16.03.2024.
//

import Foundation
import UIKit

final class LoginViewControllerCoordinator: NSObject, CoordinatingManager {
    
    var childCoordinators: [Coordinating] = []
   private let window: UIWindow
     var navigationController: UINavigationController
    private var loginViewController: LoginViewController?
    private let animationHandler: AnimationHandler
    //let registerViewControllerCoordinator: RegisterViewControllerCoordinator
    private let container: DIContainer

    init(window: UIWindow, /*navigationController: UINavigationController,*/ animationHandler: AnimationHandler/*, registerViewControllerCoordinator: RegisterViewControllerCoordinator*/) {
        self.window = window
        self.navigationController = UINavigationController()
        self.animationHandler = animationHandler
       // self.registerViewControllerCoordinator = registerViewControllerCoordinator
        self.container = DIContainer.shared
        super.init()
        //navigationController.delegate = self
    }
    
    func start() {
        
    }
    
    func startLoginViewControllerFlow() {
        // Проверяем, если loginViewController уже создан
        if loginViewController == nil {
            // Инициализируем новый экземпляр и сохраняем его в свойстве класса
            loginViewController = LoginViewController(animationHandler: animationHandler, window: window, container: container)
            loginViewController?.loginViewControllerCoordinator = self
            navigationController.pushViewController(loginViewController!, animated: true)
            // Устанавливаем LoginViewController в стек навигации
            navigationController.setViewControllers([loginViewController!], animated: true)
        }
        
    }
    
    func startRegisterViewControllerFlow() {
        let registerViewControllerCoordinator = RegisterViewControllerCoordinator(animationHandler: animationHandler, navigationController: self.navigationController, window: window)
        registerViewControllerCoordinator.startRegisterViewControllerFlow()
        addChildCoordinator(registerViewControllerCoordinator)
        }
}

//extension LoginViewControllerCoordinator: UINavigationControllerDelegate {
//    
//    //MARK: В этом расширении только один метод делегата navigationController который следит за переходами между контроллерами. Сначала достаем вьюконтроллер с которого уходим, потом если массив childCoordinators содержит этот контроллер, мы находим принадлежащий ему координатор, и методом childDidFinish удаляем этот координатор из массива childCoordinators
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        if let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(fromViewController) {
//            if let childCoordinator = childCoordinators.first(where: {
//                guard let loginCoordinator = $0 as? LoginViewControllerCoordinator else { return false }
//                return loginCoordinator.loginViewController === fromViewController })
//            {
//                removeChildCoordinator(childCoordinator)
//                Log.info("Coordinator \(childCoordinator) has been removed")
//            }
//        }
//    }
//}
