//
//  Animations.swift
//  ToDoTasks
//
//  Created by Максим on 14.10.2024.
//
import UIKit

protocol AnimationHandlerManagable {
func showErrorWithAnimation(with errorText: String, and errorLabel: UILabel)
}

class AnimationHandler: AnimationHandlerManagable {
     func showErrorWithAnimation(with errorText: String, and errorLabel: UILabel) {
        errorLabel.text = errorText
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            errorLabel.alpha = 1.0
        } completion: { complete in
            errorLabel.alpha = 0.0
        }
    }
}
