//
//  RetryConfig.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation
import UIKit

class ErrorHandler {
    private func handleNetworkError(_ error: URLError, viewController: UIViewController) {
        switch error.code {
        case .notConnectedToInternet:
            startRetry()
            
        case .timedOut:
            showAlert(viewController: viewController)
            
        case .networkConnectionLost:
            startRetry()
            
        case .cannotFindHost:
            print("Cannot find host. Please check the URL.")
            showAlert(viewController: viewController)
         
        case .dnsLookupFailed:
            startRetry()
            
        case .badURL:
            print("Bad URL. Please check the URL format.")
            showAlert(viewController: viewController)
           
        case .unsupportedURL:
            print("Unsupported URL.")
            showAlert(viewController: viewController)

        case .clientCertificateRejected:
            print("Client certificate rejected.")
            showAlert(viewController: viewController)

        case .userAuthenticationRequired:
            showAlert("Authentication Required", message: "Please log in to continue.", viewController: viewController)
            
        default:
            print("Unhandled network error: \(error.localizedDescription)")
            showAlert(viewController: viewController)
        }
    }
    
    private func handleHTTPResponse(_ response: HTTPURLResponse, viewController: UIViewController) {
           switch response.statusCode {
           case 200:
               print("Request successful!")
               //retryCount = 0 // Сброс счетчика ретривов
               // Обработка успешного ответа, например, парсинг данных
           case 401:
               print("Unauthorized - please check your credentials.")
               showAlert("Unauthorized", message: "Please check your credentials and try again.", viewController: viewController)
           case 403:
               print("Forbidden - access denied.")
               showAlert(viewController: viewController)
           case 404:
               print("Not Found - resource does not exist.")
               showAlert(viewController: viewController)
           case 500:
               print("Server error: \(response.statusCode). Retrying...")
               startRetry()
           case 503:
               print("Service Unavailable: \(response.statusCode). Retrying...")
               startRetry()
           default:
               print("Unhandled HTTP error: \(response.statusCode)")
               showAlert(viewController: viewController)
           }
       }
    
    func startRetry() {
        
    }
    
    func showAlert(_ title: String = "Network Error", message: String = "An unexpected network error occurred. Please try again", viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        viewController.present(alert, animated: true)
    }
}

enum RetryConfig {
    
}
