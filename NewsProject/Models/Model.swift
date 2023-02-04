//
//  Model.swift
//  NewsProject
//
//  Created by MAC13 on 01.02.2023.
//

import Foundation
import RealmSwift
import Kingfisher

var articles: [Article] = []

var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(filePath: path)
    return urlPath
}

func loadNews(competionHandler: (()->Void)?) {
    let url = URL(string:
                    "https://newsapi.org/v2/everything?q=tesla&from=2023-01-01&sortBy=publishedAt&apiKey=1f20c5e9a1e644a6b98c21f5e8cc8bca")!
    let session = URLSession(configuration: .default)
    let task = session.downloadTask(with: url) { urlFile, responce, error in
        if urlFile != nil {
            
            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            parseNews()
            competionHandler?()
        }
    }
    task.resume()
}

func parseNews() {
    let data = try? Data(contentsOf: urlToData)
    guard data != nil else {
        return
    }
    
    var rootDictionary = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as? Dictionary<String, Any>
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

func getImage(url: String, imageView: UIImageView){
    if let url = URL(string: url) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                if image!.size.height > 100 && image!.size.width > 100 {
                    DispatchQueue.main.async {
                        imageView.kf.setImage(with: url)
                    }
                } else {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(named: "content")
                    }
                }
            }
        }.resume()
    } else {
        DispatchQueue.main.async {
            imageView.image = UIImage(named: "content")
        }
    }
}
