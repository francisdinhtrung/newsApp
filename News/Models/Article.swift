//
//  Article.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit


// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    var publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
