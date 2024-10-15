////
////  Service.swift
////  ToDoTasks
////
////  Created by Максим on 30.05.2024.
////
//
//import Foundation
//import Alamofire
//
//class Service {
//
//    let url = "https://newsapi.org/v2/everything"
//    
//    func getNews(completion: @escaping (Articles?) -> ()) {
//        
//        let parameters: Parameters = [
//            "q": "environment",
//            "from": "2024-05-21",
//            "to": "2024-05-21",
//            "sortBy": "popularity",
//            "apiKey": "23ed6969bd05413aa7680d0a492f26e9"
//        ]
//        
//        AF.request(url, method: .get, parameters: parameters).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let decodedData = try JSONDecoder().decode(Articles.self, from: data)
//                    completion(decodedData)
//                } catch {
//                    print("Error decoding data: \(error.localizedDescription)")
//                    completion(nil)
//                }
//            case .failure(let error):
//                print("Request error: \(error.localizedDescription)")
//                completion(nil)
//            }
//        }
//    }
//}
