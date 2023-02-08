//
//  Model.swift
//  NewsProject
//
//  Created by MAC13 on 01.02.2023.
//

import Foundation
import Kingfisher

var articleModel: [Article] = []

func loadNews(competionHandler: (()->Void)?){
    let url = URL(string:"https://newsapi.org/v2/everything?q=apple&from=2023-02-07&to=2023-02-07&sortBy=popularity&apiKey=1f20c5e9a1e644a6b98c21f5e8cc8bca")!
    
    var request = URLRequest(url:url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil
        else {
            return
        }
        
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as? Dictionary<String, Any>
        if let responseJSON = responseJSON!["articles"] as? [Dictionary<String, Any>] {
            articleModel.removeAll()
            for item in responseJSON{
                articleModel.append(Article(dictionary: item))
            }
        }
        competionHandler?()
    }.resume()
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

func updateIsCheck(index: Int, isCheck: Bool) {
    var article = articleModel[index]
    article.isCheck = isCheck
    articleModel[index] = article
}
