//
//  PopoverRcalculateViewController.swift
//  ToDoTasks
//
//  Created by Максим on 01.03.2024.
//


    import UIKit

    class PopoverRcalculateViewController: UIViewController, UIPopoverPresentationControllerDelegate {

        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return UIModalPresentationStyle.none
        }
        deinit {
                print("PopoverViewController was deallocated")
            }
    }
