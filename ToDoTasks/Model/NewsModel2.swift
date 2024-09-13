//
//  NewsModel2.swift
//  ToDoTasks
//
//  Created by Максим on 06.06.2024.
//

//import Foundation

//// MARK: - Welcome
//struct Articles2: Decodable{
//    let status, totalResults: String
//    let articles: [OneOfTheArticle2]
//}
//
//// MARK: - Article
//struct OneOfTheArticle2: Decodable {
//    let source: Source
//    let author, title, description: String
//    let url, urlToImage: String
//    let publishedAt: Date
//    let content: String
//}
//
//// MARK: - Source
//struct Source: Decodable {
//    let id, name: String
//}


import Foundation

// MARK: - Welcome
struct Welcome: Codable {
//    let status: String?
//    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
//    let source: Source?
    let author: String?
    let title: String?
//    let description: String?
//    let url: String?
    let urlToImage: String?
//    let publishedAt: String?
    let content: String?
}

//// MARK: - Source
//struct Source: Codable {
//    let id: ID?
//    let name: Name?
//}
//
//enum ID: String, Codable {
//    case theWallStreetJournal = "the-wall-street-journal"
//}
//
//enum Name: String, Codable {
//    case theWallStreetJournal = "The Wall Street Journal"
//}
