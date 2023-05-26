//
//  CustomSegmentedControl.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import Foundation
import UIKit
//@IBDesignable
class CustomSegmentedControl: UIControl {
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var buttons = [UIButton]()
    var selector: UIView!
    var itemSelected = 0
    var fontSize: CGFloat = 14
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparateButtonTitles: String = ""{
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        subviews.forEach{$0.removeFromSuperview()}
        buttons.removeAll()
        
        let titles = commaSeparateButtonTitles.components(separatedBy: ",")
        for (index,titleString) in titles.enumerated(){
            let button = UIButton(type: .system)
            button.setTitle(titleString, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(self.changeSelection(buttonTapped:)), for: .touchUpInside)
            buttons.append(button)
            
            if index == itemSelected {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                button.setTitleColor(UIColor.link, for: .normal)
            }
            else{
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                button.setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
        
//        self.layoutIfNeeded()
        let selectorWidth = self.frame.width / CGFloat(titles.count)
        let selectorHeight = frame.height - heightSelector
        let xPosition: CGFloat = selectorWidth * CGFloat(itemSelected)
        selector = UIView(frame: CGRect(x: xPosition, y: selectorHeight, width: selectorWidth, height: heightSelector))
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        self.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    @objc func changeSelection(buttonTapped: UIButton) {
        for (index,button) in buttons.enumerated(){
            if buttonTapped == button{
                self.itemSelected = index
                UIView.animate(withDuration: 0.5, animations: {
                    self.selector.frame.origin.x = buttonTapped.frame.origin.x
                    self.selector.frame.size.width = buttonTapped.frame.size.width
                    buttonTapped.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                    button.setTitleColor(UIColor.link, for: .normal)
                })
            }
            else{
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                button.setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    
    func changeSelectionManual(itemSelected: Int) {
        for (index,button) in buttons.enumerated(){
            if index == itemSelected{
                self.itemSelected = index
                UIView.animate(withDuration: 0.5, animations: {
                    self.selector.frame.origin.x = button.frame.origin.x
                    self.selector.frame.size.width = button.frame.size.width
                    button.titleLabel?.font =  UIFont.systemFont(ofSize: 12, weight: .bold)
                    button.setTitleColor(UIColor.link, for: .normal)
                })
            } else {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                button.setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    
    @IBInspectable
    var textColor: UIColor = .darkText{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .blue{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectedTextColor: UIColor = .white{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var heightSelector: CGFloat = 2 {
        didSet{
            updateView()
        }
    }
    
}
