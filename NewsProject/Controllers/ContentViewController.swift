//
//  ContentViewController.swift
//  NewsProject
//
//  Created by MAC13 on 02.02.2023.
//

import UIKit
import SafariServices
import Kingfisher

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
    @IBOutlet weak var labelAuthor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTime.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewTime.layer.cornerRadius = 15
        pushToBrowser.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        pushToBrowser.layer.cornerRadius = 15
        
        labelTitle.text = article.title
        labelDescription.text = article.description
        labelTime.text = article.publishedAt
        labelAuthor.text = article.author
        
        getImage(url: self.article.urlToImage, imageView: self.imageView)
        
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
