
//
//  Handler.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON

infix operator => //{associativity left precedence 160}

func =>(key : String, json : [String:JSON]?) -> String?{
    return json?[key]?.stringValue
}



protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var method : HTTPMethod { get }
}

enum HTTPMethod : String{
    case GET = "GET"
    case POST = "POST"
}


enum API{
    case Search(search: String,type:Searchtype,pageNumber :String)
}

enum APIResponse {
    case Success(AnyObject?)
    case Failure(String?)
}

// MARK: - Router Protocol

extension API : Router {
  
    var route : String  {
        switch self {
        case .Search(_):
            return ""
        }}
    
   
    
    
    var method : HTTPMethod {
        switch self {
        case .Search(_):
            return .GET
        }
            
    }
    
    var baseURL: String{
        return APIConstants.BasePath
    }
    
    
    func url() -> String {
        switch self {
        case .Search(let search,let type,let page):
            var components = URLComponents(string: baseURL)!
            components.queryItems = [URLQueryItem(name: APIkeys.API_Key, value: APIConstants.APIKey)]
            components.queryItems?.append(URLQueryItem(name: APIkeys.Limit, value: APIConstants.SearchLimit))
            components.queryItems?.append(URLQueryItem(name: APIkeys.Page, value: page))
            switch type{
            case .Album:
                components.queryItems?.append(URLQueryItem(name: APIkeys.Album, value: search))
                components.queryItems?.append(URLQueryItem(name: APIkeys.Method, value: APIMethods.SearchAlbum))
            case .Track:
                components.queryItems?.append(URLQueryItem(name: APIkeys.Track, value: search))
            components.queryItems?.append(URLQueryItem(name: APIkeys.Method, value: APIMethods.SearchTrack))
            case .Artist:
                components.queryItems?.append(URLQueryItem(name: APIkeys.Artist, value: search))
                components.queryItems?.append(URLQueryItem(name: APIkeys.Method, value:APIMethods.SearchArtist))
            }
            components.queryItems?.append(URLQueryItem(name:APIkeys.Format, value: APIConstants.FormatType))
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            return components.url?.absoluteString ?? ""
       
        }
    }
}


// MARK: - Handle API response

// After successfull url request we call handleResponse method to make data in usable form
extension API{
    func handleResponse(parameters : JSON?) -> AnyObject? {
        switch self {
        case .Search(_,let type,_):
            switch type {
            case .Album,.Artist,.Track:
                do { return try Result.init(withAttributes: parameters?["results"].dictionaryValue)}
                catch{
                    return [] as AnyObject
                }
                     }
        }
    
    }

    
}
