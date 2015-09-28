//
//  MyView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 30/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit
import CoreMotion

class TentView: UIView {
    
    let staticView: UIView
    let blurView: UIVisualEffectView
    let manager = CMMotionManager()
    var points = 0
    var myTimer =  NSTimer()
    var sendButtonStart = UIButton()
    var startTime = NSTimeInterval()
    var displayTimeLabel: UILabel
    var seconds = UInt32()
    var rechthoek:CAShapeLayer!
    var rechthoekRot:CAShapeLayer!
    var velocityFrame:CAShapeLayer!
    var rotationFrame:CAShapeLayer!
    var currentTime = NSDate.timeIntervalSinceReferenceDate()
    var customFontLabel:UILabel?
    var attString:NSMutableAttributedString
    var displayLabel:UILabel?
    var Further:Bool
    var buttonImage = UIImage(named: "phoneMatress")
    var imageView = UIImageView()
    var sawPopup = Int(0)
    var timerView = UIImageView()
    var velovity = UILabel(frame: CGRectMake(75, 160, 160, 25))
    var rotation = UILabel(frame: CGRectMake(75, 220, 160, 25))
   
    
    override init(frame: CGRect) {
    
        self.velocityFrame = CAShapeLayer()
        self.velocityFrame.fillColor = UIColor(red: 69/255, green: 137/255, blue: 190/255, alpha: 1.0).CGColor
        
        self.rotationFrame = CAShapeLayer()
        self.rotationFrame.fillColor = UIColor(red: 69/255, green: 137/255, blue: 190/255, alpha: 1.0).CGColor
        
        self.rechthoek = CAShapeLayer()
        self.rechthoekRot = CAShapeLayer()
        self.Further = Bool()
        
        imageView = UIImageView(image: buttonImage)
        imageView.frame = CGRectMake(47, frame.size.height/2 - 102, buttonImage!.size.width/2, buttonImage!.size.height/2)
    
        self.staticView = UIView(frame:frame)
        self.displayTimeLabel = UILabel()
        self.displayLabel?.textColor = UIColor(red: 88/255, green: 200/255, blue: 250/255, alpha: 1.0)
        
        var lightBlur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        blurView = UIVisualEffectView(effect: lightBlur)
        
        attString = NSMutableAttributedString()
        
        super.init(frame: frame)
    
        sendButtonStart = UIButton(frame: CGRectMake(85, 220, 200, 200 ))
        sendButtonStart.setTitle("OKAY", forState: UIControlState.Normal)
        sendButtonStart.setTitleColor(UIColor(red: 30/255, green: 116/255, blue: 196/255, alpha: 1.0), forState: UIControlState.Normal)
        sendButtonStart.titleLabel?.font = UIFont(name: "EvelethLight", size: 30)
        
        displayTimeLabel.frame = CGRectMake(180, 260, 100, 100)
        displayTimeLabel.font = UIFont(name: "EvelethLight", size: 25)
        
        let currentImage = UIImage(named: "ch3bg")
        let BGView = UIImageView(image: currentImage)
        BGView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        self.displayLabel = UILabel()
        self.displayLabel!.frame = CGRectMake(10, 390, 200, 200)
        self.displayLabel!.font = UIFont(name: "EvelethLight", size: 50)
        self.displayLabel?.textColor = UIColor(red: 88/255, green: 200/255, blue: 250/255, alpha: 1.0)
        
        self.staticView.addSubview(BGView)
        self.staticView.addSubview(self.sendButtonStart)
        self.addSubview(self.staticView)
        self.addSubview(displayLabel!)
        self.addSubview(imageView)
        
        self.layer.addSublayer(self.rechthoek)
        self.layer.addSublayer(self.rechthoekRot)
        self.layer.addSublayer(self.velocityFrame)
        self.layer.addSublayer(self.rotationFrame)
        
        self.displayLabel?.text = "2"
        
        self.attString = NSMutableAttributedString(string: "Let us measure how well you two get along.")
        
        self.attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, self.attString.length))
        self.customFontLabel = UILabel(frame: CGRectMake(90, 370, 175, 240))
        self.customFontLabel!.numberOfLines = 0
        self.customFontLabel?.attributedText = self.attString
        self.customFontLabel?.tintColor = UIColor.yellowColor()
        self.customFontLabel!.font = UIFont(name: "EvelethLight", size: 17)
        
        self.staticView.addSubview(self.customFontLabel!)
        self.addSubview(velovity)
        self.addSubview(rotation)
        self.addSubview(timerView)

        sendButtonStart.addTarget(self, action: "SetTrue", forControlEvents: UIControlEvents.TouchUpInside)
    
        println("myTimer = \(myTimer.timeInterval)")
        self.blurView.removeFromSuperview()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetTrue(){
        self.Further = Bool(true)
        startMoment()
    }
    
    func startMoment(){
        println(self.Further)
        if (myTimer.valid == false && Further == true) {
            sendButtonStart.removeFromSuperview()
            self.staticView.addSubview(displayTimeLabel)
            let aSelector : Selector = "updateTime"
            myTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            moveDetector()
            startTime = NSDate.timeIntervalSinceReferenceDate()
        } else {
            println("shut it all down")
            myTimer.invalidate()
            
            popUp()
        }
    }
    
    func updateTime() {
        println("updateTime")
        
        currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt32(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        seconds = UInt32(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt32(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)

        displayTimeLabel.text = "\(strSeconds):\(strFraction)"
        displayTimeLabel.textColor = UIColor(red: 12/255.0, green: 126/255.0, blue: 210/255, alpha: 1.0)
    }
    
    func moveDetector () {
      
      if (Further == true) {
        if manager.deviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.02
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(1.5 * Double(NSEC_PER_SEC)))
            
             self.manager.startDeviceMotionUpdates()

            self.manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
             [weak self] (data: CMDeviceMotion!, error: NSError!) in
            
                if( self!.seconds > 0){
     
                    self!.timerView = UIImageView(image: UIImage(named: "timer"))
                    self!.timerView.frame = CGRectMake(145, 295, UIImage(named: "timer")!.size.width/2, UIImage(named: "timer")!.size.height/2)
 
                    self!.velovity.text = "Velocity"
                    self!.velovity.font = UIFont(name: "EvelethLight", size: 16)
                    self!.velovity.textColor = UIColor(red: 207/255.0, green: 68/255.0, blue: 69/255, alpha: 1.0)
                    
                    self!.rotation.text = "rotation"
                    self!.rotation.font = UIFont(name: "EvelethLight", size: 16)
                    self!.rotation.textColor = UIColor(red: 207/255.0, green: 68/255.0, blue: 69/255, alpha: 1.0)
                    
                    self!.imageView.removeFromSuperview()
            
                    self!.rechthoek.path = UIBezierPath(rect: CGRectMake(65, 190 ,160, 10)).CGPath
                    self!.rechthoek.fillColor = UIColor(red: 254/255, green: 254/255, blue: 245/255, alpha: 1.0).CGColor
                    self!.rechthoekRot.path = UIBezierPath(rect: CGRectMake(65, 250 ,160, 10)).CGPath
                    self!.rechthoekRot.fillColor = UIColor(red: 254/255, green: 254/255, blue: 245/255, alpha: 1.0).CGColor
                    
                    var rotateX = ( data.rotationRate.x ) * ( 180.0 / M_PI )
                    var rotWidth = UInt( rotateX  / 2.25 )
                    self!.rotationFrame.path = UIBezierPath(rect: CGRectMake(65, 250 ,CGFloat(rotWidth), 10)).CGPath
                    
                    var velocity = UInt32(self!.points) / self!.seconds //snelheid = punten/tijd
                    
                    var width = CGFloat( UInt32(self!.points) * 20 / self!.seconds)
                    self!.velocityFrame.path = UIBezierPath(rect: CGRectMake(65, 190 ,width, 10)).CGPath

                }
                
                if ( data.userAcceleration.x > 0.6 ||  data.userAcceleration.y > 1.4 ) {
                    
                    self!.blurView.frame = self!.staticView.bounds
                    self!.blurView.layer.opacity = 0.7
                    self!.addSubview(self!.blurView)
                    
                    if ( data.userAcceleration.x > 0.8 ||  data.userAcceleration.y > 1.6 ) {
                
                        self!.blurView.frame = self!.staticView.bounds
                        self!.blurView.layer.opacity = 0.9
                        self!.addSubview(self!.blurView)
                        
                    }

                } else {
                     self!.blurView.removeFromSuperview()
                }
                
                println("X : \(data.userAcceleration.x)")
                println("Y : \(data.userAcceleration.y)")
                
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                  if (data.userAcceleration.x < 0.17 && data.userAcceleration.x > 0.13 ||
                  data.userAcceleration.y < 0.66 && data.userAcceleration.y > 0.62 ) {
                      self!.points++
                      println(self!.points)
                  } else if (data.attitude.quaternion.y < 0.0003 && data.attitude.quaternion.y > -0.0003
                    ) {
                        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                            Int64(4.0 * Double(NSEC_PER_SEC)))
                        
                        dispatch_after(delayTime, dispatch_get_main_queue()) {
                            self!.test()
                            self!.Further = false
                        }
                    }
                }
            }
        }
       }
    }
    
    func test(){
       self.manager.stopDeviceMotionUpdates()
       self.stopDetector()
    }
    
    func stopDetector() {
        Further = Bool(false)
        
        self.displayLabel?.text = "3"
        self.attString = NSMutableAttributedString(string: "Do the naughty and create some more love here.")
        self.attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, self.attString.length))
        self.customFontLabel?.attributedText = self.attString
      
        println(self.points)
        
        startMoment()
    }
    
    func popUp(){
        if(sawPopup == 0){
            sawPopup++
            if (self.points >= 20){
    
                let message = "You unlocked the badge. You need"
    
                var popViewController = ChallengePopUpViewController()
                popViewController.showInViewCompleted(self, withBadge: "badge3", withMessage: message, withImage: UIImage(), withPulse: self.points, animated: true)
    
                let BadgeRetrieved = NSUserDefaults.standardUserDefaults().boolForKey("Badge3")
                if BadgeRetrieved  {
                    println("Didn't retrieve")
                            }
                else {
    
                    println("Congratulations, You scored Badge 3")
    
                    var score = NSUserDefaults.standardUserDefaults().integerForKey("onvoltooid")
                    println(score)
    
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Badge3")
                    NSUserDefaults.standardUserDefaults().setInteger(score - 1, forKey: "onvoltooid")
    
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                }
    
            } else {
    
                let message = "Did she even feel anything? you should try again."
    
                var popViewController = ChallengePopUpViewController()
                popViewController.showInViewFailed(self, withBadge: "badge3", withMessage: message, animated: true)
            }
        } else {
              println("tis nx")
        }

    }
}

