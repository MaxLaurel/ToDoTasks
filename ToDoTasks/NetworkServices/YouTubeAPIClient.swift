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
    
    var youTubeArticle = [YouTubeArticle]()
    
    func getVideoFromAPI(clouser: @escaping ([YouTubeArticle]?) -> Void) {
        AF.request(APIEndpoints.getVideo).responseDecodable(of: YouTubeAPIModel.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                for article in data.articles {
                    self?.youTubeArticle.append(article)
                    print("Title: \(article.title)")
                    print("Description: \(article.description)")
                    print("URL: \(article.url)")
                    print("Published At: \(article.publishedAt)")
                    print("Content: \(article.content)")
                    print("-------------")
                    clouser(self?.youTubeArticle)
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
