//
//  PopUpView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 10/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

extension Character {
    var integerValue:Int {
        return String(self).toInt() ?? 0
    }
}

class PopUpView: UIView {
    
    let dismissButton:UIButton
    let shareImage = UIImage(named: "share")
    let closeImage = UIImage(named: "close")
    let retakeImage = UIImage(named: "retake")
    let yesImage = UIImage(named: "yes")
    let noImage = UIImage(named: "no")
    var NoButtonStart:UIButton
    let staticView: UIView
    var retakeButtonStart:UIButton
    var SendImage = UIImage()
    var SendData = Int()
    var BooleanValue = Bool()
    var concert = String()
    var badgesArray:Array<BadgeData>?
    var yPosition = CGFloat(230)
    var countVoltooid = 0
    var countNietVoltooid = 0

    var delegate:PopDelegate?
    
    override init(frame: CGRect) {
        
        println("PopUpView")
        
        dismissButton = UIButton(frame: CGRectMake(245, 175, self.closeImage!.size.width/2, self.closeImage!.size.height/2))
        dismissButton.setBackgroundImage(self.closeImage, forState: UIControlState.Normal)
        
        retakeButtonStart = UIButton(frame: CGRectMake(frame.size.width/2 - self.shareImage!.size.width/4, 360, self.shareImage!.size.width/2, self.shareImage!.size.height/2))
        NoButtonStart = UIButton(frame: CGRectMake(frame.size.width/2 + self.noImage!.size.width/4, 360, self.noImage!.size.width/2, self.noImage!.size.height/2))
        self.staticView = UIView(frame:frame)
        
        super.init(frame: frame)
        
        var userBadges = NSUserDefaults.standardUserDefaults().integerForKey("onvoltooid")
        println("Niet Voltooid: \(userBadges)")

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func badgesView( badges:Array<BadgeData>, ArrayaView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool) {
        
        self.badgesArray = badges
        
        dismissButton.addTarget(self, action: "closeView:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let currentImage = UIImage(named: "popUp")
        let BGView = UIImageView(image: currentImage)
        BGView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        self.addSubview(BGView)
        
        let titleString = NSMutableAttributedString(string: "BADGES")
        var titleLabel = UILabel(frame: CGRectMake(100, 180, 200, 44))
        titleLabel.attributedText = titleString
        titleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 40/255.0, green: 184/255.0, blue: 246/255.0, alpha: 1.0), range: NSMakeRange(0, titleString.length))
        titleLabel.font = UIFont(name: "EvelethLight", size: 26)
        self.addSubview(titleLabel)
        
        let subtitleString = NSMutableAttributedString(string: "Your collection so far.")
        var subtitleLabel = UILabel(frame: CGRectMake(65, 210, 200, 44))
        subtitleLabel.attributedText = subtitleString
        subtitleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 97/255.0, green: 98/255.0, blue: 99/255.0, alpha: 1.0), range: NSMakeRange(0, subtitleString.length))
        subtitleLabel.font = UIFont(name: "Bitter-Regular", size: 18)
        self.addSubview(subtitleLabel)
        
        
        
        for challenge in badges {
            
            let quote = " \""
            let pauze = ".   "
            let title = String(challenge.id) + pauze + quote + challenge.title + quote
            let attString = NSMutableAttributedString(string: title)
            
            var badge = "Badge" + String(challenge.id)
            
            if NSUserDefaults.standardUserDefaults().boolForKey(String(badge)){
                countVoltooid++
                attString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 87/255.0, green: 160/255.0, blue: 83/255.0, alpha: 1.0), range: NSMakeRange(0, attString.length))
                var completed = UIImage(named: "completed")
                let completedView = UIImageView(image: completed)
                completedView.frame = CGRectMake(230, yPosition + 40, completed!.size.width/2, completed!.size.height/2)
                
                self.addSubview(completedView)
                
                
                
            } else {

                countNietVoltooid++
                attString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 219/255.0, green: 100/255.0, blue: 96/255.0, alpha: 1.0), range: NSMakeRange(0, attString.length))
                var incomplete = UIImage(named: "incomplete")
                let incompleteView = UIImageView(image: incomplete)
                incompleteView.frame = CGRectMake(230, yPosition + 40, incomplete!.size.width/2, incomplete!.size.height/2)
                
                self.addSubview(incompleteView)
                
            }
            
            yPosition += 50
            
            var customFontLabel = UILabel(frame: CGRectMake(50, yPosition - 15, 200, 44))
            customFontLabel.attributedText = attString
            customFontLabel.font = UIFont(name: "Bitter-Regular", size: 20)
            
            self.addSubview(dismissButton)
            self.addSubview(customFontLabel)
            
        }
        
        var score = countNietVoltooid
        println(score)
        
        NSUserDefaults.standardUserDefaults().integerForKey("onvoltooid")
        
        //Check if score is higher than NSUserDefaults stored value and change NSUserDefaults stored value if it's true
        if score <= NSUserDefaults.standardUserDefaults().integerForKey("onvoltooid") {
            NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "onvoltooid")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func failed(aView: UIView!, withBadge badge: String!, withMessage message: String!, animated: Bool){
        
        dismissButton.addTarget(self, action: "closeView:", forControlEvents: UIControlEvents.TouchUpInside)
        retakeButtonStart.setBackgroundImage(self.retakeImage, forState: UIControlState.Normal)
        retakeButtonStart.addTarget(self, action: "closeView:", forControlEvents: UIControlEvents.TouchUpInside)
        println("failed")
        
        
        println(Array(badge)[5])
        var number = Array(badge)[5]
        
       var x = number.integerValue
        
        println(x)
        
        dismissButton.tag = x - 1
        retakeButtonStart.tag = x - 1
        
        if ( x == 1 ){
            retakeButtonStart = UIButton(frame: CGRectMake(frame.size.width/2 - self.shareImage!.size.width/4, 360, self.shareImage!.size.width/2, self.shareImage!.size.height/2))
            retakeButtonStart.setBackgroundImage(self.retakeImage, forState: UIControlState.Normal)
            retakeButtonStart.addTarget(self, action: "retake:", forControlEvents: UIControlEvents.TouchUpInside)
        } else if ( x == 2 ){
            retakeButtonStart = UIButton(frame: CGRectMake(frame.size.width/2 - self.yesImage!.size.width/1.5, 360, self.yesImage!.size.width/2, self.yesImage!.size.height/2))
            retakeButtonStart.setBackgroundImage(self.yesImage, forState: UIControlState.Normal)
            retakeButtonStart.addTarget(self, action: "retake:", forControlEvents: UIControlEvents.TouchUpInside)
            NoButtonStart.setBackgroundImage(self.noImage, forState: UIControlState.Normal)
            NoButtonStart.addTarget(self, action: "overview:", forControlEvents: UIControlEvents.TouchUpInside)
        }

        let currentImage = UIImage(named: "popUp")
        let BGView = UIImageView(image: currentImage)
        BGView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        self.addSubview(BGView)
        
        self.addSubview(dismissButton)
        self.addSubview(retakeButtonStart)
        self.addSubview(NoButtonStart)
        
        let titleString = NSMutableAttributedString(string: "TRY AGAIN!")
        titleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 219/255.0, green: 100/255.0, blue: 96/255.0, alpha: 1.0), range: NSMakeRange(0, titleString.length))
        var titleLabel = UILabel(frame: CGRectMake(65, 215, 200, 44))
        titleLabel.attributedText = titleString
        titleLabel.font = UIFont(name: "EvelethLight", size: 30)
        self.addSubview(titleLabel)
        
        let subtitleString = NSMutableAttributedString(string: message)
        var subtitleLabel = UILabel(frame: CGRectMake(65, 220, 200, 150))
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = NSTextAlignment.Center
        subtitleLabel.attributedText = subtitleString
        subtitleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 97/255.0, green: 98/255.0, blue: 99/255.0, alpha: 1.0), range: NSMakeRange(0, subtitleString.length))
        subtitleLabel.font = UIFont(name: "Bitter-Regular", size: 18)
        self.addSubview(subtitleLabel)
    }
    
    func completed(aView: UIView!, withBadge badge: String!, withMessage message: String!, withImage image: UIImage, withPulse pulse: Int,  animated: Bool){
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        var score = Int(NSUserDefaults.standardUserDefaults().integerForKey("onvoltooid"))
        println("niet voltooid \(score)")

        dismissButton.addTarget(self, action: "closeView:", forControlEvents: UIControlEvents.TouchUpInside)
        retakeButtonStart.setBackgroundImage(self.shareImage, forState: UIControlState.Normal)
        retakeButtonStart.addTarget(self, action: "shareView:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let currentImage = UIImage(named: "popUp")
        let BGView = UIImageView(image: currentImage)
        BGView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        self.addSubview(BGView)
        
        if(animated == false){
            concert = message.substringWithRange(Range<String.Index>(start: advance(message.startIndex, 32), end: message.endIndex))
            println(concert)
//            message.substringWithRange(Range<String.Index>(start: advance(message.startIndex, 32), end: advance(message.endIndex, 0))) //"llo, playgroun"
            
            var Shortmessage = message.substringWithRange(Range<String.Index>(start: advance(message.startIndex, 0), end: advance(message.endIndex, -Array(concert).count)))
            
            let comment = String(Shortmessage) + " " + String(score) + " more"
            let subtitleString = NSMutableAttributedString(string: comment)
            var subtitleLabel = UILabel(frame: CGRectMake(65, 220, 200, 150))
            subtitleLabel.numberOfLines = 0
            subtitleLabel.textAlignment = NSTextAlignment.Center
            subtitleLabel.attributedText = subtitleString
            subtitleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 97/255.0, green: 98/255.0, blue: 99/255.0, alpha: 1.0), range: NSMakeRange(0, subtitleString.length))
            subtitleLabel.font = UIFont(name: "Bitter-Regular", size: 18)
            self.addSubview(subtitleLabel)
            
        } else {
            let comment = String(message) + " " + String(score) + " more"
            let subtitleString = NSMutableAttributedString(string: comment)
            var subtitleLabel = UILabel(frame: CGRectMake(65, 220, 200, 150))
            subtitleLabel.numberOfLines = 0
            subtitleLabel.textAlignment = NSTextAlignment.Center
            subtitleLabel.attributedText = subtitleString
            subtitleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 97/255.0, green: 98/255.0, blue: 99/255.0, alpha: 1.0), range: NSMakeRange(0, subtitleString.length))
            subtitleLabel.font = UIFont(name: "Bitter-Regular", size: 18)
            self.addSubview(subtitleLabel)

        }
        
        SendImage = image
        SendData = pulse
        BooleanValue = animated
        
        self.addSubview(dismissButton)
        self.addSubview(retakeButtonStart)
        
        let titleString = NSMutableAttributedString(string: "CONGRATS!")
         titleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 40/255.0, green: 184/255.0, blue: 246/255.0, alpha: 1.0), range: NSMakeRange(0, titleString.length))
        var titleLabel = UILabel(frame: CGRectMake(65, 215, 200, 44))
        titleLabel.attributedText = titleString
        titleLabel.font = UIFont(name: "EvelethLight", size: 30)
        self.addSubview(titleLabel)
        
    }
    
    func overview(sender: AnyObject){
        self.delegate?.overview()
    }
    
    func shareView(sender: AnyObject){
        println("Share on facebook")
        self.delegate?.facebookShare(SendImage, data: SendData, check: BooleanValue, message: concert)
    }
    
    func retake(sender:AnyObject){
        self.delegate?.retakePicture(sender.tag)
    }

    func closeView(sender: UIButton) {
        self.delegate?.removeAnimate(dismissButton.tag)
    }

}