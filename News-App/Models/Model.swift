//
//  Model.swift
//  News-App
//
//  Created by SCG on 10/25/21.
//

import Foundation

struct Articles: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
//    var source: Source
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var testImage: String = "https://demofree.sirv.com/nope-not-here.jpg"
}

struct Source: Codable {
    var id: String
    var name: String
}
