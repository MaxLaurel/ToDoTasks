import UIKit

class TESTViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Создаем два представления
            let redView = UIView()
            redView.backgroundColor = .red
            view.addSubview(redView)
            
            let blueView = UIView()
            blueView.backgroundColor = .blue
            view.addSubview(blueView)
            
            // Ограничения для redView
            redView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
                redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                redView.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            // Ограничения для blueView
            blueView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                blueView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                blueView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
