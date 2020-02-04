

//
//  UIImageView+Extensions.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  .scaleAspectFit
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
