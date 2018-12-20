//
//  FoodItem.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 8/7/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

@objc(FoodItem)
public class FoodItem :NSManagedObject {
    @NSManaged var name:String
    
    
    @NSManaged var calories:Double
    @NSManaged var totalCarbs:Double
    @NSManaged var sodium:Double
    @NSManaged var sugars:Double
    
    
    @NSManaged var cholesterol:Double
    @NSManaged var saturatedFat:Double
    @NSManaged var unsaturatedFat:Double
    @NSManaged var totalFat:Double
    
    
    
    @NSManaged var fiber:Double
    @NSManaged var potassium:Double
    @NSManaged var protein:Double
    @NSManaged var dateCreated:Date
    
    private var context: NSManagedObjectContext!
    
    
    
    
    
    
    convenience init(Name: String, insertIntoManagedObjectContext objectContext: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "FoodItem", in: objectContext)!
        self.init(entity: entity, insertInto: objectContext)
        self.calories = 0
        self.totalCarbs = 0
        self.sodium = 0
        self.sugars = 0
        self.cholesterol = 0
        self.saturatedFat = 0
        self.unsaturatedFat = 0
        self.totalFat = 0
        self.fiber = 0
        self.potassium = 0
        self.protein = 0
        self.dateCreated = Date()
        
        
        
        
        
        if(!Name.isEmpty){
            self.name = Name
          
        }
        
        
    }
    
    func setDateCreated(date: Date){
        self.dateCreated = date
        self.save()
    }
    
    
    
    
    func save(){
        self.setValue(self.name, forKey: "name")
        self.setValue(self.calories, forKey: "calories")
        self.setValue(self.totalCarbs, forKey: "totalCarbs")
        self.setValue(self.sodium, forKey: "sodium")
        self.setValue(self.sugars, forKey: "sugars")
        self.setValue(self.cholesterol, forKey: "cholesterol")
        self.setValue(self.saturatedFat, forKey: "saturatedFat")
        self.setValue(self.unsaturatedFat, forKey: "unsaturatedFat")
        self.setValue(self.fiber, forKey: "fiber")
        self.setValue(self.potassium, forKey: "potassium")
        self.setValue(self.protein, forKey: "protein")
        self.setValue(self.dateCreated, forKey: "dateCreated")
        
        if(context == nil){
            context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        }
        do {
            
            context.insert(self)
            try context.save()
            context.refreshAllObjects()
            
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    func delete(){
        context.delete(self)
        
        do {
            try context.save()
        } catch {
            print("failed to delete")
        }
    }
}
