//
//  ViewController.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let window: UIWindow
    weak var loginViewControllerCoordinator: LoginViewControllerCoordinator?//это делегат LoginViewControllerCoordinator для того чтобы дернуть его метод, и запустить координатор регистрации, который в свою очередь создаст RegisterViewController
    let animationHandler: AnimationHandler
    let container: DIContainer
    var onFinish: (() -> Void)?
    
    private var mainLabel: UILabel = {
        var mainLabel = UILabel()
        mainLabel.text = "ToDoTask"
        mainLabel.font = UIFont(name: "Al Nile", size: 100)
        mainLabel.font = UIFont.boldSystemFont(ofSize: 60)
        mainLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return mainLabel
    }()
    
    private var errorLabel: UILabel = {
        var errorLabel = UILabel()
        //errorLabel.text = "this user is not registered"
        errorLabel.alpha = 0
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return errorLabel
    }()
    
    private var emailTextField: UITextField = {
        var emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.font = UIFont.init(name: "Al Nile", size: 20)
        emailTextField.textAlignment = .center
        emailTextField.autocorrectionType = .no
        emailTextField.returnKeyType = .done
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.keyboardType = .emailAddress
        return emailTextField
    }()
    
    private var passwordTextField: UITextField = {
        var passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.font = UIFont.init(name: "Al Nile", size: 20)
        passwordTextField.textAlignment = .center
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .default
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.returnKeyType = .done
        return passwordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        var loginButton = UIButton()
        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        loginButton.alpha = 0.3
        loginButton.layer.opacity = 0.5
        loginButton.setTitle(" Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 25)
        loginButton.setImage(UIImage(systemName: "arrow.forward.square"), for: .normal)
        loginButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        loginButton.layer.shadowOpacity = 0.3
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.addTarget(self, action: #selector(LoginAction), for: .touchUpInside)
        return loginButton
    }()
    
    private lazy var registerButton: UIButton = {
        var registerButton = UIButton()
        registerButton.setTitle(" Sign Up", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .light)
        registerButton.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus"), for: .normal)
        registerButton.tintColor = .white
        registerButton.backgroundColor = .systemBlue
        registerButton.layer.cornerRadius = 5
        registerButton.addTarget(self, action: #selector(registerViewControllerAction), for: .touchUpInside)
        return registerButton
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(errorLabel)
        stackView.axis = .vertical
        stackView.alignment = .center
        //stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var stackView2: UIStackView = {
        var stackView2 = UIStackView()
        stackView2.addArrangedSubview(emailTextField)
        stackView2.addArrangedSubview(passwordTextField)
        stackView2.axis = .vertical
        stackView2.alignment = .fill
        //stackView2.distribution = .fillEqually
        stackView2.spacing = 5
        return stackView2
    }()
    
    private lazy var stackView3: UIStackView = {
        var stackView3 = UIStackView()
        stackView3.addArrangedSubview(loginButton)
        stackView3.addArrangedSubview(registerButton)
        stackView3.distribution = .fillEqually
        stackView3.spacing = 5
        stackView3.axis = .vertical
        //stackView3.alignment = .fill
        return stackView3
    }()
    
    private lazy var CommonStackView: UIStackView = {
        var stackView4 = UIStackView()
        stackView4.addArrangedSubview(stackView)
        stackView4.addArrangedSubview(stackView2)
        stackView4.addArrangedSubview(stackView3)
        stackView4.distribution = .equalSpacing
        stackView4.spacing = 30
        stackView4.axis = .vertical
        stackView4.alignment = .center
        return stackView4
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        var forgotPasswordButton = UIButton()
        //forgotPasswordButton.backgroundColor = .black
        //forgotPasswordButton.alpha = 0.3
        forgotPasswordButton.layer.opacity = 0.5
        forgotPasswordButton.setTitle("I forgot my password", for: .normal)
        forgotPasswordButton.setTitleColor(.white, for: .normal)
        //forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 20)
        forgotPasswordButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        //forgotPasswordButton.setImage(UIImage(systemName: "arrow.forward.square"), for: .normal)
        forgotPasswordButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //forgotPasswordButton.layer.cornerRadius = 5
        //forgotPasswordButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        //forgotPasswordButton.layer.shadowOpacity = 0.3
        //forgotPasswordButton.layer.shadowRadius = 5
        //forgotPasswordButton.layer.shadowColor = UIColor.black.cgColor
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
        return forgotPasswordButton
    }()
    
    init(animationHandler: AnimationHandler, window: UIWindow) {
        self.animationHandler = animationHandler
        self.container = DIContainer.shared
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        view.backgroundColor = .systemBlue
        addGestureRecognizer()
        addSubvies()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//you should add this method and add textfields to resign first responder
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    private func addGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.outOfView))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func outOfView() {
        view.endEditing(true)
    }
    
    @objc private func LoginAction() {
        guard let emailTextField = emailTextField.text, let password = passwordTextField.text, emailTextField != "", password != "" else {
            
            self.animationHandler.showErrorWithAnimation(with: "Email or password are empty!", and: self.errorLabel)
            return
        }
        
        Auth.auth().signIn(withEmail: emailTextField, password: password) { [weak self] (user, error) in
            guard let self = self else { return }
            
            if user != nil {
                guard let navigationController = self.navigationController else {return}
                let tabBarControllerCoordinator = container.resolveTabBarControllerCoordinator(window: window, navigationController: navigationController)
                tabBarControllerCoordinator.start()
                return
            }
            if let error = error {
                self.animationHandler.showErrorWithAnimation(with: "Email or password wrong!", and: self.errorLabel)
            }
        }
    }
    
    @objc private func registerViewControllerAction() {
        loginViewControllerCoordinator?.startRegisterViewControllerFlow()//вместо создания RegisterViewController напрямую или даже RegisterViewControllerСoordinatora, мы дергаем делегат loginViewControllerCoordinator, который создает RegisterViewControllerСoordinator сам
    }
    
    @objc private func forgotPasswordAction() {
        guard let emailTextfield = emailTextField.text, emailTextfield != "", emailTextfield.isValidated(validityType: .email) else {
            self.animationHandler.showErrorWithAnimation(with: "Your email could be wrong", and: self.errorLabel)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: emailTextfield) { error in
            if error == nil {
                self.animationHandler.showErrorWithAnimation(with: "Information to reset was sent to your email", and: self.errorLabel)
            }
        }
    }
    
    private func addSubvies() {
        [forgotPasswordButton, CommonStackView].forEach {view.addSubview($0)}
    }
}

extension LoginViewController {
    private func addConstraints() {
        
        translatesAutoresizingMaskIntoConstraintsToFalse()
        
        stackView2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        stackView3.widthAnchor.constraint(equalToConstant: 200).isActive = true
        stackView3.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        CommonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        CommonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgotPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
    
    private func translatesAutoresizingMaskIntoConstraintsToFalse() {
        [stackView, stackView2, stackView3, CommonStackView, forgotPasswordButton].forEach {$0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
}

extension LoginViewController {//это расширение для того чтобы можно было удалять координатор этого контроллера через родительский координатор
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent || isBeingDismissed { //когда вью уходит с экрана модально или удаляется из стека:
            onFinish?() //срабатывает клоужер в который при создании LoginViewController был установлен метод где родительский координатор удаляет дочерний координатор их массива координаторов, таким образом убирается сильная ссылка на координатор
        }
    }
}


