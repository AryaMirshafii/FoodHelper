//
//  ChartViewController.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 12/16/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartViewController:UIViewController{
    
    @IBOutlet weak var lineChart: LineChartView!
    
    var dataController: DataManager!
    
    var dateStrings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = DataManager()
        
        
        setLineChart()
        
    
        
        
        
    }
    
    
    private func getLineData(foods: [FoodItem]) -> LineChartDataSet{
        var chartData = [ChartDataEntry]()
        var xCount:Double = 0;
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        for food in foods{
            dateStrings.append(formatter.string(from: food.dateCreated))
            chartData.append(ChartDataEntry(x: xCount, y: food.calories))
            xCount += 1
            
        }
        return LineChartDataSet(values: chartData, label: "Calories")
    }
    
    
    private func setLineChart(){
        
        let datSet = getLineData(foods: dataController.getDaysFood())
        self.lineChart.xAxis.labelRotationAngle = -75
        self.lineChart.xAxis.valueFormatter = DefaultAxisValueFormatter(block: {(index, _) in
            return self.dateStrings[Int(index)]
        })
        datSet.valueTextColor = UIColor.white
        lineChart.data = LineChartData(dataSet: datSet)
        lineChart.notifyDataSetChanged()
        
        
    }
}
