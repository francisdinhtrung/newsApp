//
//  ArticleCell.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftDate

class ArticleCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var timeLabel: UIButton!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.setCornerRadius(radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func binding(_ article: Article) {
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            thumbImageView.loadImage(URL: url, placeholderImage: nil, completion: nil)
        }
        self.titleLabel.text = article.title
        self.desLabel.text = article.articleDescription
        if let date = article.publishedAt {
            let dat = date.toDate("yyyy-MM-dd'T'HH:mm:ss'Z'")
            timeLabel.setTitle(AppUtils.timeAgoSince(dat?.date ?? Date()), for: .normal)
        }
        
    }
    
    @IBAction func mark(_ sender: Any) {
        
    }
}
