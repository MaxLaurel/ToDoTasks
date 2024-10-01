//
//  EndpointConfiguration.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation

enum EndpointError: Error{
    case cannotCreateURLWithComponent
}

protocol EndpointConfigurable {
    func returnRequest() throws -> URLRequest
}

enum endpointType: EndpointConfigurable {
    
    case getData
    case uploadData
    
    var baseURLPath: URL? {
        guard let url = URL(string: "https://newsapi.org/v2/everything") else { return nil }
        return url
    }

    
    func createEndpointPath() throws -> URL {
        guard var urlComponents = URLComponents(url: baseURLPath!, resolvingAgainstBaseURL: false) else { throw URLError(.badURL)}
        switch self {
        case .getData:
            urlComponents.queryItems = [URLQueryItem(name: "q", value: "OpenAI")]
            guard let url = urlComponents.url else { throw EndpointError.cannotCreateURLWithComponent }
            return url
            
        case .uploadData:
            urlComponents.queryItems = [URLQueryItem(name: "from", value: "2024-09-01")]
            guard let url = urlComponents.url else { throw EndpointError.cannotCreateURLWithComponent }
            return url
        }
    }
    
    var method: String {
        switch self {
        case .getData: return "GET"
        case .uploadData: return "POST"
        }
    }
    
    func returnRequest() throws -> URLRequest {
            let endpointPath = try createEndpointPath()
            let urlRequest = URLRequest(url: endpointPath)
            return urlRequest
    }
}

