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
    
    
    
    
    
    
    func search(Query: String, completion: @escaping (FoodItem ,Bool) -> Void){
        let headers: HTTPHeaders = [
            "Content-Type":"application/json",
            "x-app-id":"c6b5c1d1",
            "x-app-key":"fa03ba5a62d0ec1fe0b6f4a238c10b6f"
            
        ]
        let parameters:[String: Any]!  = [
            "query": Query,
            "timezone": "US/Eastern"
        ]
        
        
        Alamofire.request(theURL!,method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    //print(response)
                    
                    let JsonData = JSON(response.data)
                    let newFood = FoodItem(Name: Query)
                    
                    
                    
                    
                    newFood.calories = JsonData["foods"][0]["nf_calories"].stringValue
                    newFood.cholesterol = JsonData["foods"][0]["nf_cholesterol"].stringValue
                    newFood.fiber = JsonData["foods"][0]["nf_dietary_fiber"].stringValue
                    newFood.potassium = JsonData["foods"][0]["nf_potassium"].stringValue
                    newFood.protein = JsonData["foods"][0]["nf_protein"].stringValue
                    newFood.saturatedFat = JsonData["foods"][0]["nf_saturated_fat"].stringValue
                    newFood.sodium = JsonData["foods"][0]["nf_sodium"].stringValue
                    
                    newFood.sugars = JsonData["foods"][0]["nf_sugars"].stringValue
                    newFood.totalCarbs = JsonData["foods"][0]["nf_total_carbohydrate"].stringValue
                    newFood.totalFat = JsonData["foods"][0]["nf_total_fat"].stringValue
                    
                    
                    print(JsonData["foods"][0]["nf_calories"].stringValue)
                    
                    /**
                    if let cals = JsonData["foods"][0]["nf_calories"].stringValue{
                        newFood.calories = cals
                    }
                    
                    
                    if let chol = JsonData["foods"][0]["nf_cholesterol"].stringValue {
                        newFood.cholesterol = chol
                    }
                    
                    if let fib = JsonData["foods"][0]["nf_dietary_fiber"].stringValue {
                        newFood.fiber = fib
                    }
                    
                    if let potass = JsonData["foods"][0]["nf_potassium"].stringValue {
                        newFood.potassium = potass
                    }
                    
                    
                    if let prot = JsonData["foods"][0]["nf_protein"].stringValue {
                        newFood.protein = prot
                    }
                    
                    if let satFat = JsonData["foods"][0]["nf_saturated_fat"].string {
                        newFood.saturatedFat = satFat
                    }
                    
                    if let sod = JsonData["foods"][0]["nf_sodium"].string {
                        newFood.sodium = sod
                    }
                    
                    
                    if let sug = JsonData["foods"][0]["nf_sugars"].string{
                        newFood.sugars = sug
                    }
                    
                    if let totCarb = JsonData["foods"][0]["nf_total_carbohydrate"].string{
                        newFood.totalCarbs = totCarb
                    }
                    if let totFat = JsonData["foods"][0]["nf_total_fat"].string {
                        newFood.totalFat = totFat
                    }
                    */
                    
                    
                    if(newFood.totalFat != "N/A" &&  newFood.saturatedFat != "N/A"){
                        newFood.unsaturatedFat =  "\(Double(newFood.totalFat)! - Double(newFood.saturatedFat)!)"
                        
                    }else if(newFood.totalFat == "N/A" &&  newFood.saturatedFat != "N/A"){
                        newFood.unsaturatedFat = newFood.saturatedFat
                    }else if(newFood.totalFat != "N/A" &&  newFood.saturatedFat == "N/A"){
                        newFood.unsaturatedFat = newFood.totalFat
                    }
                    
                    
                    completion(newFood,true)
                }else {
                    print("An error has occured trying to retrieve data from the API")
                    completion(FoodItem(),false)
                }
        }
    }
        

        
        
        
        
        
        
        
    
        
        
    
}
