//
//  Environment.swift
//  ToDoTasks
//
//  Created by Максим on 25.11.2024.
//

import Foundation



enum Environment: String {
    case debug = "debug"
    case release = "release"
    
    static var current: Environment {
        #if DEBUG
        return .debug
        #elseif RELEASE
        return .release
        #endif
    }
}
