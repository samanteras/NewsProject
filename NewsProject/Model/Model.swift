//
//  Model.swift
//  NewsProject
//
//  Created by MAC13 on 01.02.2023.
//

import Foundation

var articles: [Article] = []

func loadNews() {
    
    let url = URL(string:
                    "https://newsapi.org/v2/everything?q=tesla&from=2023-01-01&sortBy=publishedAt&apiKey=1f20c5e9a1e644a6b98c21f5e8cc8bca")!
    var session = URLSession(configuration: .default)
    let task = session.downloadTask(with: url) { urlFile, responce, error in
        if urlFile != nil {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
            let urlPath = URL(filePath: path)
            try? FileManager.default.copyItem(at: urlFile!, to: urlPath)
            print(urlPath)
            parseJson()
            print(articles.count)
        }
    }
    task.resume()
}

func parseJson() {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(filePath: path)
    
    let data = try? Data(contentsOf: urlPath)
    let rootDictionary = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as? Dictionary<String, Any>
    let array = rootDictionary!["articles"] as! [Dictionary<String, Any>]
    
    var returnArray: [Article] = []
    
    for dict in array {
        let newArticle = Article(dictionary: dict)
        returnArray.append(newArticle)
    }
    articles = returnArray
}
