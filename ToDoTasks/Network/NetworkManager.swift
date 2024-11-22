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
    let foregroundSession: SessionConfigurable
    var backgroundSession: SessionConfigurable
    let endpoint: EndpointConfigurable
    let retryPolicy: RetryConfigurable
    
    init(errorHandler: ErrorUsable, endpoint: EndpointConfigurable, retryPolicy: RetryConfigurable, foregroundSession: SessionConfigurable, backgroundSession: SessionConfigurable /*,viewControllerForErrorDelegate: UIViewController*/) {
        self.errorHandler = errorHandler
        self.foregroundSession = foregroundSession
        self.backgroundSession = backgroundSession
        self.endpoint = endpoint
        self.retryPolicy = retryPolicy
    }
    
    func performForegroundRequest<T: Decodable>(viewController: UIViewController, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = try? endpoint.returnRequest() else {return}
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
    
    extension NetworkManager: URLSessionDataDelegate {
        
        func performBackgroundRequest(viewController: UIViewController) {
            guard let request = try? endpoint.returnRequest() else {return}
            
            backgroundSession.configureBackgroundSession(delegate: self).downloadTask(with: request) { URL, response, error in
                guard let error = error as? URLError else { return }
                DispatchQueue.main.async {
                    self.errorHandler.handleNetworkError(error: error, retryPolicy: self.retryPolicy, viewController: viewController)
                }
                guard let response = response as? HTTPURLResponse else { return }
                self.errorHandler.handleHTTPResponse(response: response, retryPolicy: self.retryPolicy, viewController: viewController)
            }.resume()
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            // Обработка загруженного файла, перемещение его из временного места хранения.
            let fileManager = FileManager.default    // Папка, куда будем сохранять фильм
            do {
                let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let destinationURL = documentsURL.appendingPathComponent("downloaded_movie.mp4")
                
                // Удаляем старый файл, если существует
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                
                // Перемещаем загруженный файл в папку Documents
                try fileManager.moveItem(at: location, to: destinationURL)
                print("Файл сохранен по пути: \(destinationURL.path)")
            } catch {
                print("Ошибка при перемещении файла: \(error)")
            }
        }
        
        func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {// Этот метод вызывается системой, когда все фоновые задачи сессии завершены, и приложение получает возможность безопасно вызвать завершающий обработчик фоновой сессии. используется для завершения работы фоновой сессии URLSession в iOS
            DispatchQueue.main.async {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                    completionHandler()
                    appDelegate.backgroundSessionCompletionHandler = nil
                }
            }
        }
    }

