//
//  Model.swift
//  News-App
//
//  Created by SCG on 10/25/21.
//

import Foundation
import UIKit

struct Articles: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Codable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct Source: Codable {
    var id: String?
    var name: String?
}

extension UIImage {
    var data: Data? {
        if let data = self.jpegData(compressionQuality: 1.0) {
            return data
        } else {
            return nil
        }
    }
}

extension String {
    var image: UIImage? {
        let url = URL(string: self)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
}
