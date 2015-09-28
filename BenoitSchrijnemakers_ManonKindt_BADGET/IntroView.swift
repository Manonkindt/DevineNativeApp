//
//  IntroView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 02/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit
import SceneKit

class IntroView: UIView {
        
    weak var delegate:IntroDelegate?
    let delayTime = dispatch_time(DISPATCH_TIME_NOW,
        Int64(2 * Double(NSEC_PER_SEC)))
    let emitterCell = CAEmitterCell()
    let rotateView:UIImageView
    
    var imageButtonStart = UIImage(named: "IntroGotIt")
        
        override init(frame: CGRect) {
            
            println("[IntroView] - loaded")
            
            let currentImage = UIImage(named: "intro")
            
            let swipeImage = UIImage(named: "swipe")
            let fngrImage = UIImage(named: "fingerTap")
            var tapImage = UIImage(named: "circleTouched")
            
            
            let swipeView = UIImageView(image: swipeImage)
            let fngrView = UIImageView(image: fngrImage)
            let tapView = UIImageView(image: tapImage)
            
            fngrView.frame = CGRectMake(45, 370, fngrImage!.size.width/2, fngrImage!.size.height/2)
            swipeView.frame = CGRectMake(30, 158, swipeImage!.size.width/2, swipeImage!.size.height/2)

            tapView.frame = CGRectMake(40, 360, tapImage!.size.width/2, tapImage!.size.height/2)
            
            let imageView = UIImageView(image: currentImage)
            imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
            
            var x = frame.size.height/imageButtonStart!.size.height
            
            let buttonView = UIImageView(image: imageButtonStart)
            buttonView.frame = CGRectMake(0,  frame.size.height - imageButtonStart!.size.height/2.2, frame.size.width, imageButtonStart!.size.height/x + 30)
            
            self.rotateView = UIImageView(frame: CGRectMake(30, 262, swipeImage!.size.width/2, swipeImage!.size.height/2))
            self.rotateView.image = UIImage(named:"thumb")
            self.rotateView.transform = CGAffineTransformMakeRotation((30.0 * CGFloat(M_PI)) / 180.0)
            self.rotateView.alpha = 0
            
            
            super.init(frame: frame)
            
            
            let tap = UITapGestureRecognizer(target: self, action: "tap:")
            buttonView.userInteractionEnabled = true
            buttonView.addGestureRecognizer(tap)
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 1
            animation.repeatCount = 1
            animation.autoreverses = false
            animation.fromValue = NSValue(CGPoint: CGPointMake(swipeView.center.x - 20, swipeView.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(swipeView.center.x, swipeView.center.y))
            swipeView.layer.addAnimation(animation, forKey: "position")
            
            dispatch_after(self.delayTime, dispatch_get_main_queue()) {
                
              println("finger tap")
              self.addSubview(tapView)
              self.addSubview(fngrView)
              
              let animation = CABasicAnimation(keyPath: "position")
              animation.duration = 1
              animation.repeatCount = 1
              animation.autoreverses = false
              animation.fromValue = NSValue(CGPoint: CGPointMake(fngrView.center.x, fngrView.center.y + 20))
              animation.toValue = NSValue(CGPoint: CGPointMake(fngrView.center.x, fngrView.center.y))
              fngrView.layer.addAnimation(animation, forKey: "position")
               
            }
            
            self.addSubview(self.rotateView)
            self.addSubview(swipeView)
            self.addSubview(imageView)
            self.sendSubviewToBack(imageView)
            self.addSubview(buttonView)
        }

    
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func tap(sender:UITapGestureRecognizer){
            println("[MyView] - tap")
            self.delegate?.startClicked()
            //pass one data object.
            //connect to tapped function in view controller.
        }
}
