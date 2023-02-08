//
//  Article.swift
//  NewsProject
//
//  Created by MAC13 on 01.02.2023.
//

import Foundation

struct Article: Codable {
    var sourceName: String
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var isCheck: Bool
    
    init(dictionary: Dictionary<String, Any>) {
        author = dictionary["author"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        sourceName = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""])["name"] as? String ?? ""
        isCheck = dictionary["isCompleted"] as? Bool ?? false
        
        let iso8601String = dictionary["publishedAt"] as? String ?? ""
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: iso8601String)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        publishedAt = formatter.string(from: date!)
            }
    }
