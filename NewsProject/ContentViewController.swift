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
    
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var pushToBrowser: UIButton!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var indicatorNews: UIActivityIndicatorView!
    @IBOutlet weak var labelTime: UILabel!
    
    override func viewDidLoad() {
        viewTime.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewTime.layer.cornerRadius = 15
        pushToBrowser.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        pushToBrowser.layer.cornerRadius = 15
        super.viewDidLoad()
        
        labelTitle.text = article.title
        labelDescription.text = article.description
        labelTime.text = article.publishedAt
        
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
                
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "content")
                }
            }
        }
        if URL(string: article.url) == nil {
            pushToBrowser.isHidden = true
            
        }
    }
    
    @IBAction func pushToOpenInBrowser(_ sender: Any) {
        if let url = URL(string: article.url) {
            let svc = SFSafariViewController(url:url)
            present(svc, animated: true)
        }
    }
    
}
