//
//  ViewController.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ViewProtocol {
    var presenter: PresenterProtocol?
    

    @IBOutlet weak var segment: CustomSegmentedControl!
    @IBOutlet weak var contentTableView: UITableView!
    
    var articles: [ArticleModel]!
    var control: String = "everything?q=bitcoin&from=2020-01-20&sortBy=publishedAt"
    
    
    @IBAction func changeViewAction(_ sender: CustomSegmentedControl) {
        switch sender.itemSelected {
        case 0:
            self.control = "everything?q=bitcoin&from=2020-01-20&sortBy=publishedAt"
        case 1:
            self.control = "top-headlines?country=us&category=business"
        case 2:
            self.control = "everything?q=apple&from=2020-02-19&to=2020-02-19&sortBy=popularity"
        case 3:
            self.control = "top-headlines?sources=techcrunch"
        case 4:
            self.control = "everything?domains=wsj.com"
        default:
            print("no selected")
        }
        (self.presenter as! Presenter).getArticles(control: self.control)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initModule()
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.contentTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
         //self.segment.iconsNameSeparatedByComma = "VIEW1,VIEW2,VIEW3,VIEW5,VIEW5"
        self.contentTableView.separatorStyle = .none
        (self.presenter as! Presenter).getArticles(control: self.control)
        // Do any additional setup after loading the view.
    }
    func initView() {
       
    }
    func showError(error: String){
        print(error)
    }
    func initModule(){
    let presenter: PresenterProtocol & InteractorOutputProtocol = Presenter()
    let interactor: InteractorInputProtocol = Interactor()
    let wireFrame: WireFrameProtocol = WireFrame()
    // Connecting
    self.presenter = presenter
    presenter.view = self
    presenter.wireFrame = wireFrame
    presenter.interactor = interactor
    interactor.presenter = presenter
               
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articles != nil {
            return articles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.selectionStyle = .none
        cell.initCell(article: self.articles[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = Header()
        return head
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
}
