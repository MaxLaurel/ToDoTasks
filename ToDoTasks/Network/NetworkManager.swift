//
//  NetworkManager.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation

protocol NetworkRequestPerforming {
    func performRequest(configuration: SessionConfigurable,
                        requestEndpoint: EndpointConfigurable,
                        retryPolicy: RetryPolicy,
                        errorHandler: ErrorUsable,
                        alertPresenter: AlertPresenter,
                        completion: @escaping (Result<Data, Error>) -> Void)
}

private class NetworkManager: NetworkRequestPerforming {

    func performRequest(configuration: SessionConfigurable, requestEndpoint: EndpointConfigurable, retryPolicy: RetryPolicy, errorHandler: ErrorUsable, alertPresenter: AlertPresenter, completion: @escaping (Result<Data, Error>) -> Void) {
        
    func makeNetworkRequest() {
        do {
            let request = try requestEndpoint.returnRequest()
            configuration.session.dataTask(with: request) { data, response, error in
                if let error = error as? URLError {
                    errorHandler.handleNetworkError(error, alert: alertPresenter, retryPolicy: retryPolicy, networkRequest: makeNetworkRequest)
                } else if let error = error {
                    completion(.failure(error))
                    
                } else if let response = response as? HTTPURLResponse {
                    errorHandler.handleHTTPResponse(response, alert: alertPresenter, retryPolicy: retryPolicy, networkRequest: makeNetworkRequest)
                    
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
}
