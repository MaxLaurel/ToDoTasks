//
//  ViewController.swift
//  переходы между контроллерами
//
//  Created by Максим on 22.09.2022.
//

import UIKit
protocol FirstVCDelegate: AnyObject {
    func update(clientText: String)
}

class ViewController: UIViewController {
    
    var secondVCButton = UIButton(frame: CGRect(x: 150, y: 600, width: 140, height: 40))
    var textField = UITextField(frame: CGRect(x: 140, y: 300, width: 150, height: 35))
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondVCButton.setTitle("for second VC", for: .normal)
        secondVCButton.setTitleColor(.black, for:  .normal)
        secondVCButton.backgroundColor = .systemGray2
        secondVCButton.addTarget(self, action: #selector(goToSecondVC), for: .touchUpInside)
        view.addSubview(secondVCButton)
        
        textField.placeholder = "your text"
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.layer.borderWidth = 1
        view.addSubview(textField)
        
        label.text = "hello"
        view.addSubview(label)
    } //закончился ViewDidLoad
    
    @objc func goToSecondVC(sender: UIButton) {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let firstVC = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
        firstVC.labelForFirstVC = textField.text!
        firstVC.delegate = self
        navigationController?.pushViewController(firstVC, animated: true)
    
    }

}//закончился Class

extension ViewController: FirstVCDelegate {
    func update(clientText: String) {
        label.text = clientText
    }
    
    
    
}
