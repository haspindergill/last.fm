
//
//  APIManager.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import Foundation
import SwiftyJSON
typealias APICompletion = (APIResponse) -> ()

class APIManager: NSObject {
    
    
    func opertationWithRequest ( withApi api : API , completion : @escaping APICompletion )  {
        let request = URLRequest(url:URL(string:api.url())!)
        _ = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                completion(.Failure(error?.localizedDescription))
                return
            }
           do{

                 //here dataResponse received from a network request
                 let jsonResponse = try JSONSerialization.jsonObject(with:data, options: [])
            let json = JSON(jsonResponse)

              //print(json) //Response result
           completion(.Success(api.handleResponse(parameters:json)))

              } catch let parsingError {
                 print("Error", parsingError)
            }


        }.resume()

    }

}
