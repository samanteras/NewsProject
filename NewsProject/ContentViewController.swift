//
//  ContentViewController.swift
//  NewsProject
//
//  Created by MAC13 on 02.02.2023.
//

import UIKit
import SafariServices

class ContentViewController: UIViewController {
    var article: Article!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = article.title
        labelDescription.text = article.description
        
        DispatchQueue.global().async {
            if let url = URL(string: self.article.urlToImage) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = try? Data(contentsOf: url) {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    @IBAction func pushToOpenInBrowser(_ sender: Any) {
        if let url = URL(string: article.url) {
            let svc = SFSafariViewController(url:url)
            present(svc, animated: true)
        }
    }
    
}
