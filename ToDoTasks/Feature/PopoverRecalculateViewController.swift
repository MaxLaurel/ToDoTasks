//
//  PopoverRcalculateViewController.swift
//  ToDoTasks
//
//  Created by Максим on 01.03.2024.
//


    import UIKit

    class PopoverRecalculateViewController: UIViewController, UIPopoverPresentationControllerDelegate {
        
        var onFinish: (() -> Void)?

        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return UIModalPresentationStyle.none
        }
  
        override func viewWillDisappear(_ animated: Bool) {
            if isMovingFromParent || isBeingDismissed { //когда вью уходит с экрана модально или удаляется из стека:
                onFinish?() //координатор загружает реализацию клоужера сюда в вьюконтроллер// был установлен метод где родительский координатор удаляет дочерний координатор их массива координаторов, таким образом убирается сильная ссылка на координатор
            }
        }
    }
