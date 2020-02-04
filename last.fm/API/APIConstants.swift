//
//  APIConstants.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-04.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import Foundation
internal struct APIConstants {
    
   static let BasePath = "http://ws.audioscrobbler.com/2.0/"
    static let APIKey = "278d90794ea47d5b1a544bcd86a8ce6a"
    static let SearchLimit = "20"
    static let FormatType = "json"
}

internal struct APIMethods {
    
   static let SearchArtist = "artist.search"
    static let SearchTrack = "track.search"
    static let SearchAlbum = "album.search"
}

internal struct APIkeys {
    
   static let API_Key = "api_key"
    static let Limit = "limit"
    static let Page = "page"
    static let Method = "method"
    static let Format = "format"
    static let Album = "album"
    static let Artist = "artist"
    static let Track = "track"

}
