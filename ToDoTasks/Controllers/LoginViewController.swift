//
//  ViewController.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import Firebase


class LoginViewController: UIViewController, UITextFieldDelegate {
    print("made some code")
    private var mainLabel: UILabel = {
        var mainLabel = UILabel()
        mainLabel.text = "ToDoTask"
        mainLabel.font = UIFont(name: "Al Nile", size: 100)
        mainLabel.font = UIFont.boldSystemFont(ofSize: 60)
        mainLabel.textColor = .white
        return mainLabel
    }()
    
    private var errorLabel: UILabel = {
        var errorLabel = UILabel()
        errorLabel.text = "this user is not registered"
        errorLabel.alpha = 0
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.textColor = UIColor.red
        return errorLabel
    }()
    
    private var emailTextField: UITextField = {
        var emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.textColor = .black
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
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.init(name: "Al Nile", size: 20)
        passwordTextField.textAlignment = .center
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .default
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.returnKeyType = .done
        return passwordTextField
    }()
    
    private var loginButton: UIButton = {
        var loginButton = UIButton()
        loginButton.backgroundColor = .black
        loginButton.alpha = 0.3
        loginButton.layer.opacity = 0.5
        loginButton.setTitle(" log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 27)
        loginButton.setImage(UIImage(systemName: "arrow.forward.square"), for: .normal)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        loginButton.layer.shadowOpacity = 0.3
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.addTarget(self, action: #selector(LoginAction), for: .touchUpInside)
        return loginButton
    }()
    
    private var registerButton: UIButton = {
        var registerButton = UIButton()
        registerButton.setTitle(" Sign Up", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .light)
        registerButton.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus"), for: .normal)
        registerButton.tintColor = .white
        registerButton.backgroundColor = .clear
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
    private var forgotPasswordButton: UIButton = {
        var forgotPasswordButton = UIButton()
        //forgotPasswordButton.backgroundColor = .black
        //forgotPasswordButton.alpha = 0.3
        forgotPasswordButton.layer.opacity = 0.5
        forgotPasswordButton.setTitle("I forgot my password", for: .normal)
        forgotPasswordButton.setTitleColor(.white, for: .normal)
        //forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 20)
        forgotPasswordButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        //forgotPasswordButton.setImage(UIImage(systemName: "arrow.forward.square"), for: .normal)
        forgotPasswordButton.tintColor = .white
        //forgotPasswordButton.layer.cornerRadius = 5
        //forgotPasswordButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        //forgotPasswordButton.layer.shadowOpacity = 0.3
        //forgotPasswordButton.layer.shadowRadius = 5
        //forgotPasswordButton.layer.shadowColor = UIColor.black.cgColor
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
        return forgotPasswordButton
    }()
    
    private lazy var overlayView: UIView = {
        var overlayView = UIButton()
        overlayView.frame = view.bounds
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return overlayView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextFieldGestureRecognizer()
        GestureRecognizer()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = .systemBlue
        view.addSubview(mainLabel)
        view.addSubview(errorLabel)
        view.addSubview(stackView)
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(stackView2)
        
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(stackView3)
        
        view.addSubview(CommonStackView)
        
        constraints()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                let tableViewController = TaskViewController()
                self.navigationController?.pushViewController(tableViewController, animated: true)
            }
        }
    }//end wiewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
    
    //    func ShowAndHideKeyboardMetods() {
    //        NotificationCenter.default.addObserver(self, selector: #selector(didShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    //        NotificationCenter.default.addObserver(self, selector: #selector(didHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    //    }
    
    //    @objc func didShow(notification: Notification) {
    //           guard let userInfo = notification.userInfo else {return}
    //           let userFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue//это словарь значение которого имеет тип any, но any нам не нужен, поэтому кастим до NSValue. и далее чтобы получить само значение заключаем в скобки весь userinfo и превращаем его в cgRectValue. То есть на выходу константа userFrame должна иметь тип cgRectValue чтобы взять у этого прямогульника высоту
    //
    //        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + userFrame.height)
    //
    //       }
    
    //    @objc func didHide(){
    //        (self.view as! UIScrollView).contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)//здесь оставляем стандартную высоту скроллвью когда он клавиатура будет спрятана
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//you should add this metod and add textfields to resign first responder
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    private func nameTextFieldGestureRecognizer() {//force to close textfield when tap outside of it
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.outOfTextfield))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func outOfTextfield() {//objc metod for nameTextFieldGestureRecognizer
        view.endEditing(true)
    }
    private func GestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.outOfView))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func outOfView() {
        overlayView.removeFromSuperview()
        view.endEditing(true)
    }
    
    private func errorWithAnimation(text: String) {
        errorLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            //self.errorLabel.text = "Error occured"
            self.errorLabel.alpha = 1.0
        } completion: { complete in
            self.errorLabel.alpha = 0.0
        }
    }
    
    @objc func LoginAction() {
        guard let emailTextField = emailTextField.text, let password = passwordTextField.text, emailTextField != "", password != "" else {
            errorWithAnimation(text: "Password or login are empty!")
            return
        }
        
        Auth.auth().signIn(withEmail: emailTextField, password: password) { (user, error) in
            if user != nil {
                let tableViewController = TaskViewController()
                self.navigationController?.pushViewController(tableViewController, animated: true)
                return
            }
            
            if error != nil {
                self.errorWithAnimation(text: "Email or password wrong!")
                return
            }
            //self.errorWithAnimation(text: "There is no such user!")
        }
    }
    
    
    @objc func registerViewControllerAction() {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    @objc func forgotPasswordAction() {
        var customVC = ForgotPasswordViewController()
        customVC.loginViewController = self
        present(customVC, animated: true, completion: nil)
        
        UIView.animate(withDuration: 1.0) {
            self.view.alpha = 0.5
        }
    }
}
extension LoginViewController {
    private func constraints() {
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        // stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        //stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        //stackView2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        stackView2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        //stackView2.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30).isActive = true
        
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // stackView3.topAnchor.constraint(greaterThanOrEqualTo: stackView2.bottomAnchor, constant: 130).isActive = true
        //stackView3.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        stackView3.widthAnchor.constraint(equalToConstant: 200).isActive = true
        stackView3.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        CommonStackView.translatesAutoresizingMaskIntoConstraints = false
        CommonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        CommonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //stackView4.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        // stackView4.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //forgotPasswordButton.heightAnchor.constraint(equalToConstant: 170).isActive = true
        forgotPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
}


