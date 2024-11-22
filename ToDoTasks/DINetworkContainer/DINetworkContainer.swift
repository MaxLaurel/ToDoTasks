//
//  ServiceProvider.swift
//  ToDoTasks
//
//  Created by Максим on 09.11.2024.
//

import Foundation
import UIKit

class DINetworkContainer: NSObject, URLSessionDelegate {
    static let shared = DINetworkContainer()
    
    lazy var token: String = "1234567890"//зависимость если придется передавть токен
    
    lazy var requestPhoto = UIImage() //зависимость если придется передавать фото обращения
    lazy var textRequest = String() //зависимость если придется передавать текст обращения
    lazy var errorHandler: any ErrorUsable = ErrorHandler()
    
    lazy var foregroundNetworkManager: NetworkManager = {
       Log.info("Creating foregroundNetworkManager")
        
        return NetworkManager(errorHandler: errorHandler, endpoint: EndpointType.getForegroundData, retryPolicy: RetryPolicy.aggressive, foregroundSession: SessionConfiguration.foregroundSession, backgroundSession: SessionConfiguration.backgroundSession(delegate: self ))
    }()
    
    lazy var backGroundNetworkManager: NetworkManager = {
        return NetworkManager(errorHandler: errorHandler, endpoint: EndpointType.downloadBackgroundData, retryPolicy: RetryPolicy.aggressive, foregroundSession: SessionConfiguration.foregroundSession, backgroundSession: SessionConfiguration.backgroundSession(delegate: self ))
    }()
    
    lazy var foregroundNetworkManagerWithToken: NetworkManager = {
        return NetworkManager(errorHandler: errorHandler, endpoint: EndpointType.getForegroundDataWithToken(token: token), retryPolicy: RetryPolicy.aggressive, foregroundSession: SessionConfiguration.foregroundSession, backgroundSession: SessionConfiguration.backgroundSession(delegate: self ))
    }()
    
    lazy var foregroundNetworkManagerWithMultipart: NetworkManager = {
        return NetworkManager(errorHandler: errorHandler, endpoint: EndpointType.uploadMultiPartData(image: requestPhoto, text: textRequest), retryPolicy: RetryPolicy.aggressive, foregroundSession: SessionConfiguration.foregroundSession, backgroundSession: SessionConfiguration.backgroundSession(delegate: self ))
    }()

}
