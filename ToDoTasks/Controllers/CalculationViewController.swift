//
//  CalculationViewController.swift
//  ToDoTasks
//
//  Created by Максим on 09.03.2024.
//

import UIKit
import FirebaseAuth

class CalculationViewController: UIViewController {
    
    weak var calculateControllerCoordinator: CalculateViewControllerCoordinator?
    var onFinish: (() -> Void)?
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
        var leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        return leftBarButtonItem
    }()
    
    var calculatorImageView: UIImageView = {
        var calculatorImageView = UIImageView(image: UIImage(named: "calculator"))
        calculatorImageView.contentMode = .scaleAspectFit
        calculatorImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        calculatorImageView.widthAnchor.constraint(equalToConstant: 113).isActive = true
        return calculatorImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.titleView = calculatorImageView
        //navigationItem.prompt = "some prompt"
        //navigationItem.title = "Calculation"
        navigationItem.title = "Calculation"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    @objc func leftBarButtonItemTapped() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
    }
}
