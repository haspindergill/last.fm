//
//  Result.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-04.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

enum ResultKeys : String{
    case openSearch = "opensearch:Query"
    case startPage = "startPage"
    case albumMatches = "albummatches"
    case trackMatches = "trackmatches"
    case artistMatches = "artistmatches"
    case artist = "artist"
    case album = "album"
    case track = "track"
    case attributes = "@attr"
    case searchFor = "for"

}


class Result : NSObject {
    var currentPage : Int?
    var SearchAttributes : String?
    var albums = [Artist]()
    var tracks = [Artist]()
    var artists = [Artist]()


    
    
    required init(withAttributes attributes: [String : JSON]?) throws {
         super.init()
            self.artists = Artist.parseArrayinToModal(withAttributes: attributes?[ResultKeys.artistMatches.rawValue]?[ResultKeys.artist.rawValue].arrayValue) as! [Artist]
        self.tracks = Artist.parseArrayinToModal(withAttributes: attributes?[ResultKeys.trackMatches.rawValue]?[ResultKeys.track.rawValue].arrayValue) as! [Artist]
        self.albums = Artist.parseArrayinToModal(withAttributes: attributes?[ResultKeys.albumMatches.rawValue]?[ResultKeys.album.rawValue].arrayValue) as! [Artist]
        self.currentPage = attributes?[ResultKeys.openSearch.rawValue]?[ResultKeys.startPage.rawValue].intValue
        self.SearchAttributes = attributes?[ResultKeys.attributes.rawValue]?[ResultKeys.searchFor.rawValue].stringValue        

    }
    
    
    override init() {
        super.init()
    }
    
}
