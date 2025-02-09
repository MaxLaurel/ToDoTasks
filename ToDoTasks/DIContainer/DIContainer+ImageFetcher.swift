//
//  DIContainer+ImageFetcher.swift
//  ToDoTasks
//
//  Created by Максим on 24.01.2025.
//

import Foundation

extension DIContainer {
    
    func registerImageFetcher() {
        container.register(URLtoImageFetcherProtocol.self) { _ in
            return URLtoImageFetcher()
        }
    }
    
    func resolveImageFetcher() -> URLtoImageFetcherProtocol {
        guard let dependency = container.resolve(URLtoImageFetcherProtocol.self) else {fatalError("Failed to resolve ImageFetcher")}
        return dependency
    }
}
