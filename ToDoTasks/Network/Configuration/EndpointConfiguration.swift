//
//  EndpointConfiguration.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation
import UIKit

enum EndpointError: Error{
    case cannotCreateURLWithComponent
}

 protocol EndpointConfigurable {
     func returnRequest() throws -> URLRequest
}

private enum endpointType: EndpointConfigurable {
    case getData
    case uploadData
    case uploadMultyPartData
    
     var baseURLPath: URL? {
        guard let url = URL(string: "https://newsapi.org/v2/everything") else { return nil }
        return url
    }
    
    
     func createEndpointPath() throws -> URL {
        guard var urlComponents = URLComponents(url: baseURLPath!, resolvingAgainstBaseURL: false) else { throw URLError(.badURL)}
        switch self {
        case .getData:
            urlComponents.queryItems = [URLQueryItem(name: "q", value: "OpenAI")]
            
        case .uploadData:
            urlComponents.queryItems = [URLQueryItem(name: "from", value: "2024-09-01")]
            
        case .uploadMultyPartData:
            urlComponents.queryItems = [URLQueryItem(name: "SomeKey", value: "SomeParameter")]
        }
        guard let url = urlComponents.url else { throw EndpointError.cannotCreateURLWithComponent }
        return url
    }
    
     var header: [String: String] {
        let boundary = "/(UUID().uuidString)"
        var headers = [String: String]()
        
        switch self {
        case .getData: 
            headers["Accept"] = "application/json"
            
        case .uploadData:
            headers["Content-Type"] = "application/jason"
            headers["Accept"] = "application/json"
            
        case .uploadMultyPartData:
            headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        }

        return headers
    }
    
     var method: String {
        switch self {
        case .getData: return "GET"
        case .uploadData: return "POST"
        case .uploadMultyPartData: return "POST"
        }
    }
    
//    var body: Data? {
//        switch self {
//        case .getData: 
//            return nil
//        case .uploadData: 
//            return nil
//        case .uploadMultyPartData:
//            let boundary = "/(UUID().uuidString)"
//            let httpBody = createMultiPartBody()
//            return httpBody
//        }
//    }
    
    func returnRequest() throws -> URLRequest {
        let endpointPath = try createEndpointPath()
        let urlRequest = URLRequest(url: endpointPath)
        return urlRequest
    }
}

