//
//  Header.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import UIKit

class Header: UIView {

    @IBOutlet var contentView: UIView!
    
    
    //MARK: - Init
       override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           self.commonInit()
       }
       
       private func commonInit() {
           _ = Bundle.main.loadNibNamed("Header", owner: self, options: nil)
           self.addSubview(contentView)
           self.contentView.frame = self.bounds
       }
}
