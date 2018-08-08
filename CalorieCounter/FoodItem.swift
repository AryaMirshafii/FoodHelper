//
//  FoodItem.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 8/7/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import SwiftyJSON

class FoodItem {
    var name:String = "N/A"
    
    
    var calories:String = "N/A"
    var totalCarbs:String = "N/A"
    var sodium:String = "N/A"
    var sugars:String = "N/A"
    
    
    var cholesterol:String = "N/A"
    var saturatedFat:String = "N/A"
    var unsaturatedFat:String = "N/A"
    var totalFat:String = "N/A"
    
    
    
    var fiber:String = "N/A"
    var potassium:String = "N/A"
    var protein:String = "N/A"
    
    
    
    
    
    
    
    init(Name: String) {
        if(!Name.isEmpty){
            self.name = Name
        }
        
        
    }
    init(){
        
    }
}
