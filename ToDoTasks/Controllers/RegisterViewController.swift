//
//  RegisterViewController.swift
//  ToDoTasks
//
//  Created by Максим on 30.04.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private var animationHandler: AnimationHandlerManagable
    
    init(animationHandler: AnimationHandlerManagable) {
        self.animationHandler = animationHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var errorLabel: UILabel = {
        var errorLabel = UILabel()
        errorLabel.text = "this user is not registered"
        //errorLabel.contentMode = .center
        errorLabel.alpha = 0
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.textColor = UIColor.red
        return errorLabel
    }()
    
    private var emailTextField: UITextField = {
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
    
    private var passwordTextField: UITextField = {
        var passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.init(name: "Al Nile", size: 20)
        passwordTextField.textAlignment = .center
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .default
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.returnKeyType = .done
        return passwordTextField
    }()
    
    private var registerButton: UIButton = {
        var registerButton = UIButton()
        registerButton.backgroundColor = .black
        registerButton.layer.opacity = 0.5
        registerButton.setTitle(" Sign Up", for: .normal)
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
    
    private lazy var stackView: UIStackView = {
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
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        addSubViews()
        addGestureRecognizer()
        addConstraints()
    }
    
    private func addSubViews() {
        [stackView, errorLabel, registerButton].forEach { view.addSubview($0) }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//you should add this method and add textfields to resign first responder (Done will be working correctly)
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    private func addGestureRecognizer() {//while tap out of textfields
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.outOfView))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func outOfView() {
        view.endEditing(true)
    }
    
    @objc private func registerAction() {
        guard let mail = emailTextField.text, let password = passwordTextField.text, mail != "", password != "" else {
            animationHandler.showErrorWithAnimation(
                with: "Password or login are empty!",
                and: errorLabel)
            return
        }

        guard mail.isValidated(validityType: .email) else {
            animationHandler.showErrorWithAnimation(
                with: "Please enter a valid email address in the format example@example.com",
                and: errorLabel)
            return
        }
    
        guard password.isValidated(validityType: .password) else {
            animationHandler.showErrorWithAnimation(
                with: "The password must contain at least one letter, at least one number, and be between 6 and 25 characters long.",
                and: errorLabel)
            return
        }
        
        // Проверяем существует ли email
        Auth.auth().fetchSignInMethods(forEmail: mail) { (methods, error) in
            // Если методы входа существуют, значит email уже используется
            if let methods = methods {
                guard methods.isEmpty else {self.animationHandler.showErrorWithAnimation(with: "Email is already registered", and: self.errorLabel)
                    return
                }
            }
        }
        Auth.auth().createUser(withEmail: mail, password: password)
    }
    deinit {
            print("RegisterViewController was deallocated")
        }
}

extension RegisterViewController {
    private func addConstraints() {

        addTranslateAutoresizingMaskIntoConstraintsFalse()
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        errorLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func addTranslateAutoresizingMaskIntoConstraintsFalse() {
        [stackView, registerButton, errorLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
