//
//  ArticleModel.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import Foundation

class ArticleModel: NSObject {
    
    var source : String!
    var author: String!
    var title : String!
    var descript : String!
    var url: String!
    var urlToImage: String!
    var published: String!
    var content: String!
    
    init(dic: Dictionary<String,Any>) {
        print(dic)
        if let source = dic["source"] as? Dictionary<String,Any>{
            self.source = source["name"] as? String ?? ""
        }
        self.author = dic["author"] as? String ?? ""
        self.title = dic["title"] as? String ?? ""
        self.descript = dic["description"] as? String ?? ""
        self.url = dic["url"] as? String ?? ""
        self.urlToImage = dic["urlToImage"] as? String ?? ""
        if let date = dic["publishedAt"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "MM/dd/yyyy"
          //  let dates = dateFormatter.date(from: date)
            //self.published = dateFormatter.string(from: dates)
            self.published = date
        }
        self.content = dic["content"] as? String ?? ""
    }
}
