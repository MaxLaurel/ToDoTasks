//
//  ServiceProvider.swift
//  ToDoTasks
//
//  Created by Максим on 09.11.2024.
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration


final class DINetworkContainer {
    static var shared = DINetworkContainer()
    private let container = Container()
    
    private init() {
        registerNetworkManagerDependancies()
        registerImageFetcher()
    }

//    func resolve<T, Arg1, Arg2, Arg3>(type: T.Type, endpoint: Arg1, retryPolicy: Arg2, session: Arg3) -> T? {//по хорошему зависимость всегда должна возвращаться и на этапе разработки вообще можно использовать fatalError чтобы сразу отлавливать такие ошибки, но если оставляем возможность что вернется nil нужно хотя бы логировать
//        if let resolved = container.resolve(T.self, arguments: endpoint, retryPolicy, session) {
//            return resolved
//        } else {
//            Log.error("⚠️ Dependency \(T.self) not registered and nil was returned.")
//            return nil
//        }
//    }
    
    func resolve<T>(type: T.Type, endpoint: EndpointConfigurable, retryPolicy: RetryConfigurable, session: SessionConfigurable) -> T? {
        if let resolved = container.resolve(T.self, arguments: endpoint, retryPolicy, session) {
            return resolved
        } else {
            Log.error("⚠️ Dependency \(T.self) not registered and nil was returned.")
            return nil
        }
    }
    
    func resolveImageFetcherDependency<T>(type: T.Type) -> T? {
        if let resolved = container.resolve(T.self) {
            return resolved
        } else {
            Log.error("⚠️ Dependency \(T.self) not registered and nil was returned.")
            return nil
        }
    }

}

private extension DINetworkContainer {

    func registerNetworkManagerDependancies() {
        
        container.register(ErrorUsable.self) { _ in
            ErrorHandler()
        }
        
        container.register(EndpointConfigurable.self) { (_, type: EndpointType, token: String, image: UIImage, text: String) in
            switch type {
            case .getForegroundData: EndpointType.getForegroundData
            case .getForegroundDataWithToken: EndpointType.getForegroundDataWithToken(token: token)
            case .uploadMultiPartData: EndpointType.uploadMultiPartData(image: image, text: text)
            case .downloadBackgroundData:  EndpointType.downloadBackgroundData
            }
        }

        container.register(RetryConfigurable.self) { (_, type: RetryPolicy) in
            switch type {
            case .aggressive: RetryPolicy.aggressive
            case .moderate: RetryPolicy.moderate
            }
        }
      
        container.register(SessionConfigurable.self) { (_, type: SessionConfiguration, delegate: URLSessionDelegate) in
            switch type {
            case .foregroundSession: SessionConfiguration.foregroundSession
            case .backgroundSession: SessionConfiguration.backgroundSession(delegate: delegate)
            }
        }

        container.register(NetworkRequestPerforming.self) { (resolver, endpoint: EndpointConfigurable, retryPolicy: RetryConfigurable, foregroundSession: SessionConfigurable) in
            guard let errorUsable = resolver.resolve(ErrorUsable.self) else { fatalError()}
            return NetworkManager(
                errorHandler: errorUsable,
                endpoint: endpoint,
                retryPolicy: retryPolicy,
                foregroundSession: foregroundSession
            )
        }
    }
}

private extension DINetworkContainer {//регистрация фетчера который ходит в сеть за картинкой для таблицы и кеширует ее
   
    func registerImageFetcher() {
        
        container.register(URLtoImageFetcherProtocol.self) { _ in
            return URLtoImageFetcher()
        }
    }
}

