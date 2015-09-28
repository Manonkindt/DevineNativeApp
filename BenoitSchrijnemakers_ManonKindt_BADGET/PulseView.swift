//
//  PulseView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 05/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

class PulseView: UIView {
    
    let staticView: UIView
    var imageButtonStart = UIButton()
    var sendButtonStart = UIButton()
    var retakeButtonStart = UIButton()
    var buttonImage = UIImage(named: "FingerCam")
    var customFontLabel:UILabel?
    var longFontLabel:UILabel?
    var textFontLabel:UILabel!
    var imageView: UIImageView
    var attString:NSMutableAttributedString
    var longString:NSMutableAttributedString
    var displayLabel:UILabel?
    
    
    override init(frame: CGRect) {
        
        println("[PulseView]")
        
        var div = frame.size.height/buttonImage!.size.height
        imageButtonStart = UIButton(frame: CGRectMake(20, frame.size.height/2 - 62, buttonImage!.size.width/2.3, buttonImage!.size.height/2.3))
        imageButtonStart.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        
        sendButtonStart = UIButton(frame: CGRectMake(0, 240, 200, 200 ))
        sendButtonStart.setTitle("Send", forState: UIControlState.Normal)
        
        retakeButtonStart = UIButton(frame: CGRectMake(0, 240, 200, 200 ))
        retakeButtonStart.setTitle("Retake", forState: UIControlState.Normal)
        
        self.displayLabel = UILabel()
        self.displayLabel?.frame = CGRectMake(20, 245, 200, 200)
        self.displayLabel?.textColor = UIColor(red: 88/255, green: 200/255, blue: 250/255, alpha: 1.0)
        
        self.attString = NSMutableAttributedString()
        self.longString = NSMutableAttributedString()
        self.imageView = UIImageView()
        self.staticView = UIView(frame:frame)
        
        super.init(frame: frame)
        
        let currentImage = UIImage(named: "ch2bg")
        let BGView = UIImageView(image: currentImage)
        BGView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        self.addSubview(self.staticView)
        self.staticView.addSubview(BGView)
//        self.staticView.addSubview(imageButtonStart)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadBG(newdata:BadgeData) {
        println("[CameraView] - loadBG")
        
        attString = NSMutableAttributedString(string: newdata.subtitle)
        attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, attString.length))
        customFontLabel = UILabel(frame: CGRectMake(90, 200, 200, 44))
        customFontLabel?.attributedText = attString
        
        customFontLabel!.font = UIFont(name: "BrushUp", size: 30)
        
        longString = NSMutableAttributedString(string: newdata.Description)
        longString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, longString.length))
        longFontLabel = UILabel(frame: CGRectMake(90, 300, 175, 240))
        longFontLabel!.numberOfLines = 0
        longFontLabel?.attributedText = self.longString
        longFontLabel!.font = UIFont(name: "EvelethLight", size: 20)
        staticView.addSubview(self.longFontLabel!)
        
        self.staticView.addSubview(customFontLabel!)
    }
    
}
