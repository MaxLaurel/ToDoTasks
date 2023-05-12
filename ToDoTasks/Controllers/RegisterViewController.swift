//
//  RegisterViewController.swift
//  ToDoTasks
//
//  Created by Максим on 30.04.2023.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    var errorLabel: UILabel = {
        var errorLabel = UILabel()
        errorLabel.text = "this user is not registered"
        //errorLabel.contentMode = .center
        errorLabel.alpha = 0
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.textColor = UIColor.red
        return errorLabel
    }()
    
    var emailTextField: UITextField = {
        var nameTextField = UITextField()
        nameTextField.placeholder = "Email"
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
    
    var passwordTextField: UITextField = {
        var passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.init(name: "Al Nile", size: 20)
        passwordTextField.textAlignment = .center
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .default
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.returnKeyType = .send
        return passwordTextField
    }()
    
    var registerButton: UIButton = {
        var registerButton = UIButton()
        registerButton.backgroundColor = .black
        registerButton.layer.opacity = 0.5
        registerButton.setTitle(" register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 27)
        registerButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        registerButton.tintColor = .white
        registerButton.layer.cornerRadius = 5
        registerButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        registerButton.layer.shadowOpacity = 0.3
        registerButton.layer.shadowRadius = 5
        registerButton.layer.shadowColor = UIColor.black.cgColor
        registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return registerButton
    }()
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        //stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
       // stackView.addArrangedSubview(registerButton)
        stackView.axis = .vertical
        stackView.alignment = .fill
        //stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(errorLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(stackView)
        constraints()
    }
    
    func errorWithAnimation(text: String) {
        errorLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            //self.errorLabel.text = "Error occured"
            self.errorLabel.alpha = 1.0
        } completion: { complete in
            self.errorLabel.alpha = 0.0
        }
    }
    @objc func registerAction() {
        guard let mail = emailTextField.text, let password = passwordTextField.text, mail != "", password != "" else {
            errorWithAnimation(text: "Password or login are empty!")
            return
        }
        
        guard mail.isValidated(validityType: .email), password.isValidated(validityType: .password) else { errorWithAnimation(text: "validation failed!")
            return }
        
        Auth.auth().createUser(withEmail: mail, password: password) { (user, error) in
            if user != nil {
                let tableViewController = TaskViewController()
                self.navigationController?.pushViewController(tableViewController, animated: true)
            }
            
            if error != nil {
                self.errorWithAnimation(text: "Some error occured!")
                return
            }
        }
    }
}
extension RegisterViewController {
    func constraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        //errorLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
