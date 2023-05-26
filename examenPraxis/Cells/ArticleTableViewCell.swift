//
//  ArticleTableViewCell.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var urlToOpen: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(article: ArticleModel) {
        
        self.sourceLabel.text = article.source
        self.authorLabel.text = article.author
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.descript
        self.urlLabel.text = article.url
        self.urlToOpen = article.url
        self.contentLabel.text = article.content
        self.articleImage.imageFromUrl(urlString: article.urlToImage, force: true, placeholder: #imageLiteral(resourceName: "splash"))
        self.dateLabel.text = article.published
        let tap = UITapGestureRecognizer(target: self, action: #selector(urlTap(_:)))
        tap.numberOfTapsRequired = 1
        self.urlLabel.isUserInteractionEnabled = true
        self.urlLabel.addGestureRecognizer(tap)
    }
    @objc func urlTap(_: UITapGestureRecognizer){
        if let url = URL(string: self.urlToOpen) {
            UIApplication.shared.open(url)
        }
    }
}
