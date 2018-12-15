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
import SideMenu


class ViewController: UIViewController , UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var predictionLabel: UILabel!
    
    @IBOutlet weak var progressView: NVActivityIndicatorView!
    
    @IBOutlet weak var previewView: UIView!
    
    
    
    
    private var currentFood:FoodItem!
    
    @IBOutlet weak var takePhotoButton: UIButton!
    private let cameraManager = CameraManager()
    private var model: Food101!
    private var apiManager = APIManager()
    private var jsonManager = JsonManager()
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle{
        return .none
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCamera()
        predictionLabel.text = "";
        model = Food101()
        setupSideMenu()
        
        
    }
    
    
    func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        //SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        // Set up a cool background image for demo purposes
        //SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
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
    }
    
    
    
    
    



}


extension ViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
    
}

