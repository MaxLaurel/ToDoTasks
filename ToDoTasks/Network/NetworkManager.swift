//
//  NetworkManager.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation

class NetworkManager {

    func performRequest(configuration: SessionConfiguration, requestEndpoint: EndpointConfigurable, retryPolicy: RetryConfig, completion: @escaping (Result<Data, Error>) -> Void) {
        
        do {
            let request = try requestEndpoint.returnRequest()
            configuration.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    completion(.success(data))
                }
            }.resume()
        } catch EndpointError.cannotCreateURLWithComponent {
            print("need to handle Endpoint error")
        } catch {
            completion(.failure(error))
        }
     
    }
}
