//
//  ViewController.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    var mainLabel: UILabel = {
        var mainLabel = UILabel()
        mainLabel.text = "ToDoTask"
        mainLabel.font = UIFont(name: "Al Nile", size: 100)
        mainLabel.font = UIFont.boldSystemFont(ofSize: 60)
        mainLabel.textColor = .white
        return mainLabel
    }()
    
    var errorLabel: UILabel = {
        var errorLabel = UILabel()
        errorLabel.text = "this user is not registered"
        errorLabel.alpha = 0
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.textColor = UIColor.red
        return errorLabel
    }()
    
    var nameTextField: UITextField = {
        var nameTextField = UITextField()
        nameTextField.placeholder = "Email"
        nameTextField.borderStyle = .roundedRect
        nameTextField.textColor = .black
        nameTextField.font = UIFont.init(name: "Al Nile", size: 20)
        nameTextField.textAlignment = .center
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
        passwordTextField.returnKeyType = .done
        return passwordTextField
    }()
    
    var loginButton: UIButton = {
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
    
    var registerButton: UIButton = {
        var registerButton = UIButton()
        registerButton.setTitle(" Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 27, weight: .light)
        registerButton.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus"), for: .normal)
        registerButton.tintColor = .white
        registerButton.backgroundColor = .clear
        registerButton.layer.cornerRadius = 5
        registerButton.addTarget(self, action: #selector(goToRegisterViewController), for: .touchUpInside)
        return registerButton
    }()
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(errorLabel)
        stackView.axis = .vertical
        stackView.alignment = .center
        //stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var stackView2: UIStackView = {
        var stackView2 = UIStackView()
        stackView2.addArrangedSubview(nameTextField)
        stackView2.addArrangedSubview(passwordTextField)
        stackView2.axis = .vertical
        stackView2.alignment = .fill
        //stackView2.distribution = .fillEqually
        stackView2.spacing = 5
        return stackView2
    }()
    
    lazy var stackView3: UIStackView = {
        var stackView3 = UIStackView()
        stackView3.addArrangedSubview(loginButton)
        stackView3.addArrangedSubview(registerButton)
        stackView3.distribution = .fillEqually
        stackView3.spacing = 10
        stackView3.axis = .vertical
        //stackView3.alignment = .fill
        return stackView3
    }()
    
    lazy var CommonStackView: UIStackView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextFieldGestureRecognizer()
        nameTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = .systemBlue
        view.addSubview(mainLabel)
        view.addSubview(errorLabel)
        view.addSubview(stackView)
        
        view.addSubview(nameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(stackView2)
        
        view.addSubview(loginButton)
        view.addSubview(registerButton)
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
        nameTextField.text = nil
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
        nameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func nameTextFieldGestureRecognizer() {//force to close textfield when tap outside of it
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.outOfTextfield))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func outOfTextfield() {//objc metod for nameTextFieldGestureRecognizer
        view.endEditing(true)
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
    
    @objc func LoginAction() {
        guard let name = nameTextField.text, let password = passwordTextField.text, name != "", password != "" else {
            errorWithAnimation(text: "Password or login are empty!")
            return
        }
        Auth.auth().signIn(withEmail: name, password: password) { (user, error) in
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
    
    @objc func goToRegisterViewController() {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension LoginViewController {
    func constraints() {
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
    }
}


