//
//  Task.swift
//  ToDoTasks
//
//  Created by Максим on 21.01.2024.
//

import Foundation
import Firebase

struct Task {
    var taskName: String
    var description: String
    var taskID: String?
    var isCompleted = false
    
    init(taskName: String, description: String, taskID: String?) {
        self.taskName = taskName
        self.description = description
        self.taskID = taskID
    }
}
