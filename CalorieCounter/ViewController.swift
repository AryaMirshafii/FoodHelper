//
//  ViewController.swift
//  CalorieCounter
//
//  Created by Arya Mirshafii on 8/7/18.
//  Copyright © 2018 aryaMirshafii. All rights reserved.
//

import UIKit
import AVFoundation
import CameraManager
import CoreML
import SwiftyJSON
import NVActivityIndicatorView

class ViewController: UIViewController {

    @IBOutlet weak var predictionLabel: UILabel!
    
    @IBOutlet weak var progressView: NVActivityIndicatorView!
    
    @IBOutlet weak var previewView: UIView!
    
    
    
    
    
    
    @IBOutlet weak var takePhotoButton: UIButton!
    private let cameraManager = CameraManager()
    private var model: Food101!
    private var apiManager = APIManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        initCamera()
        predictionLabel.text = "";
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        model = Food101()
    }
    
    //Takes a photo
    @IBAction func takePhoto(_ sender: Any) {
        
        print("Taking Photo")
        self.predictionLabel.text = ""
        cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
            // Do something with the image
            
            
            
            
            if(image == nil){
                return;
            }
            
            self.progressView.startAnimating()
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 2.0)
            image?.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
            var pixelBuffer : CVPixelBuffer?
            let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
            guard (status == kCVReturnSuccess) else {
                return
            }
            
            CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
            
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
            
            context?.translateBy(x: 0, y: newImage.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            
            UIGraphicsPushContext(context!)
            newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
            UIGraphicsPopContext()
            CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            //imageView.image = newImage
            
            
            
            guard let prediction = try? self.model.prediction(image: pixelBuffer!) else {
                return
            }
            print("I think this is a \(prediction.classLabel)")
            self.predictionLabel.text = "\(prediction.classLabel)"
            self.getFoodInfo(foodName: prediction.classLabel)
            
            
 
 
        })
 
 
        print("Took Photo!")
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //Initializes the camera
    private func initCamera(){
        
        cameraManager.addPreviewLayerToView(self.previewView)
        cameraManager.writeFilesToPhoneLibrary = false
    }
    
    
    
    
    
    
    
    private func getFoodInfo(foodName: String){
        apiManager.search(Query: foodName).responseJSON { response in
            if response.result.isSuccess {
                
                print(response)
                
                let json = JSON(response.data as Any)
                let calories:String! = json["foods"][0]["nf_calories"].string
                let cholesterol:String! = json["foods"][0]["nf_cholesterol"].string
                let fiber:String! = json["foods"][0]["nf_dietary_fiber"].string
                let potassium:String! = json["foods"][0]["nf_potassium"].string
                let protein:String! = json["foods"][0]["nf_protein"].string
                
                let saturatedFat:String! = json["foods"][0]["nf_saturated_fat"].string
                let sodium:String! = json["foods"][0]["nf_sodium"].string
                let sugars:String! = json["foods"][0]["nf_sugars"].string
                
                
                let totalCarbs:String! = json["foods"][0]["nf_total_carbohydrate"].string
                let totalFat:String! = json["foods"][0]["nf_total_fat"].string
                var unsaturatedFat:String!
                
                if(totalFat != nil &&  saturatedFat != nil){
                    unsaturatedFat =  "\(Double(totalFat!)! - Double(saturatedFat!)!)"

                }else {
                    unsaturatedFat = totalFat
                }
                //let unsaturatedFat:String = String(unsaturatedDouble)B
                
                //print(calories)
                self.progressView.stopAnimating()
                
            }
        }
    }
    
    
    
    
    



}

