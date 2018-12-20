//
//  FoodItemCell.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 12/14/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import UIKit

class FoodItemCell: UITableViewCell{
    
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodImageView.layer.cornerRadius = foodImageView.frame.width/2
        foodImageView.clipsToBounds = true
        
    }
}
