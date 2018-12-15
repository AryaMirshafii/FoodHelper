//
//  JsonManager.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 12/14/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation

class JsonManager{
    
    func search(query: String) -> FoodItem{
        let newFood = FoodItem(Name: query)
        do {
            if let file = Bundle.main.url(forResource: query, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    print("Food was sucessfully found and initialized as JSON")
                    
                    newFood.calories = String(format: "%.1f",object["nf_calories"] as! Double)
                    newFood.cholesterol = String(format: "%.1f",object["nf_cholesterol"] as! Double)
                    newFood.fiber = String(format: "%.1f", object["nf_dietary_fiber"] as! Double)
                    newFood.potassium = String(format: "%.1f", object["nf_potassium"] as! Double)
                    newFood.protein = String(format: "%.1f", object["nf_protein"] as! Double)
                    newFood.saturatedFat = String(format: "%.1f", object["nf_saturated_fat"] as! Double)
                    newFood.sodium = String(format: "%.1f", object["nf_sodium"] as! Double)
                    
                    newFood.sugars = String(format: "%.1f", object["nf_sugars"] as! Double)
                    newFood.totalCarbs = String(format: "%.1f", object["nf_total_carbohydrate"] as! Double)
                    newFood.totalFat = String(format: "%.1f", object["nf_total_fat"] as! Double)
                    
                    if(newFood.totalFat != "N/A" &&  newFood.saturatedFat != "N/A"){
                        newFood.unsaturatedFat =  "\(Double(newFood.totalFat)! - Double(newFood.saturatedFat)!)"
                        
                    }else if(newFood.totalFat == "N/A" &&  newFood.saturatedFat != "N/A"){
                        newFood.unsaturatedFat = newFood.saturatedFat
                    }else if(newFood.totalFat != "N/A" &&  newFood.saturatedFat == "N/A"){
                        newFood.unsaturatedFat = newFood.totalFat
                    }
                    //print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file found")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return newFood
    }
}
