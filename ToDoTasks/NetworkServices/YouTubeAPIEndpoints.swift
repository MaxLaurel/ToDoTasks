//
//  YouTubeAPIEndpoints.swift
//  ToDoTasks
//
//  Created by Максим on 05.09.2024.
//

import Foundation
import Alamofire

enum APIEndpoints: URLRequestConvertible {
    case getVideo
    case getAllVideosFromChannel
    
    var mainPathURL: String {
        return "https://newsapi.org/v2/everything"
    }
    
    private var endpointPathWithComponents: URLComponents? {
        var endpointPathWithComponents = URLComponents(string: mainPathURL)
        switch self {
        case .getVideo:
            endpointPathWithComponents?.queryItems = [
            URLQueryItem(name: "q", value: "OpenAI"),
            URLQueryItem(name: "from", value: "2024-09-01"),
            URLQueryItem(name: "sortBy", value: "popularity"),
            URLQueryItem(name: "apiKey", value:  "23ed6969bd05413aa7680d0a492f26e9")
            ]
        case .getAllVideosFromChannel:
            endpointPathWithComponents?.queryItems = [
            URLQueryItem(name: "q", value: "tesla"),
            URLQueryItem(name: "from", value: "2024-08-05"),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "apiKey", value:  "23ed6969bd05413aa7680d0a492f26e9")
            ]
        }
        return endpointPathWithComponents
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getVideo: return .get
        case .getAllVideosFromChannel: return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        guard let endpoint = endpointPathWithComponents else {throw URLError(.badURL)}
        let url = try endpoint.asURL()
        let request = try URLRequest(url: url, method: httpMethod)
        return request
    }
}
/////////
