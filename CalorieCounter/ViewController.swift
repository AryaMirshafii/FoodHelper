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
import SideMenuSwift


class ViewController: UIViewController , UIPopoverPresentationControllerDelegate {

    
    @IBOutlet weak var progressView: NVActivityIndicatorView!
    
    
    
    
    
    
    private var currentFood:FoodItem!
    
    @IBOutlet weak var takePhotoButton: UIButton!
    
    
    @IBOutlet weak var cameraView: UIView!
    
    private let cameraManager = CameraManager()
    private var model: Food101!
    private var apiManager = APIManager()
    private var jsonManager = JsonManager()
    private var dataManager = DataManager()
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle{
        return .none
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCamera()
        model = Food101()
        //setupSideMenu()
        self.navigationController?.navigationBar.backItem?.title = "TEXT1"
        
        
        if(dataManager.foodTableIsEmpty()){
            dataManager.createDummyData()
        }
        
        takePhotoButton.isHidden = false;
        
        definesPresentationContext = true
        
        
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        //model = Food101()
    }
    
    //Takes a photo
    @IBAction func takePhoto(_ sender: Any) {
        
        print("Taking Photo")
        if(!self.apiManager.isConnectedToInternet()){
            performSegue(withIdentifier: "noConnection", sender: self.takePhotoButton)
            return
            
        }
    
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
            
            self.getFoodInfo(foodName: prediction.classLabel)
 
        })
        
 
        print("Took Photo!")
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //Initializes the camera
    private func initCamera(){
        
        cameraManager.addPreviewLayerToView(self.cameraView)
        cameraManager.writeFilesToPhoneLibrary = false
    }
    
    
    
    
    
    
    
    private func getFoodInfo(foodName:String){
        
        
        
            let foodItem = jsonManager.search(query: foodName)
            self.currentFood = foodItem
            //print("Food name is" + foodItem.name)
            self.performSegue(withIdentifier: "showPopup", sender: self.takePhotoButton)
            self.progressView.stopAnimating()
        
           /*
            apiManager.search(Query: foodName) { (foodItem, success) in
                
                if(success){
                    // use data
                    self.currentFood = foodItem
                    //print("Food name is" + foodItem.name)
                    self.performSegue(withIdentifier: "showPopup", sender: self.takePhotoButton)
                    self.progressView.stopAnimating()
                    
                }
            }
        
        */
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        if segue.identifier == "showPopup"{
            
            
            if let nextViewController = segue.destination as? PopupView {
                print("Food name is1" + currentFood.name)
                //nextViewController.foodNameLabel?.text = currentFood.name.uppercased()
                
                nextViewController.modalPresentationStyle = .popover
                nextViewController.popoverPresentationController?.sourceView = sender as! UIButton
                nextViewController.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds
                //nextViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)

                nextViewController.popoverPresentationController?.delegate = self
                nextViewController.foodItem = currentFood
            }
            
                
            
        }else if segue.identifier == "noConnection"{
            if let nextViewController = segue.destination as? UIViewController {
                
                //nextViewController.foodNameLabel?.text = currentFood.name.uppercased()
                
                nextViewController.modalPresentationStyle = .popover
                nextViewController.popoverPresentationController?.sourceView = sender as! UIButton
                nextViewController.popoverPresentationController?.sourceRect = (sender as! UIButton).bounds
                //nextViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                
                nextViewController.popoverPresentationController?.delegate = self
                
            }
        }
        */
    }
    
    
    
    
    
    
    
    
    @IBAction func sideBarComeOut(_ sender: Any) {
        
        
    }
    


}


