//
//  SessionConfiguration.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation
import UIKit

//способ №1
protocol SessionConfigurable {
    func configureForegroundSession() -> URLSession
    func configureBackgroundSession(delegate: URLSessionDelegate) -> URLSession
}
enum SessionConfiguration: SessionConfigurable {
  
    case foregroundSession
    case backgroundSession(delegate: URLSessionDelegate)
    
    func configureForegroundSession() -> URLSession {
        let foregroundConfiguration = URLSessionConfiguration.default
        foregroundConfiguration.waitsForConnectivity = true
        foregroundConfiguration.timeoutIntervalForRequest = 20
        foregroundConfiguration.allowsCellularAccess = true
        //let cache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        //foregroundConfiguration.urlCache = cache
       
        return URLSession(configuration: foregroundConfiguration)
    }
    
    func configureBackgroundSession(delegate: URLSessionDelegate) -> URLSession {
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "background")
        backgroundConfiguration.waitsForConnectivity = true
        backgroundConfiguration.timeoutIntervalForRequest = 60
        backgroundConfiguration.allowsCellularAccess = true
        let cache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        backgroundConfiguration.urlCache = cache
       
        return URLSession(configuration: backgroundConfiguration, delegate: delegate, delegateQueue: nil)
    }
    
    func instantiateSession() -> URLSession {
        switch self {
        case .foregroundSession: return configureForegroundSession()
        case .backgroundSession(let delegate): return configureBackgroundSession(delegate: delegate)
        }
    }
}
//способ №2
enum SessionConfiguration2 {
    
    case foregroundSession
    case backgroundSession(delegate: URLSessionDelegate)
    
    func instantiateSession() -> URLSession {
        switch self {
        case .foregroundSession:
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 20
            config.allowsCellularAccess = true
            config.urlCache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
            return URLSession(configuration: config)
            
        case .backgroundSession(let delegate):
            let config = URLSessionConfiguration.background(withIdentifier: "background")
            config.timeoutIntervalForRequest = 60
            config.allowsCellularAccess = true
            config.urlCache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
            return URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
        }
    }
}

//способ №3
 struct ForegroundSessionConfiguration {
    let session: URLSession
    
    init() {
        let foregroundConfiguration = URLSessionConfiguration.default
        foregroundConfiguration.timeoutIntervalForRequest = 20
        //foregroundConfiguration.requestCachePolicy = .useProtocolCachePolicy настраивается в реквесте
        foregroundConfiguration.allowsCellularAccess = true
        let cache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        foregroundConfiguration.urlCache = cache
        self.session = URLSession(configuration: foregroundConfiguration)
    }
}

 struct BackgroundSessionConfiguration {
    let session: URLSession
    let delegate: URLSessionDelegate
    
    init(delegate: URLSessionDelegate) {
        self.delegate = delegate
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "background")
        backgroundConfiguration.timeoutIntervalForRequest = 60
        //backgroundConfiguration.requestCachePolicy = .returnCacheDataElseLoad настраивается в реквесте
        backgroundConfiguration.allowsCellularAccess = true
        let cache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        backgroundConfiguration.urlCache = cache
        self.session = URLSession(configuration: backgroundConfiguration, delegate: delegate, delegateQueue: nil)
    }
}
//способ №4
struct ForegroundSessionConfiguration2 {
    
    let session: URLSession
    
     func configureForegroundSession() -> URLSession {
        let foregroundConfiguration = URLSessionConfiguration.default
        foregroundConfiguration.timeoutIntervalForRequest = 20
        foregroundConfiguration.allowsCellularAccess = true
        let cache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        foregroundConfiguration.urlCache = cache
         
        return URLSession(configuration: foregroundConfiguration)
    }
    
     func configureBackgroundSession(delegate: URLSessionDelegate) -> URLSession {
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "background")
        backgroundConfiguration.timeoutIntervalForRequest = 60
        backgroundConfiguration.allowsCellularAccess = true
        let cache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        backgroundConfiguration.urlCache = cache
         
        return URLSession(configuration: backgroundConfiguration, delegate: delegate, delegateQueue: nil)
    }
}
//cпособ №5 (фабрика)
struct SessionFactory {
    
    static func makeForegroundSession() -> URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.allowsCellularAccess = true
        config.urlCache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        return URLSession(configuration: config)
    }

    static func makeBackgroundSession(delegate: URLSessionDelegate) -> URLSession {
        let config = URLSessionConfiguration.background(withIdentifier: "background")
        config.timeoutIntervalForRequest = 60
        config.allowsCellularAccess = true
        config.urlCache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        return URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
    }
}

//способ №6 (синглтон)
class SessionManager {
    static let shared = SessionManager()
    private init() { }
    
    lazy var foregroundSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.allowsCellularAccess = true
        config.urlCache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        return URLSession(configuration: config)
    }()
    
    func createBackgroundSession(delegate: URLSessionDelegate) -> URLSession {
        let config = URLSessionConfiguration.background(withIdentifier: "background")
        config.timeoutIntervalForRequest = 60
        config.allowsCellularAccess = true
        config.urlCache = URLCache(memoryCapacity: 1024 * 1024, diskCapacity: 1024 * 1024 * 10, directory: nil)
        return URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
    }
}
