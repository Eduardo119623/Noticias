//
//  Extensions.swift
//  examenPraxis
//
//  Created by Eduardo Zamora on 2/19/20.
//  Copyright © 2020 Eduardo Zamora. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
   /* func imageFromUrl(_ urlString: String?, force: Bool = false, placeholder: UIImage? = nil, key: Int = 0, completion: (() -> ())? = nil) {
           self.tag = key
           self.image = placeholder ?? #imageLiteral(resourceName: "header")
           
           guard let urlStringRemplace = urlString?.replacingOccurrences(of: " ", with: ""), let urlRemplace = URL(string: urlStringRemplace) else {
               return
           }
           
           if force {
            SDImageCache.shared.removeImage(forKey: urlStringRemplace, fromDisk: true)
           }
           
           sd_setImage(with: urlRemplace, placeholderImage: placeholder ?? #imageLiteral(resourceName: "header")) { (image, error, type, url) in
               completion?()
           }
    }*/
    func imageFromUrl(urlString: String, force: Bool, placeholder: UIImage?) {
           let urlStringRemplace = urlString.replacingOccurrences(of: " ", with: "")
           self.image = nil
           MyImageCache.sharedCache.removeObject(forKey: urlStringRemplace as AnyObject)
           self.image = placeholder ?? #imageLiteral(resourceName: "imagePlaceholder")
           if force {
               if let url = URL(string: urlStringRemplace) {
                   URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                       if error != nil {
                           return
                       }
                       DispatchQueue.main.async(execute: { () -> Void in
                           let image = UIImage(data: data!)
                           //                        self.contentMode = .scaleAspectFit
                           self.image = image
                           if(image != nil){
                               MyImageCache.sharedCache.setObject(image!, forKey: urlStringRemplace as AnyObject)
                           }
                       }
                       )
                   }).resume()
               }
           } else {
               if let cachedImage = MyImageCache.sharedCache.object(forKey: urlStringRemplace as AnyObject) as? UIImage {
                   //                self.contentMode = .scaleAspectFit
                   self.image = cachedImage
                   return
               } else {
                   URLSession.shared.dataTask(with: NSURL(string: urlStringRemplace)! as URL, completionHandler: { (data, response, error) -> Void in
                       if error != nil {
                           return
                       }
                       DispatchQueue.main.async(execute: { () -> Void in
                           let image = UIImage(data: data!)
                           //                        self.contentMode = .scaleAspectFit
                           self.image = image
                           if image != nil {
                               MyImageCache.sharedCache.setObject(image!, forKey: urlStringRemplace as AnyObject)
                           }
                       }
                       )
                   }).resume()
               }
           }
       }
}
class MyImageCache: NSObject {
    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "MyImageCache"
        cache.countLimit = 40 // Max 40 images in memory.
        cache.totalCostLimit = 20*1024*1024 // Max 20MB used.
        return cache
    }()
    static let imageCache = NSCache<AnyObject, AnyObject>()
    static var images = Array<UIImage>()
}
