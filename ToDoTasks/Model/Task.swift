//
//  Task.swift
//  ToDoTasks
//
//  Created by Максим on 21.01.2024.
//

import Foundation
import Firebase

class Task {
    var taskName: String
    var description: String
    var taskID: String?
    var isCompleted: Bool  // Добавлено свойство isCompleted

    init(taskName: String, description: String, taskID: String, isCompleted: Bool = false) {
        self.taskName = taskName
        self.description = description
        self.taskID = taskID
        self.isCompleted = isCompleted
    }
}
