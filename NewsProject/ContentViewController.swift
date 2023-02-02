//
//  ContentViewController.swift
//  NewsProject
//
//  Created by MAC13 on 02.02.2023.
//

import UIKit

class ContentViewController: UIViewController {
    var article: Article!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = article.title
        labelDescription.text = article.description
    }
    
    @IBAction func pushToOpenInBrowser(_ sender: Any) {
    }
    
}
