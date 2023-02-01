//
//  Article.swift
//  NewsProject
//
//  Created by MAC13 on 01.02.2023.
//

import Foundation
import RealmSwift

struct Article {
    let sourceName: String
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
    init(dictionary: Dictionary<String, Any>) {
        author = dictionary["author"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
        sourceName = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""])["name"] as? String ?? ""
    }
    
}

class News: Object, Decodable {
    @objc dynamic var sourceName: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionNew: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    
    convenience init(sourceName: String, author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String) {
        self.init()
        self.sourceName = sourceName
        self.author = author
        self.title = title
        self.descriptionNew = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    convenience init(dictionary: Dictionary<String, Any>) {
        self.init()
        author = dictionary["author"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        descriptionNew = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
        sourceName = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""])["name"] as? String ?? ""
    }
}
