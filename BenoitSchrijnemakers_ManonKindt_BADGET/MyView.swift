//
//  MyView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 27/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    weak var delegate:DetailDelegate?
    
//    let btnStart:UIButton
    
    let swipeImage = UIImage(named: "bandje")
    var swipeView:UIImageView
    
    override init(frame: CGRect) {
        
        let currentImage = UIImage(named: "home")
        
        swipeView = UIImageView(image: swipeImage)
        swipeView.frame = CGRectMake(frame.size.width - swipeImage!.size.width/2, frame.size.height - swipeImage!.size.height/2 - 8, swipeImage!.size.width/2, swipeImage!.size.height/2)
        
        let imageView = UIImageView(image: currentImage)
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
    
        super.init(frame: frame)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Left
        swipeView.userInteractionEnabled = true
        swipeView.addGestureRecognizer(swipeRight)
        
        self.backgroundColor = UIColor.blueColor()
        self.addSubview(imageView)
        self.addSubview(swipeView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swipe(sender:UITapGestureRecognizer){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 1
        animation.repeatCount = 1
        animation.autoreverses = false
        animation.fromValue = NSValue(CGPoint: CGPointMake(swipeView.center.x - 20, swipeView.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(swipeView.center.x, swipeView.center.y))
        swipeView.layer.addAnimation(animation, forKey: "position")
        
        println("[MyView] - swipe")
        self.delegate?.introClicked()
        //pass one data object.
        //connect to tapped function in view controller.
    }
}
