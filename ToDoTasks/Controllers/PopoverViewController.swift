//
//  PopoverViewController.swift
//  ToDoTasks
//
//  Created by Максим on 18.02.2024.
//

import UIKit

class PopoverViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
