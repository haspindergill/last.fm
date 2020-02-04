


//
//  Image.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

enum ImageDataKeys : String{
    case link = "#text"
}


class Image : NSObject {
    var link : String?
   

    
    
    required init(withAttributes attributes: [String : JSON]?) throws {
        self.link = ImageDataKeys.link.rawValue => attributes
    }
    
    
    override init() {
        super.init()
    }
    
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var artists : [Image] = []
        guard let attri = attributes else {
            return ([] as AnyObject)
        }
        for dict in attri {
            do {
                let modal =  try Image(withAttributes: dict.dictionaryValue)
                artists.append(modal)
            } catch _ {
            }
        }
        return artists as AnyObject?
    }
}
