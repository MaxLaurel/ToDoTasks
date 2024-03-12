//
//  PopoverViewController.swift
//  ToDoTasks
//
//  Created by Максим on 18.02.2024.
//

import UIKit

class PopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }

}
extension PopoverViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
