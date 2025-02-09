<<<<<<< HEAD
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
=======
0000000000000000000000000000000000000000 c7a080b16fff67eda95d10be6a5548583721e468 MaxLaurel <Max.laurel.developer@gmail.com> 1727530512 +0300	branch: Created from Develop
c7a080b16fff67eda95d10be6a5548583721e468 5cbd4a793041344a7bf932324e76e11cba0b71f8 MaxLaurel <Max.laurel.developer@gmail.com> 1727807123 +0300	commit: have done some work with errors and optionals and made endpointsPath
5cbd4a793041344a7bf932324e76e11cba0b71f8 c3a803867e7f9e24e43b4235265058f3c74b1c9f MaxLaurel <Max.laurel.developer@gmail.com> 1728164903 +0300	commit: create handleHTTPResponse and handleNetworkError methods and logics
c3a803867e7f9e24e43b4235265058f3c74b1c9f 4e9c5a440c39206d04bf049fd35cabdb21691653 MaxLaurel <Max.laurel.developer@gmail.com> 1728503927 +0300	commit: worked with retry logic
4e9c5a440c39206d04bf049fd35cabdb21691653 90d52450c938457ad12231eb4999a3b002d93f07 MaxLaurel <Max.laurel.developer@gmail.com> 1728703559 +0300	commit: deleted factortCoordinator
90d52450c938457ad12231eb4999a3b002d93f07 a1c4c6c1d736840bc7b227895c3d0e688f4c6367 MaxLaurel <Max.laurel.developer@gmail.com> 1729003887 +0300	commit: some refactoring(DI, incapsulation)
a1c4c6c1d736840bc7b227895c3d0e688f4c6367 a2c2a9251ec0fd3b4faa764b313317ada802c6fd MaxLaurel <Max.laurel.developer@gmail.com> 1729004819 +0300	commit: no message
a2c2a9251ec0fd3b4faa764b313317ada802c6fd 9e73185b1556542ee1af8a172845153fb6c711ae MaxLaurel <Max.laurel.developer@gmail.com> 1729963395 +0300	commit: made backgroundSession with delegates
>>>>>>> tik_2-NetworkSession
