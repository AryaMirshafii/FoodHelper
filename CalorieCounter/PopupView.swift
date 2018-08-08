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
        }else if(lowercasedName.contains("cake")){
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
        case "Cannoli":
            foodImageview.image = #imageLiteral(resourceName: "cannoli")
        
        default: break
            //Stopped at carrot cake
        }
            
            
       
        
            
            
        //Just for showing off
        if(lowercasedName == "donuts"){
            foodImageview.image = #imageLiteral(resourceName: "donut")
        }else if(lowercasedName == "pizza" ){
            foodImageview.image = #imageLiteral(resourceName: "pizza")
        }else if(lowercasedName == "grilled salmon"){
            foodImageview.image = #imageLiteral(resourceName: "salmon")
        }else if(lowercasedName == "chicken wings"){
            foodImageview.image = #imageLiteral(resourceName: "wings")
        }else if(lowercasedName == "steak"){
            foodImageview.image = #imageLiteral(resourceName: "steak")
        }
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x/scrollView.frame.width)
        pageIndex.currentPage = Int(pageNumber)
    }
    
    
    
    
}
