//
//  Protocols.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import Foundation

protocol ViewProtocol: class {
    var presenter: PresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol WireFrameProtocol: class {
    static func presentModule(fromView vc: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol PresenterProtocol: class {
    var view: ViewProtocol? { get set }
    var interactor: InteractorInputProtocol? { get set }
    var wireFrame: WireFrameProtocol? { get set }
   
    func catchError(error: String)
}

protocol InteractorOutputProtocol: class {
   
}

protocol InteractorInputProtocol: class
{
    var presenter: InteractorOutputProtocol? { get set }
    
     func catchError(error: String)
}

