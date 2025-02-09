//  DIContainer+Coordinators.swift
//  ToDoTasks
//
//  Created by Максим on 24.01.2025.
//

import UIKit

extension DIContainer {
    
    func registerNetworkManagerDependancies() {
        
        container.register(ErrorUsable.self) { _ in
            return ErrorHandler()
        }
        
        //MARK: - Не захардкоживаем параметры а будем передавать те которые нужны в конкретном случае, поэтому NetworkManager можно переиспользовать
        container.register(NetworkRequestPerforming.self) { (_, endpoint: EndpointConfigurable, retryPolicy: RetryConfigurable, session: SessionConfigurable) in
            
            guard let errorUsable = self.resolveErrorHandler() else {
                fatalError("ErrorHandler could not be resolved")
            }
            return NetworkManager(errorHandler: errorUsable, endpoint: endpoint, retryPolicy: retryPolicy, foregroundSession: session
            )
        }.inObjectScope(.container)
    }

    func resolveErrorHandler() -> ErrorUsable? {
        guard let dependency = container.resolve(ErrorUsable.self) else {
            Log.error("Cannot resolve ErrorHandler")
            return nil
        }
        return dependency
    }

    func resolveNetworkManager(endpoint: EndpointConfigurable, retryPolicy: RetryConfigurable, session: SessionConfigurable) -> NetworkRequestPerforming? {
        guard let dependency = container.resolve(NetworkRequestPerforming.self, arguments: endpoint, retryPolicy, session) else {
            Log.error("Failed to resolve NetworkManager")
            return nil
        }
        return dependency
    }
}
