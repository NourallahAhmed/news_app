//
//  news_request.swift
//  news
//
//  Created by NourAllah Ahmed on 01/01/2023.
//

import Foundation

// MARK: - NewsRequest
struct NewsRequest : Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
//    let publishedAt: Double?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
