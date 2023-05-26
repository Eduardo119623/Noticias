//
//  Interactor.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import Foundation
class Interactor: InteractorInputProtocol {
    
    
   weak var presenter: InteractorOutputProtocol?
    
    var articles: [ArticleModel]!
    
    func catchError(error: String) {
        (self.presenter as! Presenter).catchError(error: error)
    }
    
    func getInfoArticles(control: String) {
        let service = "http://newsapi.org/v2/\(control)&apiKey=09215dc0c347483b938bfd6797564308"
        print(service)
        ServiceManager().requestGet(url: service, correctAnswerHandler: correctGetInfoArticles(dic:), incorrectAnswerHandler: catchError(error:))
    }
    func correctGetInfoArticles(dic: Dictionary<String,Any>) {
        if let articles = dic["articles"] as? Array<Dictionary<String,Any>> {
            self.articles = Array()
            for article in articles {
                self.articles.append(ArticleModel(dic: article))
            }
            (self.presenter as! Presenter).updateView(articles: self.articles)
        }
    }
}
