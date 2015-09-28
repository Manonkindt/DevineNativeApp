//
//  CameraView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 04/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit
import Photos
import AFNetworking
import CoreImage

class CameraView: UIView {
    
    let staticView: UIView
    var imageButtonStart = UIButton()
    var sendButtonStart = UIButton()
    var retakeButtonStart = UIButton()
    var buttonImage = UIImage(named: "plus")
    var customFontLabel:UILabel?
    var longFontLabel:UILabel?
    var textFontLabel:UILabel!
    var imageView: UIImageView
    var polaroidView: UIImageView
    var attString:NSMutableAttributedString
    var longString:NSMutableAttributedString
    var smilesCount:Int
    let picView:UIImageView
    var displayLabel:UILabel?


    override init(frame: CGRect) {
        
        println("[CameraView]")
        
        var div = frame.size.height/buttonImage!.size.height
        imageButtonStart = UIButton(frame: CGRectMake(frame.size.width/3 - 10, frame.size.height/2 - 55, frame.size.width/2.5, buttonImage!.size.height/div + 20))
        imageButtonStart.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        
        sendButtonStart = UIButton(frame: CGRectMake(100, 255, 200, 200 ))
        sendButtonStart.setTitle("Send", forState: UIControlState.Normal)
        sendButtonStart.setTitleColor(UIColor(red: 30/255, green: 116/255, blue: 196/255, alpha: 1.0), forState: UIControlState.Normal)
        sendButtonStart.titleLabel?.font = UIFont(name: "EvelethLight", size: 20)
        
        retakeButtonStart = UIButton(frame: CGRectMake(100, 255, 200, 200 ))
        retakeButtonStart.setTitle("Retake", forState: UIControlState.Normal)
        retakeButtonStart.setTitleColor(UIColor(red: 30/255, green: 116/255, blue: 196/255, alpha: 1.0), forState: UIControlState.Normal)
        retakeButtonStart.titleLabel?.font = UIFont(name: "EvelethLight", size: 20)
        
        self.displayLabel = UILabel()
        self.displayLabel!.frame = CGRectMake(10, 390, 200, 200)
        self.displayLabel!.font = UIFont(name: "EvelethLight", size: 50)
        self.displayLabel?.textColor = UIColor(red: 88/255, green: 200/255, blue: 250/255, alpha: 1.0)
        
        let pictureBird = UIImage(named: "pictureBird")
        picView = UIImageView(image: pictureBird)
        picView.frame = CGRectMake(15, frame.size.height - (pictureBird!.size.height + 24), pictureBird!.size.width/2, pictureBird!.size.height/2)
        
        self.smilesCount = Int()
        self.attString = NSMutableAttributedString()
        self.longString = NSMutableAttributedString()
        self.imageView = UIImageView()
        self.polaroidView = UIImageView()
        self.staticView = UIView(frame:frame)
        
        super.init(frame: frame)
    
        sendButtonStart.addTarget(self, action: "post", forControlEvents: UIControlEvents.TouchUpInside)
        
        let currentImage = UIImage(named: "ch1bg")
        let BGView = UIImageView(image: currentImage)
        BGView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        self.addSubview(self.staticView)
        self.staticView.addSubview(BGView)
        self.staticView.addSubview(imageButtonStart)
        self.staticView.addSubview(picView)
        self.addSubview(displayLabel!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadBG(newdata:BadgeData) {
        println("[CameraView] - loadBG")
        
        attString = NSMutableAttributedString(string: newdata.subtitle)
        attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, attString.length))
        customFontLabel = UILabel(frame: CGRectMake(70, 170, 200, 44))
        customFontLabel?.attributedText = attString
        
        customFontLabel!.font = UIFont(name: "BrushUp", size: 30)
        
        displayLabel!.text = "1"
        
        longString = NSMutableAttributedString(string: newdata.Description)
        longString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, longString.length))
        longFontLabel = UILabel(frame: CGRectMake(90, 370, 175, 240))
        longFontLabel!.numberOfLines = 0
        longFontLabel?.attributedText = self.longString
        longFontLabel!.font = UIFont(name: "EvelethLight", size: 20)
        staticView.addSubview(self.longFontLabel!)

        
        self.staticView.addSubview(customFontLabel!)
    }
    
    func saveLala() {
        
        println("save functie")
        self.imageButtonStart.removeFromSuperview()
        
        var fetchOptions: PHFetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        var fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
        
        if (fetchResult.lastObject != nil){
            var lastAsset: PHAsset = fetchResult.lastObject as! PHAsset
            
            PHImageManager.defaultManager().requestImageForAsset(lastAsset, targetSize: frame.size, contentMode: PHImageContentMode.AspectFill, options: PHImageRequestOptions(), resultHandler: {(result, info) -> Void in
                
                self.polaroidView.removeFromSuperview()

                if( result.size.width >= 360){
                
                    if( result.size.width != result.size.height){
                        
                        let imageSize = result.size
                        let width = imageSize.width
                        let height = imageSize.height
                        if (width != height) {
                            let newDimension = min(width, height)
                            let widthOffset = (width - newDimension) / 2
                            let heightOffset = (height - newDimension) / 2
                            
                            UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), false, 0)
                            
                            result == UIGraphicsGetImageFromCurrentImageContext();
                            UIGraphicsEndImageContext();
                        }
                    }
                    
                    
                    self.imageView.image = result
                    self.imageView.frame = CGRectMake( 80, 165, 150, 150)
                    self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
                    let polaroid = UIImage(named: "landscape")
                    self.polaroidView = UIImageView(image: polaroid)
                    self.polaroidView.frame = CGRectMake( 60, 140, polaroid!.size.width/2.5, polaroid!.size.height/1.5)
                    
                     println(self.imageView.image?.imageOrientation.hashValue)
                    
                    self.staticView.addSubview(self.polaroidView)
                    self.staticView.addSubview(self.imageView)
                    self.staticView.bringSubviewToFront(self.picView)
                    

                    self.displayLabel!.text = "2"
                    self.customFontLabel?.removeFromSuperview()
                    self.longFontLabel?.removeFromSuperview()
                    
//                    let context = CIContext(options:[kCIContextUseSoftwareRenderer : true])
//                    let context = CIContext(options: nil)
                    
                    let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
                    
                        let image = CIImage(image: self.imageView.image)
                    
                        let features = detector.featuresInImage(image)
                    
//                        let features = detector.featuresInImage(image, options: [CIDetectorSmile: true,
//                        CIDetectorEyeBlink: true])
                    
                    
                    
                        println(features.count)
                    
                    self.customFontLabel = UILabel(frame: CGRectMake(90, 370, 175, 240))
                    self.customFontLabel!.numberOfLines = 0
                    self.customFontLabel!.font = UIFont(name: "EvelethLight", size: 17)
                    
//                        if(features.count == 0 ) {
//                            
//                            self.attString = NSMutableAttributedString(string: "We didn't detect anyone smiling... Why so serious?")
//                            self.attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, self.attString.length))
//                            self.customFontLabel?.attributedText = self.attString
//                            
//                            let message = "We didn't detect anyone smiling... Why so serious?"
//                            
//                            var popViewController = ChallengePopUpViewController()
//                            popViewController.showInViewFailed(self, withBadge: "badge1", withMessage: message, animated: true)
//
//                            self.staticView.addSubview(self.retakeButtonStart)
//                        } else {
                    
                            self.attString = NSMutableAttributedString(string: "YOU GUYS LOOK HAPPY! WE FOUND \(features.count) LOVING SMILES!")
                            self.attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, self.attString.length))
                            self.customFontLabel?.attributedText = self.attString
                            
                            self.retakeButtonStart.removeFromSuperview()
                            self.staticView.addSubview(self.sendButtonStart)

//                        }
                    
                    self.staticView.addSubview(self.customFontLabel!)

                        for feature in features {
                   
                            var featureBounds = feature.bounds
                        
                            let hasSmile = feature.hasSmile
                            let hasLeftEye = feature.hasLeftEyePosition
                            let hasRightEye = feature.hasRightEyePosition
                            let hasLeftEyeBlink = feature.leftEyeClosed
                            let hasRightEyeBlink = feature.rightEyeClosed
                            
                            var detectionString = "SMILING: \(hasSmile) / LEFT EYE: \(hasLeftEye) / LEFT EYE BLINKING: \(hasLeftEyeBlink) / RIGHT EYE:\(hasRightEye) / RIGHT EYE BLINKING: \(hasRightEyeBlink)"
                            
                            println(detectionString)
                            
                            var startY = self.imageView.bounds.size.height + 40
                        
                            featureBounds.origin.x = feature.bounds.origin.x / 2 - 20
                            featureBounds.origin.y = startY - ( feature.bounds.size.height / 2 ) - (feature.bounds.origin.y / 2)
                            featureBounds.size.width = feature.bounds.size.width / 2
                        
                            featureBounds.size.height = feature.bounds.size.height / 2
                        }
                    
                    self.smilesCount = features.count
                    
                    
                    lastAsset.requestContentEditingInputWithOptions(PHContentEditingInputRequestOptions()) { (input, _) in
                    let fileUrl = input.fullSizeImageURL
                    
                    }
                } else {
                  
                }
            })
        }
    }
    
    func post() {
        println("sended")
            var requestURL = "http://student.howest.be/manon.kindt/20142015/MA4/BADGET/api/images"
        
            if(self.smilesCount == 0){
                self.smilesCount =  self.smilesCount + 1
            }
        
            println( self.smilesCount)
        
            var smiles = self.smilesCount
            
            var image = self.imageView.image
        
            let imageData:NSData = NSData(data:  UIImageJPEGRepresentation(image!, 1.0))
        
        var params = [
            "image" : imageData,
            "smile" : smiles,
            "fieldName": "file"
            
        ]
        
        var error:NSError
        
//        SRWebClient.POST(requestURL, data: params, headers:nil)
//            .send({(response:AnyObject!, status:Int) -> Void in
//                //process success response
//                },failure:{(error:NSError!) -> Void in
//                    println("Error: \(error)")
//            })
        
            SRWebClient.POST("http://student.howest.be/manon.kindt/20142015/MA4/BADGET/api/images")
        .data(imageData, fieldName:"file", data:["days":"1","smiles":String(smiles),"title":"Swift-SRWebClient","caption":"Uploaded via Swift-SRWebClient (https://github.com/sraj/Swift-SRWebClient)"])
                .send({(response:AnyObject!, status:Int) -> Void in
                    //process success response
                    },failure:{(error:NSError!) -> Void in
                        println("Error: \(error)")
                })
        
        let BadgeRetrieved = NSUserDefaults.standardUserDefaults().boolForKey("Badge1")
        if BadgeRetrieved  {
            println("Didn't retrieve")
        }
        else {
            println("Congratulations, You scored Badge 1")
            
            var score = NSUserDefaults.standardUserDefaults().integerForKey("onvoltooid")
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Badge1")
            NSUserDefaults.standardUserDefaults().setInteger(score - 1, forKey: "onvoltooid")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let message = "You unlocked the badge. You need"
            
            var popViewController = ChallengePopUpViewController()
            popViewController.showInViewCompleted(self, withBadge: "badge1", withMessage: message, withImage: image!, withPulse: 0, animated: true)
        }
    }
    
    func enumerateFonts(){
        
        for fontFamily in UIFont.familyNames() {
            
            println("Font family name = \(fontFamily as! String)");
            
            for fontName in UIFont.fontNamesForFamilyName(fontFamily as! String) {
                
                println("- Font name = \(fontName)");
                
            }
            
            println("\n");
            
        }
        
    }


}
