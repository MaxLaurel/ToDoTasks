//
//  CustomTableViewCell.swift
//  ToDoTasks
//
//  Created by Максим on 06.02.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    var taskTitleLabel: UILabel = {
        var taskTitle = UILabel()
        return taskTitle
    }()
    
    var descriptionTaskLabel: UILabel = {
        var descriptionTaskLabel = UILabel()
        return descriptionTaskLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
         setSubviev()
         configureConstraints()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        taskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        taskTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        taskTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        taskTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100).isActive = true
        
        descriptionTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTaskLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTaskLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        descriptionTaskLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100).isActive = true
        descriptionTaskLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    func setSubviev() {
        addSubview(taskTitleLabel)
        addSubview(descriptionTaskLabel)
    }
}
