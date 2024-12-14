//
//  NetworkManagerDelegate.swift
//  ToDoTasks
//
//  Created by Максим on 09.12.2024.
//

import Foundation
import UIKit

class NetworkManagerDelegate: NSObject, URLSessionDelegate {
    
    let errorHandler: ErrorUsable
    var backgroundSession: SessionConfigurable?
    let endpoint: EndpointConfigurable
    let retryPolicy: RetryConfigurable
    
    init(errorHandler: ErrorUsable, endpoint: EndpointConfigurable, retryPolicy: RetryConfigurable, backgroundSession: SessionConfigurable) {
        self.errorHandler = errorHandler
        self.backgroundSession = backgroundSession
        self.endpoint = endpoint
        self.retryPolicy = retryPolicy
    }
    
    func performBackgroundRequest(viewController: UIViewController) {
        guard let request = try? endpoint.returnRequest() else {return}
        guard let backgroundSession = backgroundSession else { return }
        
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
