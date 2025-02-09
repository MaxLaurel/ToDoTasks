//
//  NetworkManager.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation
import UIKit

protocol NetworkRequestPerforming {
    func performForegroundRequest<T: Decodable>(viewController: UIViewController, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager: NSObject, NetworkRequestPerforming, URLSessionDelegate {
    
    let errorHandler: ErrorUsable
    let foregroundSession: SessionConfigurable?
    let endpoint: EndpointConfigurable
    let retryPolicy: RetryConfigurable
    
    init(errorHandler: ErrorUsable, endpoint: EndpointConfigurable, retryPolicy: RetryConfigurable, foregroundSession: SessionConfigurable) {
        self.errorHandler = errorHandler
        self.foregroundSession = foregroundSession
        self.endpoint = endpoint
        self.retryPolicy = retryPolicy
    }
    
    func performForegroundRequest<T: Decodable>(viewController: UIViewController, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = try? endpoint.returnRequest() else {return}
        guard let foregroundSession else {return}
        foregroundSession.configureForegroundSession().dataTask(with: request) { data, response, error in
            if let error = error as? URLError {
               Log.info("URLError block")
                DispatchQueue.main.async {
                    self.errorHandler.handleNetworkError(error: error, retryPolicy: self.retryPolicy, viewController: viewController)
                completion(.failure(error))
                }
            } else if let error = error {
               Log.info("error block")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if !(response is HTTPURLResponse) {
                DispatchQueue.main.async {
                   Log.info("got into nonHTTPResponse block")
                    let error = self.errorHandler.handleOtherError(error: .nonHTTPResponse)
                    completion(.failure(error))
                }
            }
            else if let response = response as? HTTPURLResponse {
                //данный ответ распечатываем только если нужно получить все метаинформацию из заголовков ответа
//                let headers = response.allHeaderFields
//                    print("Response Headers: \(headers)")
                
                Log.info("got into HTTPURLResponse block", shouldLogContext: true)
                self.errorHandler.handleHTTPResponse(response: response, retryPolicy: self.retryPolicy, viewController: viewController)
                
                if let data = data {
                  Log.info("got into data block", shouldLogContext: true)
//                    добавляем в блоке с датой только для отладки чтобы убедиться что нам что то приходит
//                    if let jsonString = String(data: data, encoding: .utf8) {
//                    print("JSON Response: \(jsonString)")
//                    }
                    
                    let decodeResult = Decoder.decode(type: NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        switch decodeResult {
                        case .success(let decodedData):
                         Log.info("decodedData block", shouldLogContext: true)
                            let articles = decodedData.articles
                            completion(.success(articles as! T))
                        case .failure(let error):
                         Log.error("decoding data was failed", shouldLogContext: true)
                            let error = self.errorHandler.handleOtherError(error: .decodingFailed)
                            completion(.failure(error))
                        }
                    }
                }
            }
        }.resume()
    }
}
    
