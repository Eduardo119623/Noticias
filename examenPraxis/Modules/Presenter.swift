//
//  Presenter.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import Foundation
 
class Presenter: PresenterProtocol,InteractorOutputProtocol {
    
    
    weak var view: ViewProtocol?
    
    var interactor: InteractorInputProtocol?
    
    var wireFrame: WireFrameProtocol?
    
    
    func catchError(error: String) {
        (self.view as! ViewController).showError(error: error)
    }
    func getArticles(control: String){
        (self.interactor as! Interactor).getInfoArticles(control: control)
    }
    func updateView(articles: [ArticleModel]) {
        let view = (self.view as! ViewController)
        view.articles = articles
        view.initView()
        view.contentTableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
    
}
