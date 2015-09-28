//
//  SliderView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 27/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

class SliderView: UIView, UIScrollViewDelegate {
    
    var itemIndex: Int = 0
    let scrollView:UIScrollView
    let staticView: UIView
    let arrowView: UIView
    let imageButtonStart = UIImage(named: "Start")
    let ArrowLeft = UIImage(named: "ArrowLeft")
    let ArrowRight = UIImage(named: "ArrowRight")
    var imageView: UIImageView
    let ArrowLeftView: UIImageView
    let ArrowRightView: UIImageView
    var xPosition = CGFloat(0)
    var textView:UITextView
    var x = 0
    
    weak var delegate:BadgeDetailDelegate?
    
    override init(frame: CGRect){
        
        self.scrollView = UIScrollView(frame: frame)
        self.staticView = UIView(frame:frame)
        self.imageView = UIImageView()
        self.arrowView = UIView(frame: CGRectMake(10, frame.size.height/2, frame.size.width, ArrowLeft!.size.height))
        
        ArrowLeftView = UIImageView(image: ArrowLeft)
        ArrowRightView = UIImageView(image: ArrowRight)
        
        
        ArrowLeftView.frame = CGRectMake(0, 0, ArrowLeft!.size.width/2, ArrowLeft!.size.height/2)
        ArrowRightView.frame = CGRectMake(frame.size.width -  ArrowLeft!.size.width, 0, ArrowLeft!.size.width/2, ArrowLeft!.size.height/2)
        self.textView = UITextView()
        
        super.init(frame:frame)
        
        self.addSubview(self.staticView)
        self.addSubview(self.scrollView)
        self.addSubview(self.arrowView)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createImageViews(badges:Array<BadgeData>) {
        
        var div = frame.size.height/imageButtonStart!.size.height
        for tour in badges {
            
            let image = UIImage(named: tour.image)
            imageView = UIImageView(image: image)
            
            var bounds = UIScreen.mainScreen().bounds
            var newview = UIView(frame: bounds)
            
            let imageButtonLeft = UIImage(named: tour.image)
            
            let bird = "birds" + String(tour.id)
            let birds = UIImage(named: bird)
            let birdsView = UIImageView(image: birds)
            
            //bird popup
            let pop = UITapGestureRecognizer(target: self, action: "popView:")
            birdsView.userInteractionEnabled = true
            birdsView.addGestureRecognizer(pop)
            birdsView.tag = tour.id
            birdsView.frame = CGRectMake(xPosition + 80, 115.5 ,birds!.size.width/2, birds!.size.height/2)
            
            imageView.frame = CGRectMake(xPosition + 14.25, 168.5 , 291.5, 277)
            
            //start button
            let tap = UITapGestureRecognizer(target: self, action: "tapDetail:")
            let buttonView = UIImageView(image: imageButtonStart)
            buttonView.frame = CGRectMake(xPosition,  frame.size.height - imageButtonStart!.size.height/2.2, imageButtonStart!.size.width/2, imageButtonStart!.size.height/2)
            buttonView.userInteractionEnabled = true
            buttonView.addGestureRecognizer(tap)
            
            //geef afbeelding een id
            buttonView.tag = x
            
            //add background
            let currentImage = UIImage(named: "overview")
            
            let BGView = UIImageView(image: currentImage)
            BGView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
            
            
            //bewegend pijltje
            var xpos = xPosition + 180
            
            let arrow = UIImage(named: "arrow")
            let arrowView = UIImageView(image: arrow)
            arrowView.frame = CGRectMake(xpos, 130, arrow!.size.width/2, arrow!.size.width/2)
            
            let animation = CABasicAnimation(keyPath: "position")
            //animation.duration = 0.07
            animation.repeatCount = 100
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(arrowView.center.x - 5, arrowView.center.y))
            
            animation.toValue = NSValue(CGPoint: CGPointMake(arrowView.center.x + 5, arrowView.center.y))
            arrowView.layer.addAnimation(animation, forKey: "position")
            
            var firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("Arrow")
            if firstLaunch  {
                //                    println("not showing Arrow")
            }
            else {
                //                    println("First launch, showing Arrow")
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Arrow")
                self.scrollView.addSubview(arrowView)
            }
            
            //add views
            self.scrollView.addSubview(buttonView)
            self.scrollView.addSubview(imageView)
            self.scrollView.sendSubviewToBack(imageView)
            self.scrollView.addSubview(birdsView)
            self.staticView.addSubview(BGView)
            self.staticView.sendSubviewToBack(BGView)
            
            //zorgt ervoor dat alles naast elkaar staat
            xPosition += frame.size.width
            x++
            
            self.scrollView.userInteractionEnabled = true
            self.scrollView.contentSize = CGSizeMake(xPosition,0)
            self.scrollView.pagingEnabled = true
            self.scrollView.bounces = true
        }
    }
    
    func popView(sender:UITapGestureRecognizer){
        var id = sender.view!.tag
        var badge = "Badge" + String(id)
        self.delegate?.popView(badge, index: sender.view!.tag)
    }
    
    
    func tapDetail(sender:UITapGestureRecognizer){
        println("Go To Detail")
        println(sender.view!.tag)
        self.delegate?.imageTapped(sender.view!.tag)
    }
    
    
}