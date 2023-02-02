//
//  Model.swift
//  NewsProject
//
//  Created by MAC13 on 01.02.2023.
//

import Foundation
import RealmSwift

var articles: [Article] = []
let realm = try! Realm()
let news = realm.objects(News.self)
var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(filePath: path)
    return urlPath
}

func loadNews(competionHandler: (()->Void)?) {
    
    let url = URL(string:
                    "https://newsapi.org/v2/everything?q=tesla&from=2023-01-01&sortBy=publishedAt&apiKey=1f20c5e9a1e644a6b98c21f5e8cc8bca")!
    let session = URLSession(configuration: .default)
//    let task = session.dataTask(with: url) { data, response, error in
//        if data != nil {
//        }
//    }
    let task = session.downloadTask(with: url) { urlFile, responce, error in
        if urlFile != nil {

            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            print(urlToData)
            parseJson()
            competionHandler?()
            //saveNewsToRealm()

           // print(news.count)
        }
    }
    task.resume()
   
}

func parseJson() {
    
    let data = try? Data(contentsOf: urlToData)
    guard data != nil else {
        return
    }
    let rootDictionary = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as? Dictionary<String, Any>
    if rootDictionary == nil {
        return
    }
    if let array = rootDictionary!["articles"] as? [Dictionary<String, Any>] {
        var returnArray: [Article] = []
        for dict in array {
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        articles = returnArray
    }
}

func saveNewsToRealm() {
    let realm = try! Realm()
 //   let decoder = JSONDecoder()
    let data = try? Data(contentsOf: urlToData)
    let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any>
    
        try! realm.write {
            if let newsArray = json!["articles"] as? [Dictionary<String, Any>] {
                for item in newsArray {
                    let newsItem = News(dictionary: item)
                    realm.add(newsItem)
                }
            }
        }
        let news = realm.objects(News.self).sorted(byKeyPath: "publishedAt", ascending: false)
        
        // Удалите все новости, кроме последних 100
        if news.count > 100 {
            let excessNews = Array(news[100...news.count - 1])
            try! realm.write {
                realm.delete(excessNews)
            }
        
    }

}

