//
//  JsonManager.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 12/14/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class JsonManager{
    
    func search(query: String) -> FoodItem{
        
        print("Food name is " + query)
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newFood = FoodItem(Name: query, insertIntoManagedObjectContext: managedObjectContext)
        
        
        
        do {
            if let file = Bundle.main.url(forResource: query, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    print("Food was sucessfully found and initialized as JSON")
                    //print(object["nf_calories"])
                    
                    if let cals = object["nf_calories"] as? Double{
                        print("Cals is" + String(cals))
                        newFood.calories = cals
                        
                    }else {
                        print("Couldn't convert nf_calories to an Double")
                    }
                    
                    
                    
                    
                    
                    if let cholesterol = object["nf_cholesterol"] as? Double{
                        
                        newFood.cholesterol = cholesterol
                    }else {
                        print("Couldn't convert nf_cholesterol to an Double")
                    }
                    
                    
                    
                    if let dietFiber = object["nf_dietary_fiber"] as? Double{
                        
                         newFood.fiber = dietFiber
                    }else {
                        print("Couldn't convert nf_dietary_fiber to an Double")
                    }
                   
                    
                    
                    
                    
                    if let potass = object["nf_potassium"] as? Double{
                        
                        newFood.potassium = potass
                    }else {
                        print("Couldn't convert nf_potassium to an Double")
                    }
                    
                    
                    
                    
                    
                    if let protein = object["nf_protein"] as? Double{
                        
                        newFood.protein = protein
                    }else {
                        print("Couldn't convert nf_protein to an Double")
                    }
                    
                    
                
                    
                    
                    
                    if let satFat = object["nf_saturated_fat"] as? Double{
                        
                        newFood.saturatedFat = satFat
                    }else {
                        print("Couldn't convert nf_saturated_fat to an Double")
                    }
                   
                    
                    
                    if let sodium = object["nf_sodium"] as? Double{
                        
                        newFood.sodium = sodium
                    }else {
                        print("Couldn't convert nf_sodium to an Double")
                    }
                    
                    
                    
                    if let sugars = object["nf_sugars"] as? Double{
                        
                        newFood.sugars = sugars
                    }else {
                        print("Couldn't convert nf_sodium to an Double")
                    }
                    
                    
                    
                    if let totCarbs = object["nf_total_carbohydrate"] as? Double{
                        
                        newFood.totalCarbs = totCarbs
                    }else {
                        print("Couldn't convert nf_total_carbohydrate to an Double")
                    }
                    
                    
                    
                    if let totFat = object["nf_total_fat"] as? Double{
                        
                        newFood.totalFat = totFat
                    }else {
                        print("Couldn't convert nf_total_fat to an Double")
                    }
                   
                    
                    

                    
                    
                    
                    if(newFood.totalFat != 0 && newFood.saturatedFat != 0){
                        newFood.unsaturatedFat =  newFood.totalFat - newFood.saturatedFat
                        
                    }else if(newFood.totalFat == 0 &&  newFood.saturatedFat != 0){
                        newFood.unsaturatedFat = newFood.saturatedFat
                    }else if(newFood.totalFat != 0 &&  newFood.saturatedFat == 0){
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
