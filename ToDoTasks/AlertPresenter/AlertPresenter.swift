//
//  AlertPresenter.swift
//  ToDoTasks
//
//  Created by Максим on 06.10.2024.
//

import UIKit

protocol AlertPresenter {
    func showAlert(_ title: String, message: String)
}

private class ErrorAlertPresenter: AlertPresenter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showAlert(_ title: String = "Network Error", message: String = "An unexpected network error occurred. Please try again") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        viewController?.present(alert, animated: true)
    }
}
