//
//  YouTubeAPIClient.swift
//  ToDoTasks
//
//  Created by Максим on 05.09.2024.
//

import Foundation
import Alamofire

class YouTubeAPIClient {
    
    static var shared = YouTubeAPIClient()
    private init() {}
    
    func getVideoFromAPI() {
        AF.request(<#T##convertible: any URLRequestConvertible##any URLRequestConvertible#>).response { data in

        }
    }
}
