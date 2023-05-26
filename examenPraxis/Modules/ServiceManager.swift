//
//  ServiceManager.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ServiceManager {
    
    typealias MethodHandler1 = (_ sampleParameter : Dictionary<String,Any>)  -> Void
      typealias MethodHandler2 = (_ sampleParameter : String)  -> Void
    
     let timeInterval = 30.0
     
        fileprivate func handle(json: Dictionary<String,Any>,response: HTTPURLResponse? ,_ correctAnswerHandler: @escaping MethodHandler1, _ incorrectAnswerHandler: @escaping MethodHandler2) {
            switch response?.statusCode {
            case 401:
                print("401")
            case 402:
               print("402")
            case 200:
              correctAnswerHandler(json)
            case 541:
                print("541")
            case 520:

               print("520")

            default:
                incorrectAnswerHandler(String(describing: response?.statusCode))
            }

        }

        
    func requestGet(url:String, correctAnswerHandler: @escaping MethodHandler1, incorrectAnswerHandler: @escaping MethodHandler2) {
           let urlRequest:URL = URL(string:url)!
           var request:URLRequest = URLRequest(url: urlRequest)
           request.httpMethod = "GET"
           request.timeoutInterval = self.timeInterval
        URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            guard let dataResponse = data,
                   error == nil else {
                   print(error?.localizedDescription ?? "Response Error")
                   return }
             do{
                 let jsonResponse = try JSONSerialization.jsonObject(with:
                                        dataResponse, options: [])
                 self.handle(json: (jsonResponse as? Dictionary<String,Any>)!, response: (response as! HTTPURLResponse), correctAnswerHandler, incorrectAnswerHandler)
              } catch let parsingError {
                 print("Error", parsingError)
            }

        }

            }.resume()
           
       }
    
}
