//
//  Task.swift
//  ToDoTasks
//
//  Created by Максим on 21.01.2024.

import Foundation
import Firebase

class TaskModel {
    var taskName: String
    var description: String
    var taskID: String?
    var isCompleted: Bool
    
     init(taskName: String, description: String, taskID: String, isCompleted: Bool = false) {
        self.taskName = taskName
        self.description = description
        self.taskID = taskID
        self.isCompleted = isCompleted
    }
}
