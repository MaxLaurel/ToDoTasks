//
//  RetryConfig.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation
import UIKit

protocol ErrorUsable {
    
    func handleHTTPResponse(response: HTTPURLResponse, retryPolicy: RetryConfigurable, viewController: UIViewController)
    
    func handleNetworkError(error: URLError, retryPolicy: RetryConfigurable, viewController: UIViewController)
    
    func showAlertError(title: String, message: String, viewController: UIViewController)
    
    func handleOtherError(error: OtherNetworkError) -> Error
    
}

class ErrorHandler: ErrorUsable {
   
    func handleNetworkError(error: URLError, retryPolicy: RetryConfigurable, viewController: UIViewController) {
        switch error.code {
        case .notConnectedToInternet:
            //здесь будет отрабатывать waitsForConnectivity поэтому ретрай не нужен
           Log.error("notConnectedToInternet")
            
        case .timedOut:
          Log.error("Timeout")
            DispatchQueue.main.async {
                self.showAlertError(title: "Network Error", message: "An unexpected network error occurred. Please try again", viewController: viewController)
            }
            
        case .networkConnectionLost:
            //здесь будет отрабатывать waitsForConnectivity поэтому ретрай не нужен
           Log.error("Network connection lost")
            
        case .cannotFindHost:
           Log.error("Cannot find host. Please check the URL.")
            retryPolicy.handleRetry()
            DispatchQueue.main.async {
                self.showAlertError(title: "Network Error", message: "An unexpected network error occurred. Please try again", viewController: viewController)
            }
            
        case .dnsLookupFailed:
          Log.error("dnsLookupFailed")
            retryPolicy.handleRetry()
            
        case .badURL:
           Log.error("Bad URL. Please check the URL format.")
            retryPolicy.handleRetry()
            DispatchQueue.main.async {
                self.showAlertError(title: "Network Error", message: "An unexpected network error occurred. Please try again", viewController: viewController)
            }
            
        case .unsupportedURL:
           Log.error("Unsupported URL")
            retryPolicy.handleRetry()
            DispatchQueue.main.async {
                self.showAlertError(title: "Network Error", message: "An unexpected network error occurred. Please try again", viewController: viewController)
            }
            
        case .clientCertificateRejected:
          Log.error("Client certificate rejected.")
            retryPolicy.handleRetry()
            DispatchQueue.main.async {
                self.showAlertError(title: "Network Error", message: "An unexpected network error occurred. Please try again", viewController: viewController)
            }
            
        case .userAuthenticationRequired:
          Log.error("User authentication required.")
            DispatchQueue.main.async {
                self.showAlertError(title: "Authentication Required", message: "Please log in to continue.", viewController: viewController)
                //TODO: здесь нужно добавить чтобы был переход на экран авторизации вместо алерта
            }
            
        default:
           Log.error("Unhandled network error \(error.localizedDescription).")
            retryPolicy.handleRetry()
            DispatchQueue.main.async {
                self.showAlertError(title: "Network Error", message: "An unexpected network error occurred. Please try again", viewController: viewController)
            }
        }
    }
    
    func handleHTTPResponse(response: HTTPURLResponse, retryPolicy: RetryConfigurable, viewController: UIViewController) {
        if (200...299).contains(response.statusCode) {
          Log.info("Successful request with status code \(response.statusCode)")
              return
          }
        
        switch response.statusCode {
        case 400...499:
            if response.statusCode == 401 {
              Log.error("Authorization required")
                DispatchQueue.main.async {
                    self.showAlertError(title: "Unauthorized", message: "Please check your credentials and try again.", viewController: viewController)
                    //TODO: здесь нужно добавить чтобы был переход на экран авторизации вместо алерта
                }
            } else if response.statusCode == 404 {
                showAlertError(title: "Not Found", message: "Requested resource not found", viewController: viewController)
            } else {
              Log.error("Client error. Status code: \(response.statusCode)")
            }
            
        case 500...599:
            if response.statusCode == 500 {
             Log.error("Server error: \(response.statusCode). Retrying...")
                retryPolicy.handleRetry()
            }
            else if response.statusCode == 503 {
             Log.error("Service Unavailable: \(response.statusCode). Retrying...")
                retryPolicy.handleRetry()
            } else {
            Log.error("Unknown error. Status code: \(response.statusCode)")
            }
            
        default:
          Log.error("Unknown HTTPURLResponse error. Status code: \(response.statusCode)")
            DispatchQueue.main.async {
                retryPolicy.handleRetry()
                self.showAlertError(title: "Network Error", message: "An unexpected network error occurred. Please try again", viewController: viewController)
            }
        }
    }
    
    func showAlertError(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        viewController.present(alert, animated: true)
    }
    
    func handleOtherError(error: OtherNetworkError) -> Error {
        switch error {
        case .nonHTTPResponse: Log.error("The response is not an HTTP response")
        case .decodingFailed: Log.error("Failed to decode the data")
        case .invalidContentType: Log.error("Unsupported Content-Type")
        case .sslError: Log.error("SSL issues (certificates)")
        }
        return error
    }
}

enum OtherNetworkError: Error {
   case nonHTTPResponse
   case decodingFailed
   case invalidContentType
   case sslError
}


