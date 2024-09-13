//
//  YouTubeAPIModel.swift
//  ToDoTasks
//
//  Created by Максим on 06.09.2024.
//

import Foundation

// MARK: - YouTubeAPIModel
struct YouTubeAPIModel: Codable {
    var status: String
    var totalResults: Int
    var articles: [YouTubeArticle]
}

// MARK: - Article
struct YouTubeArticle: Codable {
    var source: Source
    var author: String?
    var title, description: String
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String
}

// MARK: - Source
struct Source: Codable {
    var id: String?
    var name: String
}


