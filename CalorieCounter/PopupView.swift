//
//  PopupView.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 8/7/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
class PopupView: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var foodImageview: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet var firstPage: UIView!
    @IBOutlet var secondPage: UIView!
    @IBOutlet var thirdPage: UIView!
    
    
    @IBOutlet weak var pageIndex: UIPageControl!
    
    //Page 1 Labels
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    
    
    
    
    //Page 2 Labels
    @IBOutlet weak var cholesterolLabel: UILabel!
    @IBOutlet weak var saturatedFatLabel: UILabel!
    @IBOutlet weak var unsaturatedFatLabel: UILabel!
    @IBOutlet weak var totalFatLabel: UILabel!
    
    
    //Third Page label
    
    @IBOutlet weak var fiberLabel: UILabel!
    @IBOutlet weak var potassiumLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    
    
    
    
    
    //
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    
    var foodItem: FoodItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 25
        foodImageview.layer.cornerRadius = foodImageview.frame.height/2
        foodImageview.clipsToBounds = true
        //setImage(foodName: foodItem.name)
        //view.clipsToBounds = true
        //self.preferredContentSize = CGSize(width: 340, height: 452)
        
        foodNameLabel.text = foodItem.name.capitalized.replacingOccurrences(of: "_", with: " ")
        setImage(foodName: foodItem.name.capitalized.replacingOccurrences(of: "_", with: " "))
        
        mainScrollView.contentSize = CGSize(width: 3 * mainScrollView.frame.width, height: mainScrollView.frame.height)
        mainScrollView.addSubview(firstPage)
        
        secondPage.frame = CGRect(x: secondPage.frame.width , y: 0, width: secondPage.frame.width, height: secondPage.frame.height)
        mainScrollView.addSubview(secondPage)
        
        thirdPage.frame = CGRect(x: thirdPage.frame.width * 2 , y: 0, width: thirdPage.frame.width, height: thirdPage.frame.height)
        mainScrollView.addSubview(thirdPage)
        
        setLabels()
        mainScrollView.delegate = self
        
        
        
    }
    
    private func setLabels(){
        calorieLabel.text = "Calories: " + foodItem.calories
        carbLabel.text = "Carbohydrates: " + foodItem.totalCarbs
        sodiumLabel.text = "Sodium: " + foodItem.sodium
        sugarLabel.text = "Sugar: " + foodItem.sugars
        
        
        cholesterolLabel.text = "Cholesterol: " + foodItem.cholesterol
        saturatedFatLabel.text = "Sat Fat: " + foodItem.saturatedFat
        unsaturatedFatLabel.text = "Unsat Fat: " + foodItem.unsaturatedFat
        totalFatLabel.text = "Total Fat: " + foodItem.totalFat
        
        fiberLabel.text = "Fiber: " +  foodItem.fiber
        potassiumLabel.text = "Potassium: " + foodItem.potassium
        proteinLabel.text = "Protein: " + foodItem.protein
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    
    
    func getFoodInfo(foodName: String){
        
    }
    
    func setImage(foodName: String){
        if(foodName.isEmpty){
            return
        }
        let lowercasedName  = foodName.lowercased()
        
        
        if(lowercasedName.contains("salad")){
            foodImageview.image = #imageLiteral(resourceName: "salad")
            return;
            
        } else if(lowercasedName.contains("noodle")){
            foodImageview.image = #imageLiteral(resourceName: "Bibimbap")
            return;
        }else if(lowercasedName.contains("cake") && !lowercasedName.contains("cup cake") ){
            foodImageview.image = #imageLiteral(resourceName: "cake")
            return;
        }
        switch lowercasedName{
        case "apple pie":
            foodImageview.image = #imageLiteral(resourceName: "apple-pie")
        case "baby back ribs":
            foodImageview.image = #imageLiteral(resourceName: "ribs")
        case "baklava":
            foodImageview.image = #imageLiteral(resourceName: "baklava")
        case "beef carpaccio":
            foodImageview.image = #imageLiteral(resourceName: "carpaccio")
        case "beef tartare":
            foodImageview.image = #imageLiteral(resourceName: "tartare")
        case "beignets":
            foodImageview.image = #imageLiteral(resourceName: "Beignets")
        case "bibimbap":
            foodImageview.image = #imageLiteral(resourceName: "Bibimbap")
        case "bread pudding":
            foodImageview.image = #imageLiteral(resourceName: "Breadpudding")
        case "breakfast burrito":
            foodImageview.image = #imageLiteral(resourceName: "Breakfastburrito")
        case "bruschetta":
            foodImageview.image = #imageLiteral(resourceName: "bruschetta")
        case "cannoli":
            foodImageview.image = #imageLiteral(resourceName: "cannoli")
        case "ceviche":
            foodImageview.image = #imageLiteral(resourceName: "Ceviche")
        case "cheese plate":
            foodImageview.image = #imageLiteral(resourceName: "cheese")
        case "chicken curry":
            foodImageview.image = #imageLiteral(resourceName: "curry")
        case "chicken quesadilla":
            foodImageview.image = #imageLiteral(resourceName: "quesadilla")
        case "chicken wings":
            foodImageview.image = #imageLiteral(resourceName: "wings")
        case "chocolate mousse":
            foodImageview.image = #imageLiteral(resourceName: "mousse")
        case "churros":
            foodImageview.image = #imageLiteral(resourceName: "churros")
        case "clam chowder":
            foodImageview.image = #imageLiteral(resourceName: "chowder")
        case "club sandwich":
            foodImageview.image = #imageLiteral(resourceName: "sandwich (1)")
        case "crab cakes":
            foodImageview.image = #imageLiteral(resourceName: "crab")
        case "creme brulee":
            foodImageview.image = #imageLiteral(resourceName: "cremebrulee")
        case "croque madame":
            foodImageview.image =  #imageLiteral(resourceName: "Croquemadame")
        case "cup cakes":
            foodImageview.image = #imageLiteral(resourceName: "cupcake")
        case "deviled eggs":
            foodImageview.image = #imageLiteral(resourceName: "Deviledeggs")
        case "donuts":
            foodImageview.image = #imageLiteral(resourceName: "donut")
        case "dumplings":
            foodImageview.image = #imageLiteral(resourceName: "dumpling")
        case "edamame":
            foodImageview.image = #imageLiteral(resourceName: "Edamame")
        case "eggs benedict":
            foodImageview.image = #imageLiteral(resourceName: "Deviledeggs")
        case "escargots":
            foodImageview.image = #imageLiteral(resourceName: "Escargots")
        case "falafel":
            foodImageview.image = #imageLiteral(resourceName: "falafel")
        case "filet mignon":
            foodImageview.image = #imageLiteral(resourceName: "steak")
        case "fish and chips":
            foodImageview.image = #imageLiteral(resourceName: "fish-and-chips")
        case "foie gras":
            foodImageview.image = #imageLiteral(resourceName: "Foiegras")
        case "french fries":
            foodImageview.image = #imageLiteral(resourceName: "fries")
        case "french onion soup":
            foodImageview.image = #imageLiteral(resourceName: "chowder")
        case "french toast":
            foodImageview.image = #imageLiteral(resourceName: "frenchToast")
        case "fried calamari":
            foodImageview.image = #imageLiteral(resourceName: "Friedcalamari")
        case "fried rice":
            foodImageview.image = #imageLiteral(resourceName: "Friedrice")
        case "frozen yogurt":
            foodImageview.image = #imageLiteral(resourceName: "Frozenyogurt")
        case "garlic bread":
            foodImageview.image = #imageLiteral(resourceName: "Garlicbread")
        case "gnocchi":
            foodImageview.image = #imageLiteral(resourceName: "Gnocchi")
        case "grilled cheese sandwich":
            foodImageview.image = #imageLiteral(resourceName: "grilled-sandwich")
        case "grilled salmon":
            foodImageview.image = #imageLiteral(resourceName: "salmon")
        case "guacamole":
            foodImageview.image = #imageLiteral(resourceName: "guacamole")
        case "gyoza":
            foodImageview.image = #imageLiteral(resourceName: "dumpling")
        case "hamburger":
            foodImageview.image = #imageLiteral(resourceName: "burger")
        case "Hot and sour soup":
            foodImageview.image = #imageLiteral(resourceName: "Bibimbap")
        case "hot dog":
            foodImageview.image = #imageLiteral(resourceName: "hot-dog")
        case "huevos rancheros":
            foodImageview.image = #imageLiteral(resourceName: "omelette")
        case "hummus":
            foodImageview.image = #imageLiteral(resourceName: "hummus")
        case "ice cream":
            foodImageview.image = #imageLiteral(resourceName: "ice-cream")
        case "lasagna":
            foodImageview.image = #imageLiteral(resourceName: "lasagna")
        case "lobster bisque":
            foodImageview.image = #imageLiteral(resourceName: "chowder")
        case "lobster roll sandwich":
            foodImageview.image = #imageLiteral(resourceName: "lobsterRoll")
        case "macaroni and cheese":
            foodImageview.image = #imageLiteral(resourceName: "Macaroniandcheese")
        case "macarons":
            foodImageview.image = #imageLiteral(resourceName: "macarons")
        case "miso soup":
            foodImageview.image = #imageLiteral(resourceName: "Bibimbap")
        case "mussels":
            foodImageview.image = #imageLiteral(resourceName: "mussel")
        case "nachos":
            foodImageview.image = #imageLiteral(resourceName: "nachos")
        case "omelette":
            foodImageview.image = #imageLiteral(resourceName: "omelette")
        case "onion rings":
            foodImageview.image = #imageLiteral(resourceName: "onion-rings")
        case "oysters":
            foodImageview.image = #imageLiteral(resourceName: "oyster")
        case "pad thai":
            foodImageview.image = #imageLiteral(resourceName: "pad-thai")
        case "paella":
            foodImageview.image = #imageLiteral(resourceName: "paella")
        case "pancakes":
            foodImageview.image = #imageLiteral(resourceName: "pancakes")
        case "panna cotta":
            foodImageview.image = #imageLiteral(resourceName: "panna-cotta")
        case "peking duck":
            foodImageview.image = #imageLiteral(resourceName: "duck")
        case "pho":
            foodImageview.image = #imageLiteral(resourceName: "Bibimbap")
        case "pizza":
            foodImageview.image = #imageLiteral(resourceName: "pizza")
        case "pork chop":
            foodImageview.image = #imageLiteral(resourceName: "chop")
        
            
            
            
        
        
            
        
            
        
        
        
        default: break
            //Stopped at carrot cake
        }
            
            
       
        
            
            
        //Just for showing off
        if(lowercasedName == "donuts"){
            foodImageview.image = #imageLiteral(resourceName: "donut")
        }else if(lowercasedName == "pizza" ){
            foodImageview.image = #imageLiteral(resourceName: "pizza")
        }else if(lowercasedName == "grilled salmon"){
            
        }else if(lowercasedName == "chicken wings"){
            foodImageview.image = #imageLiteral(resourceName: "wings")
        }else if(lowercasedName == "steak"){
            foodImageview.image = #imageLiteral(resourceName: "steak")
        }
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x/scrollView.bounds.width)
        print("The page number is: " + String(describing: pageNumber))
        pageIndex.currentPage = Int(pageNumber)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x/scrollView.bounds.width)
        let currentPos = CGPoint(x: firstPage.bounds.width * pageNumber, y: 0)
        
        mainScrollView.setContentOffset(currentPos, animated: false)
    }
    
    
    
    
}
