//
//  CalculationViewController.swift
//  ToDoTasks
//
//  Created by Максим on 09.03.2024.
//

import UIKit
import Firebase

class CalculationViewController: UIViewController {
    
    weak var calculateControllerCoordinator: CalculateControllerCoordinator?
    
    var navController = UINavigationController()
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
        var leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        return leftBarButtonItem
    }()
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        var rightBarButtonItem = UIBarButtonItem(title: "info", style: .plain, target: self, action: #selector(goToNext))
        return rightBarButtonItem
    }()
    
    
    var calculatorImageView: UIImageView = {
        var calculatorImageView = UIImageView(image: UIImage(named: "calculator"))
        calculatorImageView.contentMode = .scaleAspectFit
        calculatorImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        calculatorImageView.widthAnchor.constraint(equalToConstant: 113).isActive = true
        return calculatorImageView
    }()
    
    lazy var nextFlowButton: UIButton = {
        var nextFlowButton = UIButton()
        nextFlowButton.setTitle("AnotherFlow", for: .normal)
        nextFlowButton.setTitleColor(.green, for: .normal)
        nextFlowButton.backgroundColor = .gray
        nextFlowButton.titleLabel?.font = .systemFont(ofSize: 25)
        nextFlowButton.tintColor = .blue
        nextFlowButton.addTarget(self, action: #selector(goToNext), for: .touchUpInside)
        return nextFlowButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.titleView = calculatorImageView
        //navigationItem.prompt = "some prompt"
        //navigationItem.title = "Calculation"
        navigationItem.title = "Calculation"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.addSubview(nextFlowButton)
        
        nextFlowButton.translatesAutoresizingMaskIntoConstraints = false
        nextFlowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextFlowButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nextFlowButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nextFlowButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    @objc func leftBarButtonItemTapped() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    //    @objc func rightBarButtonItemTapped() {
    //        let vc = InfoViewController()
    //        vc.view?.backgroundColor = .white
    //        navigationController?.pushViewController(vc, animated: true)
    //    }
    
    @objc func goToNext() {
//        let secondFlowCalculatorCoordunator = FlowCalculationCoordinator(navigationController: navController)
//        secondFlowCalculatorCoordunator.startCalculationFlow()
                let newsViewController = YouTubeNewsTableViewController()
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    
}
