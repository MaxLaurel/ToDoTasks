//
//  vcViewController.swift
//  ToDoTasks
//
//  Created by Максим on 23.03.2024.
//

import UIKit

class InfoViewController: UIViewController {
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        var rightBarButtonItem = UIBarButtonItem(title: "info2", style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        return rightBarButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Info1"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func rightBarButtonItemTapped() {
        let vc = InfoViewController2()
        vc.view?.backgroundColor = .white
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
}
