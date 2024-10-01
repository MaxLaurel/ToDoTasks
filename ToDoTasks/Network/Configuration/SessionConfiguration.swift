//
//  SessionConfiguration.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation

protocol SessionConfiguration {
    var session: URLSession { get }
}

struct ForegroundSessionConfiguration: SessionConfiguration {
    var session: URLSession
    
    init(session: URLSession) {
        let foregroundConfiguration = URLSessionConfiguration.default
        foregroundConfiguration.timeoutIntervalForRequest = 30
        foregroundConfiguration.requestCachePolicy = .useProtocolCachePolicy
        foregroundConfiguration.allowsCellularAccess = true
        self.session = URLSession(configuration: foregroundConfiguration)
    }
}

struct BackGroundConfiguration: SessionConfiguration {
    var session: URLSession
    
    init() {
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "background")
        backgroundConfiguration.timeoutIntervalForRequest = 60
        backgroundConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        backgroundConfiguration.allowsCellularAccess = true
        self.session = URLSession(configuration: backgroundConfiguration)
    }
}
