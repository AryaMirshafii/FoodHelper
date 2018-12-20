//
//  TodaysFoodView.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 12/14/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import UIKit

class TodaysFoodView: UITableViewController{
    
    private var foods = [FoodItem]()
    private var dataManager:DataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dataManager.createDummyData()
        
        dataManager = DataManager()
        foods = dataManager.getDaysFood()
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        return foods.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodItem = foods[indexPath.row]
        let cellIdentifier = "FoodItemCell"
        self.tableView.rowHeight = 75
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodItemCell  else {
            fatalError("The dequeued cell is not an instance of AlbumTableCell.")
        }
        
        cell.foodImageView.image = setImage(foodName: foodItem.name)
        //print("Food item is named: " + foodItem.name)
        cell.foodNameLabel.text = foodItem.name.replacingOccurrences(of: "_", with: " ").capitalized
        
        return cell
    }
    
    
    
    func setImage(foodName: String) -> UIImage{
        if(foodName.isEmpty){
            print("Food name is empty")
            return UIImage()
        }
        let lowercasedName  = foodName.lowercased().replacingOccurrences(of: "_", with: " ")
        
        
        if(lowercasedName.contains("salad")){
           return  #imageLiteral(resourceName: "salad")
            
            
        } else if(lowercasedName.contains("noodle")){
           return  #imageLiteral(resourceName: "Bibimbap")
            
        }else if(lowercasedName.contains("cake") && !lowercasedName.contains("cup cake") ){
           return  #imageLiteral(resourceName: "cake")
            
        }
        switch lowercasedName{
        case "apple pie":
           return  #imageLiteral(resourceName: "apple-pie")
        case "baby back ribs":
           return  #imageLiteral(resourceName: "ribs")
        case "baklava":
           return  #imageLiteral(resourceName: "baklava")
        case "beef carpaccio":
           return  #imageLiteral(resourceName: "carpaccio")
        case "beef tartare":
           return  #imageLiteral(resourceName: "tartare")
        case "beignets":
           return  #imageLiteral(resourceName: "Beignets")
        case "bibimbap":
           return  #imageLiteral(resourceName: "Bibimbap")
        case "bread pudding":
           return  #imageLiteral(resourceName: "Breadpudding")
        case "breakfast burrito":
           return  #imageLiteral(resourceName: "Breakfastburrito")
        case "bruschetta":
           return  #imageLiteral(resourceName: "bruschetta")
        case "cannoli":
           return  #imageLiteral(resourceName: "cannoli")
        case "ceviche":
           return  #imageLiteral(resourceName: "Ceviche")
        case "cheese plate":
           return  #imageLiteral(resourceName: "cheese")
        case "chicken curry":
           return  #imageLiteral(resourceName: "curry")
        case "chicken quesadilla":
           return  #imageLiteral(resourceName: "quesadilla")
        case "chicken wings":
           return  #imageLiteral(resourceName: "wings")
        case "chocolate mousse":
           return  #imageLiteral(resourceName: "mousse")
        case "churros":
           return  #imageLiteral(resourceName: "churros")
        case "clam chowder":
           return  #imageLiteral(resourceName: "chowder")
        case "club sandwich":
           return  #imageLiteral(resourceName: "sandwich (1)")
        case "crab cakes":
           return  #imageLiteral(resourceName: "crab")
        case "creme brulee":
           return  #imageLiteral(resourceName: "cremebrulee")
        case "croque madame":
           return   #imageLiteral(resourceName: "Croquemadame")
        case "cup cakes":
           return  #imageLiteral(resourceName: "cupcake")
        case "deviled eggs":
           return  #imageLiteral(resourceName: "Deviledeggs")
        case "donuts":
           return  #imageLiteral(resourceName: "donut")
        case "dumplings":
           return  #imageLiteral(resourceName: "dumpling")
        case "edamame":
           return  #imageLiteral(resourceName: "Edamame")
        case "eggs benedict":
           return  #imageLiteral(resourceName: "Deviledeggs")
        case "escargots":
           return  #imageLiteral(resourceName: "Escargots")
        case "falafel":
           return  #imageLiteral(resourceName: "falafel")
        case "filet mignon":
           return  #imageLiteral(resourceName: "steak")
        case "fish and chips":
           return  #imageLiteral(resourceName: "fish-and-chips")
        case "foie gras":
           return  #imageLiteral(resourceName: "Foiegras")
        case "french fries":
           return  #imageLiteral(resourceName: "fries")
        case "french onion soup":
           return  #imageLiteral(resourceName: "chowder")
        case "french toast":
           return  #imageLiteral(resourceName: "frenchToast")
        case "fried calamari":
           return  #imageLiteral(resourceName: "Friedcalamari")
        case "fried rice":
           return  #imageLiteral(resourceName: "Friedrice")
        case "frozen yogurt":
           return  #imageLiteral(resourceName: "Frozenyogurt")
        case "garlic bread":
           return  #imageLiteral(resourceName: "Garlicbread")
        case "gnocchi":
           return  #imageLiteral(resourceName: "Gnocchi")
        case "grilled cheese sandwich":
           return  #imageLiteral(resourceName: "grilled-sandwich")
        case "grilled salmon":
           return  #imageLiteral(resourceName: "salmon")
        case "guacamole":
           return  #imageLiteral(resourceName: "guacamole")
        case "gyoza":
           return  #imageLiteral(resourceName: "dumpling")
        case "hamburger":
           return  #imageLiteral(resourceName: "burger")
        case "hot and sour soup":
           return  #imageLiteral(resourceName: "Bibimbap")
        case "hot dog":
           return  #imageLiteral(resourceName: "hot-dog")
        case "huevos rancheros":
           return  #imageLiteral(resourceName: "omelette")
        case "hummus":
           return  #imageLiteral(resourceName: "hummus")
        case "ice cream":
           return  #imageLiteral(resourceName: "ice-cream")
        case "lasagna":
           return  #imageLiteral(resourceName: "lasagna")
        case "lobster bisque":
           return  #imageLiteral(resourceName: "chowder")
        case "lobster roll sandwich":
           return  #imageLiteral(resourceName: "lobsterRoll")
        case "macaroni and cheese":
           return  #imageLiteral(resourceName: "Macaroniandcheese")
        case "macarons":
           return  #imageLiteral(resourceName: "macarons")
        case "miso soup":
           return  #imageLiteral(resourceName: "Bibimbap")
        case "mussels":
           return  #imageLiteral(resourceName: "mussel")
        case "nachos":
           return  #imageLiteral(resourceName: "nachos")
        case "omelette":
           return  #imageLiteral(resourceName: "omelette")
        case "onion rings":
           return  #imageLiteral(resourceName: "onion-rings")
        case "oysters":
           return  #imageLiteral(resourceName: "oyster")
        case "pad thai":
           return  #imageLiteral(resourceName: "pad-thai")
        case "paella":
           return  #imageLiteral(resourceName: "paella")
        case "pancakes":
           return  #imageLiteral(resourceName: "pancakes")
        case "panna cotta":
           return  #imageLiteral(resourceName: "panna-cotta")
        case "peking duck":
           return  #imageLiteral(resourceName: "duck")
        case "pho":
           return  #imageLiteral(resourceName: "Bibimbap")
        case "pizza":
           return  #imageLiteral(resourceName: "pizza")
        case "pork chop":
           return  #imageLiteral(resourceName: "chop")
        case "poutine":
           return  #imageLiteral(resourceName: "Poutine")
        case "prime rib":
           return  #imageLiteral(resourceName: "Primerib")
        case "pulled pork sandwich":
           return  #imageLiteral(resourceName: "pork")
        case "ramen":
           return  #imageLiteral(resourceName: "Bibimbap")
        case "ravioli":
           return  #imageLiteral(resourceName: "ravioli")
        case "risotto":
           return  #imageLiteral(resourceName: "risotto")
        case "samosa":
           return  #imageLiteral(resourceName: "samosa")
        case "sashimi":
           return  #imageLiteral(resourceName: "sashimi")
        case "scallops":
           return  #imageLiteral(resourceName: "scallop")
        case "shrimp and grits":
           return  #imageLiteral(resourceName: "paella")
        case "spaghetti bolognese":
           return  #imageLiteral(resourceName: "spaghetti")
        case "spaghetti carbonara":
           return  #imageLiteral(resourceName: "spaghetti")
        case "spring rolls":
           return  #imageLiteral(resourceName: "spring-rolls")
        case "steak":
           return  #imageLiteral(resourceName: "steak")
        case "sushi":
           return  #imageLiteral(resourceName: "sushi")
        case "tacos":
           return  #imageLiteral(resourceName: "taco")
        case "takoyaki":
           return  #imageLiteral(resourceName: "takoyaki")
        case "tiramisu":
           return  #imageLiteral(resourceName: "tiramisu")
        case "tuna tartare":
           return  #imageLiteral(resourceName: "Tunatartare")
        case "waffles":
           return  #imageLiteral(resourceName: "waffle")
            
        default: break
            //Stopped at carrot cake
        }
        
        return UIImage()
        
    }
}
