//
//  NewsTableViewCell.swift
//  NewsProject
//
//  Created by MAC13 on 03.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var timeNews: UILabel!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
    @IBOutlet weak var imageCheck: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
