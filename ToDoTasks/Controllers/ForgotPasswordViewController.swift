//
//  ForgotPasswordViewController.swift
//  ToDoTasks
//
//  Created by Максим on 16.05.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    var loginViewController = LoginViewController()
    
    var emailTextField: UITextField = {
        var nameTextField = UITextField()
        nameTextField.placeholder = "Put your email here"
        nameTextField.borderStyle = .roundedRect
        nameTextField.textColor = .black
        nameTextField.font = UIFont.init(name: "Al Nile", size: 20)
        nameTextField.textAlignment = .center
        // nameTextField.adjustsFontForContentSizeCategory = true
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.autocorrectionType = .no
        nameTextField.returnKeyType = .done
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.keyboardType = .emailAddress
        return nameTextField
    }()
    
    var restoreMyEmail: UIButton = {
        var restoreMyEmail = UIButton()
        restoreMyEmail.backgroundColor = .black
        restoreMyEmail.layer.opacity = 0.5
        restoreMyEmail.setTitle("Reset", for: .normal)
        restoreMyEmail.setTitleColor(.white, for: .normal)
        restoreMyEmail.titleLabel?.font = .systemFont(ofSize: 27)
        //restoreMyEmail.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        restoreMyEmail.tintColor = .white
        restoreMyEmail.layer.cornerRadius = 5
        restoreMyEmail.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        restoreMyEmail.layer.shadowOpacity = 0.3
        restoreMyEmail.layer.shadowRadius = 5
        restoreMyEmail.layer.shadowColor = UIColor.black.cgColor
        restoreMyEmail.addTarget(self, action: #selector(restoreEmailAction), for: .touchUpInside)
        return restoreMyEmail
    }()
    
    lazy var myView: UIView = {
        var myView = UIView()
        //myView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        myView.backgroundColor = UIColor.systemBlue
        myView.frame = CGRect(x: 25, y: 100, width: 325, height: 350)
        myView.layer.cornerRadius = 10
        return myView
    }()
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        //stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(restoreMyEmail)
       // stackView.addArrangedSubview(registerButton)
        stackView.axis = .vertical
        stackView.alignment = .fill
        //stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .clear
        view.addSubview(myView)
        view.addSubview(emailTextField)
        view.addSubview(restoreMyEmail)
        //view.addSubview(stackView)
        constraints()
        presentationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.5) {
            self.loginViewController.view.alpha = 1.0
        }
    }
    
    @objc func restoreEmailAction() {
        dismiss(animated: true) {
            self.view.alpha = 0.2
            let VC = LoginViewController()
            VC.view.backgroundColor = .white.withAlphaComponent(1.0)
        }
    }
}
extension ForgotPasswordViewController {
    func constraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: myView.topAnchor, constant: 30).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true

        restoreMyEmail.translatesAutoresizingMaskIntoConstraints = false
        restoreMyEmail.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 20).isActive = true
        restoreMyEmail.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -20).isActive = true
        restoreMyEmail.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -30).isActive = true
        restoreMyEmail.heightAnchor.constraint(equalToConstant: 20).isActive = true
        restoreMyEmail.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5).isActive = true
    }
}

extension ForgotPasswordViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("worked")
//        dismiss(animated: true) {
//            self.view.alpha = 1.0
//        }
//      
    }
}
