
//
//  Artist.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

enum ArtistDataKeys : String{
    case name = "name"
    case artist = "artist"
    case listeners = "listeners"
    case url = "url"
    case streamable = "streamable"
}


class Artist : NSObject {
    var name : String?
    var image : [Image]?
    var artist : String?
    var listeners : String?
    var url : String?
    var streamable : String?

    
    
    required init(withAttributes attributes: [String : JSON]?) throws {
        self.name = ArtistDataKeys.name.rawValue => attributes
        self.artist = ArtistDataKeys.artist.rawValue => attributes
        self.listeners = ArtistDataKeys.listeners.rawValue => attributes
        self.url = ArtistDataKeys.url.rawValue => attributes
        self.image = Image.parseArrayinToModal(withAttributes: attributes?["image"]?.arrayValue) as? [Image]
        self.streamable = ArtistDataKeys.streamable.rawValue => attributes
    }
    
    
    override init() {
        super.init()
    }
    
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var artists : [Artist] = []
        guard let attri = attributes else {
            return ([] as AnyObject)
        }
        for dict in attri {
            do {
                let modal =  try Artist(withAttributes: dict.dictionaryValue)
                artists.append(modal)
            } catch _ {
            }
        }
        return artists as AnyObject?
    }
    
}
