//
//  SessionConfiguration.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation

protocol SessionConfigurable {
    var session: URLSession { get }
}

private struct ForegroundSessionConfiguration: SessionConfigurable {
    var session: URLSession
    
   private init(session: URLSession) {
        let foregroundConfiguration = URLSessionConfiguration.default
        foregroundConfiguration.timeoutIntervalForRequest = 30
        foregroundConfiguration.requestCachePolicy = .useProtocolCachePolicy
        foregroundConfiguration.allowsCellularAccess = true
        self.session = URLSession(configuration: foregroundConfiguration)
    }
}

private struct BackGroundConfiguration: SessionConfigurable {
    var session: URLSession
    
    init() {
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "background")
        backgroundConfiguration.timeoutIntervalForRequest = 60
        backgroundConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        backgroundConfiguration.allowsCellularAccess = true
        self.session = URLSession(configuration: backgroundConfiguration)
    }
}
