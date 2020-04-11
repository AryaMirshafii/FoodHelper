//
//  DataManager.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 12/14/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import CoreData
import UIKit
extension Date {
    func nearestDay() -> Date {
        return Date(timeIntervalSinceReferenceDate:
            (timeIntervalSinceReferenceDate / (24*3600.0)).rounded(.toNearestOrEven) * (24*3600.0))
    }
}
class DataManager{
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let oneDay:TimeInterval = 86400
    private var foodTable = [Date: [FoodItem]]()
    private var jsonManager = JsonManager()
    init(){
        
        getEveryFood()
        
        
        
    }
    
    func foodTableIsEmpty()->Bool{
        managedObjectContext.refreshAllObjects()
        getEveryFood()
        return foodTable.isEmpty
    }
    
    
    func countFoods() -> Int {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodItem")
        let count = try! managedObjectContext.count(for: fetchRequest)
        return count
    }
    
    func getDaysFood()->[FoodItem]{
        
        
        
        if(foodTable.count == 0){
            print("Food table count is 00000")
            getEveryFood()
            return [FoodItem]()
        }
        return foodTable[Date().nearestDay()]!
    }
    
    
    
    /**
    Returns every food ever inputted by the user
    */
    private func getEveryFood(){
        managedObjectContext.refreshAllObjects()
        var everything = [FoodItem]()
        let foodFetch: NSFetchRequest<FoodItem> = FoodItem.fetchRequest() as! NSFetchRequest<FoodItem>
        
        
        do {
            everything = try managedObjectContext.fetch(foodFetch)
        } catch {
            fatalError("Failed to fetch foodItems: \(error)")
        }
        print("The number of foods isss: " + String(everything.count))
        
        for index in 0..<everything.count{
            if(!everything[index].objectID.isTemporaryID){
                //print("Adding food to table")
                if(foodTable[everything[index].dateCreated.nearestDay()] == nil){
                    foodTable[everything[index].dateCreated.nearestDay()] = [FoodItem]()
                }
                foodTable[everything[index].dateCreated.nearestDay()]?.append(everything[index])
            }
            
        }
        
        print("Number of days is: " + String(foodTable.count))
    }
    
    
    func getCalsPerDay() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        //let indx = IndexPath(row: 0, section: 0)
        let date = Date() - 2592000
        let indx = foodTable.index(forKey: date.nearestDay())
        
        for key in foodTable.keys.suffix(from: indx!){
            var total:Double = 0
            for food in foodTable[key]!{
                print("Summing for food name " + food.name)
                print("Summing " + String(food.calories))
                total += food.calories
            }
            //print("THe average calorie count is:" +  String(total))
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    
    
    func getTotalCarbs() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.totalCarbs
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    func getTotalSodium() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.sodium
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    
    
    func getTotalSugar() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.sugars
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    func getTotalCholesterol() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.cholesterol
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    
    func getTotalSatFat() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.saturatedFat
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    func getTotalUnSatFat() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.unsaturatedFat
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    
    
    func getTotalFat() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.totalFat
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    
    func getTotalFiber() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.fiber
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    
    func getPotassium() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.potassium
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    func getProtein() -> [Date: Double]{
        var toReturn =  [Date: Double]()
        
        for key in foodTable.keys{
            var total:Double = 0
            for food in foodTable[key]!{
                total += food.protein
            }
            toReturn[key] = total
        }
        
        return toReturn
    }
    
    
    func readLabel(index:Int) ->FoodItem{
        var foodNames = ["Apple pie","Baby back ribs","Baklava","Beef carpaccio","Beef tartare","Beet salad","Beignets","Bibimbap","Bread pudding","Breakfast burrito","Bruschetta","Caesar salad","Cannoli","Caprese salad","Carrot cake","Ceviche","Cheesecake","Cheese plate","Chicken curry","Chicken quesadilla","Chicken wings","Chocolate cake","Chocolate mousse","Churros","Clam chowder","Club sandwich","Crab cakes","Creme brulee","Croque madame","Cup cakes","Deviled eggs","Donuts","Dumplings","Edamame","Eggs benedict","Escargots","Falafel","Filet mignon","Fish and chips","Foie gras","French fries","French onion soup","French toast","Fried calamari","Fried rice","Frozen yogurt","Garlic bread","Gnocchi","Greek salad","Grilled cheese sandwich","Grilled salmon","Guacamole","Gyoza","Hamburger","Hot and sour soup","Hot dog","Huevos rancheros","Hummus","Ice cream","Lasagna","Lobster bisque","Lobster roll sandwich","Macaroni and cheese","Macarons","Miso soup","Mussels","Nachos","Omelette","Onion rings","Oysters","Pad thai","Paella","Pancakes","Panna cotta","Peking duck","Pho","Pizza","Pork chop","Poutine","Prime rib","Pulled pork sandwich","Ramen","Ravioli","Red velvet cake","Risotto","Samosa","Sashimi","Scallops","Seaweed salad","Shrimp and grits","Spaghetti bolognese","Spaghetti carbonara","Spring rolls","Steak","Strawberry shortcake","Sushi","Tacos","Takoyaki","Tiramisu","Tuna tartare","Waffles"]
        return jsonManager.search(query: foodNames[index].lowercased().replacingOccurrences(of:  " " , with: "_"))
        
    }
    
    func createDummyData(){
        print("Creating dummy data....")
        
        let nineMonths:TimeInterval = 23328000 // Nine months to seconds
        //One day to seconds
        let lunch:TimeInterval = 43200
        let dinner:TimeInterval = 43200/2
        var date = Date() - nineMonths
        

        
        
        
        //print("Foods length is: " + String(foods.count))
        
        var count:Int = 0
        while(date <= Date()){
            var randomInt = Int.random(in: 0..<101)
            let food1 = readLabel(index: randomInt)
            food1.dateCreated = date;
            print("Food 1 calories is : " + String(food1.calories))
            food1.save()
            if(foodTable[date.nearestDay()] == nil){
                foodTable[date.nearestDay()] = [FoodItem]()
            }
            foodTable[date.nearestDay()]?.append(food1)
            
            randomInt = Int.random(in: 0..<101)
            date += lunch
            
            let food2 = readLabel(index: randomInt)
            food2.dateCreated = date;
            food2.save()
            
            if(foodTable[date.nearestDay()] == nil){
                foodTable[date.nearestDay()] = [FoodItem]()
            }
            foodTable[date.nearestDay()]?.append(food2)
            randomInt = Int.random(in: 0..<101)
            let food3 = readLabel(index: randomInt)
            food3.dateCreated = date;
            food3.save()
            
            
            if(foodTable[date.nearestDay()] == nil){
                foodTable[date.nearestDay()] = [FoodItem]()
            }
            foodTable[date.nearestDay()]?.append(food3)
            date += dinner
            randomInt = Int.random(in: 0..<101)
            let food4 = readLabel(index: randomInt)
            food4.dateCreated = date;
            food4.save()
            
            if(foodTable[date.nearestDay()] == nil){
                foodTable[date.nearestDay()] = [FoodItem]()
            }
            foodTable[date.nearestDay()]?.append(food4)
            
            count += 4
            date += dinner
        }
        
        print("Done creating data")
        
        print("Created " + String(count) + " entries...")
        
    }
    
    
}
