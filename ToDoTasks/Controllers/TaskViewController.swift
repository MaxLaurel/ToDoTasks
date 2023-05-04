


//
//  TaskViewController.swift
//  ToDoTasks
//
//  Created by Максим on 21.04.2023.
//

import UIKit
import Firebase

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    private lazy var taskTableView: UITableView = {
       var tableView = UITableView()
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
//    private var barButtonItem: UINavigationItem = {
//        var barButton = UIBarButt
//
//        return barButton
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self
        view.addSubview(taskTableView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        
    }
    @objc func leftBarButtonItemTapped() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
        //navigationController?.dismiss(animated: true, completion: nil)
    }
}
extension TaskViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
            }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
