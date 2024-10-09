//
//  RetryConfig.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation
import UIKit

protocol ErrorUsable {
    func handleNetworkError(_ error: URLError, alert: AlertPresenter, retryPolicy: RetryConfigurable, networkRequest: @escaping () -> Void)
    func handleHTTPResponse(_ response: HTTPURLResponse, alert: AlertPresenter, retryPolicy: RetryConfigurable, networkRequest: @escaping () -> Void)
}

private class ErrorHandler: ErrorUsable {
     func handleNetworkError(_ error: URLError, alert: AlertPresenter, retryPolicy: RetryConfigurable, networkRequest: @escaping () -> Void) {
        switch error.code {
        case .notConnectedToInternet:
            retryPolicy.handleRetry(networkRequest: networkRequest)

        case .timedOut:
            print("Timeout")
            alert.showAlert("Network Error", message: "An unexpected network error occurred. Please try again")
            
        case .networkConnectionLost:
            retryPolicy.handleRetry(networkRequest: networkRequest)
            
        case .cannotFindHost:
            print("Cannot find host. Please check the URL.")
            alert.showAlert("Network Error", message: "An unexpected network error occurred. Please try again")
            
        case .dnsLookupFailed:
            retryPolicy.handleRetry(networkRequest: networkRequest)
            
        case .badURL:
            print("Bad URL. Please check the URL format.")
            alert.showAlert("Network Error", message: "An unexpected network error occurred. Please try again")
            
        case .unsupportedURL:
            print("Unsupported URL.")
            alert.showAlert("Network Error", message: "An unexpected network error occurred. Please try again")
            
        case .clientCertificateRejected:
            print("Client certificate rejected.")
            alert.showAlert("Network Error", message: "An unexpected network error occurred. Please try again")
            
        case .userAuthenticationRequired:
            alert.showAlert("Authentication Required", message: "Please log in to continue.")
            
        default:
            print("Unhandled network error: \(error.localizedDescription)")
            alert.showAlert("Network Error", message: "An unexpected network error occurred. Please try again")
        }
    }
    
     func handleHTTPResponse(_ response: HTTPURLResponse, alert: AlertPresenter, retryPolicy: RetryConfigurable, networkRequest: @escaping () -> Void) {
        switch response.statusCode {

        case 400...499:
            if response.statusCode == 401 {
                print("Unauthorized - please check your credentials.")
                
                alert.showAlert("Unauthorized", message: "Please check your credentials and try again.")
            } else if response.statusCode == 404 {
                print("Resource not found")
            } else {
                print("Client error. Status code: \(response.statusCode)")
            }
            
        case 500...599:
            if response.statusCode == 500 {
                print("Server error: \(response.statusCode). Retrying...")
                retryPolicy.handleRetry(networkRequest: networkRequest)
            }
            else if response.statusCode == 503 {
                print("Service Unavailable: \(response.statusCode). Retrying...")
                retryPolicy.handleRetry(networkRequest: networkRequest)
            } else {
                print("Server error. Status code: \(response.statusCode)")
            }
            
        default:
            print("Unhandled HTTP error: \(response.statusCode)")
            alert.showAlert("Network Error", message: "An unexpected network error occurred. Please try again")
        }
    }
}

