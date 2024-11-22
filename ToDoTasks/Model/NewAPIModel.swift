//
//  YouTubeAPIModel.swift
//  ToDoTasks
//
//  Created by Максим on 06.09.2024.
//

//import Foundation
//
//// MARK: - YouTubeAPIModel
// struct NewAPIModel: Codable {
//    var status: String
//    var totalResults: Int
//    var articles: [String: NewApiArticle]
//}
//
////если с сервера будут приходить поля например, с снейк кейсом, мы можем указать для каждого поля нашей модели значение поля с сервера, таким образом у нас все будет в свифтовом стиле через CamelCase
//enum NewAPIModelCodingkeys: String, CodingKey {
//    case status = "status"
//    case totalResults = "totalResults"
//    case articles = "articles"
//    
//}
//
//// MARK: - Article
// struct NewApiArticle: Codable {
//    var source: Source
//    var author: String?
//    var title, description: String
//    var url: String
//    var urlToImage: String?
//    var publishedAt: String//если формат даты Date а не String то нужно в декодере писать логику DateFormatter
//    var content: String
//}
//
//enum NewApiArticleCodingKeys: String, CodingKey {
//    case source = "source"
//    case author = "author"
//    case title = "title"
//    case description = "description"
//    case url = "url"
//    case urlToImage = "urlToImage"
//    case publishedAt = "publishedAt"
//    case content = "content"
//}
//
//// MARK: - Source
// struct Source: Codable {
//    var id: String?
//    var name: String
//}


import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    //let articles: [String: Article]
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
