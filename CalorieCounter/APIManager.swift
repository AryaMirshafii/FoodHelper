//
//  APIManager.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 8/7/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIManager{
    private var theURL:String! = "https://trackapi.nutritionix.com/v2/natural/nutrients"
    
    
    
    
    
    
    func search(Query: String) -> DataRequest{
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "x-app-id":"c6b5c1d1",
            "x-app-key":"fa03ba5a62d0ec1fe0b6f4a238c10b6f"
            
        ]
        let parameters:[String: Any]!  = [
            "query": Query,
            "timezone": "US/Eastern"
        ]
        
        
        return Alamofire.request(theURL!,method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            
        }
        

        
        
        
        
        
        
        
    
        
        
    
}
