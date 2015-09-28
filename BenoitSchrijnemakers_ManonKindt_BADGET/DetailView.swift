//
//  DetailView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 28/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

class DetailView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let scrollView:UIScrollView
    let staticView: UIView
    var imageButtonStart = UIImage(named: "tap")
    var textField:UITextField?
    var sendButtonStart = UIButton()
    var SendText:String
    var NumberFromTheKeyboard:String
    let buttonView:UIImageView
    var customFontLabel:UILabel?
    var attString:NSMutableAttributedString
    var displayLabel:UILabel?
    
    weak var delegate:PulseDetailDelegate?
    
    override init(frame: CGRect) {
        
        self.staticView = UIView(frame:frame)
        self.scrollView = UIScrollView(frame: frame)
        buttonView = UIImageView(image: imageButtonStart)
        self.SendText = String()
        self.NumberFromTheKeyboard = String()
        
        attString = NSMutableAttributedString()
        
        sendButtonStart = UIButton(frame: CGRectMake(50, 240, 200, 200 ))
        sendButtonStart.setTitle("NEXT", forState: UIControlState.Normal)
        sendButtonStart.setTitleColor(UIColor(red: 30/255, green: 116/255, blue: 196/255, alpha: 1.0), forState: UIControlState.Normal)
        sendButtonStart.titleLabel?.font = UIFont(name: "EvelethLight", size: 30)
        sendButtonStart.userInteractionEnabled = true
        
        super.init(frame: frame)
        
        self.displayLabel = UILabel()
        self.displayLabel!.frame = CGRectMake(15, 390, 200, 200)
        self.displayLabel!.font = UIFont(name: "EvelethLight", size: 50)
        self.displayLabel?.textColor = UIColor(red: 88/255, green: 200/255, blue: 250/255, alpha: 1.0)
        
//        self.scrollView.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.scrollView)
        
        var bounds = UIScreen.mainScreen().bounds
        
        self.addSubview(self.staticView)
        self.sendSubviewToBack(staticView)
        self.addSubview(displayLabel!)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabels(newdata:BadgeData){
        
    var div = frame.size.height/imageButtonStart!.size.height
            if (newdata.id == 2){
                let currentImage = UIImage(named: "ch2bg")
                let BGView = UIImageView(image: currentImage)
                
                var title = "WHICH ARTIST?"
                let titleString = NSMutableAttributedString(string: title)
                titleString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, titleString.length))
                var titleLabel = UILabel(frame: CGRectMake(90, 170, 200, 44))
                titleLabel.attributedText = titleString
                
                titleLabel.font = UIFont(name: "BrushUp", size: 30)
                
                BGView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
                
                self.staticView.addSubview(BGView)
                
                let InpuView = UIImageView(image: imageButtonStart)
                InpuView.frame = CGRectMake(0,  frame.size.height/2 - 48, frame.size.width, imageButtonStart!.size.height/div + 20)
                InpuView.userInteractionEnabled = true
                self.scrollView.addSubview(InpuView)
                self.scrollView.sendSubviewToBack(InpuView)
                
                sendButtonStart.addTarget(self, action: "pulseActivate:", forControlEvents: UIControlEvents.TouchUpInside)
                
                displayLabel!.text = "1"
                
                self.attString = NSMutableAttributedString(string: "tell us which artist you love experiencing live.")
                
                self.attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, self.attString.length))
                self.customFontLabel = UILabel(frame: CGRectMake(90, 370, 175, 240))
                self.customFontLabel!.numberOfLines = 0
                self.customFontLabel?.attributedText = self.attString
                self.customFontLabel?.tintColor = UIColor.yellowColor()
                self.customFontLabel!.font = UIFont(name: "EvelethLight", size: 17)
                
                self.staticView.addSubview(self.customFontLabel!)
                
                textField = UITextField(frame: CGRectMake(self.bounds.size.width - 235, 15, 140, 75))
                textField?.textAlignment = NSTextAlignment.Center
                textField?.delegate = self
                InpuView.addSubview(textField!)
                
                
                titleLabel.userInteractionEnabled = true
                self.staticView.addSubview(titleLabel)
                
            } else if (newdata.id == 3){
                
                let currentImage = UIImage(named: "ch3bg")
                let BGView = UIImageView(image: currentImage)
                BGView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
                self.staticView.addSubview(BGView)
                
                var title = "# PEOPLE WITH YOU?"
                let titleString = NSMutableAttributedString(string: title)
                titleString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, titleString.length))
                var titleLabel = UILabel(frame: CGRectMake(60, 170, 250, 44))
                titleLabel.attributedText = titleString
                
                titleLabel.font = UIFont(name: "BrushUp", size: 30)
                
                let InpuView = UIImageView(image: imageButtonStart)
                InpuView.frame = CGRectMake(0,  frame.size.height/2 - 48, frame.size.width, imageButtonStart!.size.height/div + 20)
                InpuView.userInteractionEnabled = true
                self.scrollView.addSubview(InpuView)
                
                displayLabel!.text = "1"
                
                self.attString = NSMutableAttributedString(string: "How many people are part of the love making?")
                
                self.attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, self.attString.length))
                self.customFontLabel = UILabel(frame: CGRectMake(90, 370, 175, 240))
                self.customFontLabel!.numberOfLines = 0
                self.customFontLabel?.attributedText = self.attString
                self.customFontLabel?.tintColor = UIColor.yellowColor()
                self.customFontLabel!.font = UIFont(name: "EvelethLight", size: 17)
                
                self.staticView.addSubview(self.customFontLabel!)
                    
                textField = UITextField(frame: CGRectMake(self.bounds.size.width - 235, 15, 140, 75))
                textField?.textAlignment = NSTextAlignment.Center
                textField?.keyboardType = UIKeyboardType.DecimalPad
                textField?.delegate = self
                
                let numberToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 320))
                numberToolbar.barStyle = UIBarStyle.BlackTranslucent
                numberToolbar.items = NSArray(objects:
                    UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelNumberPad"),
                    UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
                    UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Plain, target: self, action: "doneWithNumberPad")
                ) as [AnyObject]
                numberToolbar.sizeToFit()
                textField?.inputAccessoryView = numberToolbar
                InpuView.addSubview(textField!)
                
                sendButtonStart.addTarget(self, action: "moveActivate:", forControlEvents: UIControlEvents.TouchUpInside)
                
                titleLabel.userInteractionEnabled = true
                self.staticView.addSubview(titleLabel)
            }
        }
    
    func cancelNumberPad(){
     textField!.resignFirstResponder()
     textField?.text = ""
    }
    
   func doneWithNumberPad(){
    textField!.resignFirstResponder()
        if(!textField!.text.isEmpty){
            NumberFromTheKeyboard = textField!.text
        
            self.scrollView.addSubview(sendButtonStart)
            self.scrollView.bringSubviewToFront(sendButtonStart)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if(!textField.text.isEmpty){
            SendText = textField.text
            
            self.scrollView.addSubview(sendButtonStart)
            self.scrollView.bringSubviewToFront(sendButtonStart)
        }
        
        return true;
        
    }
  
    func pulseActivate(sender:UITapGestureRecognizer){
        println("Go To Pulse")
        println("sended text: \(SendText)")
        self.delegate?.pulseTapped(SendText)
        //        pass one data object.
        //        connect to tapped function in view controller.
    }
    
    func moveActivate(sender:UITapGestureRecognizer){
        println("Go To Accelero")
        self.delegate?.moveTapped()
        //        pass one data object.
        //        connect to tapped function in view controller.
    }

}






