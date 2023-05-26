//
//  WireFrame.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import Foundation
import  UIKit
class WireFrame: WireFrameProtocol {

    static func presentModule(fromView vc: AnyObject) {

        // Generating module components
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view: ViewProtocol = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewProtocol
        let presenter: PresenterProtocol & InteractorOutputProtocol = Presenter()
        let interactor: InteractorInputProtocol = Interactor()
        let wireFrame: WireFrameProtocol = WireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
        
    }
}
