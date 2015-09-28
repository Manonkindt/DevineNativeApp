//
//  PopUpViewController.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 06/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var popUpView: UIView
    var bounds:CGRect
    var badgesArray:Array<BadgeData>
    var yPosition = CGFloat(200)
    let dismissButton:UIButton
        
     init (badges:Array<BadgeData>) {
        
        let closeImage = UIImage(named: "close")
        badgesArray = badges
        self.popUpView = UIView()
        bounds = UIScreen.mainScreen().bounds  //screensize instellen
        self.dismissButton = UIButton(frame: CGRectMake(230, 180, closeImage!.size.width/2, closeImage!.size.height/2))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
    }
    
    func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool) {
        
        aView.addSubview(self.view)
        
        dismissButton.frame = CGRectMake(230, 60 + 55, 60, 60)
        dismissButton.setTitle("Done", forState: .Normal)
        dismissButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        aView.addSubview(dismissButton)
        
        dismissButton.addTarget(self, action: "buttonTapped", forControlEvents: .TouchUpInside)
    
        
        let currentImage = UIImage(named: "popUp")
        let BGView = UIImageView(image: currentImage)
        BGView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        aView.addSubview(BGView)
        
        let titleString = NSMutableAttributedString(string: "BADGES")
        var titleLabel = UILabel(frame: CGRectMake(100, 150, 200, 44))
        titleLabel.attributedText = titleString
        titleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 40/255.0, green: 184/255.0, blue: 246/255.0, alpha: 1.0), range: NSMakeRange(0, titleString.length))
        titleLabel.font = UIFont(name: "EvelethLight", size: 26)
        aView.addSubview(titleLabel)
        
        let subtitleString = NSMutableAttributedString(string: "Your collection so far.")
        var subtitleLabel = UILabel(frame: CGRectMake(65, 180, 200, 44))
        subtitleLabel.attributedText = subtitleString
        subtitleString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 97/255.0, green: 98/255.0, blue: 99/255.0, alpha: 1.0), range: NSMakeRange(0, subtitleString.length))
        subtitleLabel.font = UIFont(name: "Bitter-Regular", size: 18)
        aView.addSubview(subtitleLabel)

        
        
        for challenge in badgesArray {
            
            let quote = " \""
            let pauze = ".   "
            let title = String(challenge.id) + pauze + quote + challenge.title + quote
            let attString = NSMutableAttributedString(string: title)
            
            var badge = "Badge" + String(challenge.id)
            
            if NSUserDefaults.standardUserDefaults().boolForKey(String(badge)){
                println("Voltooid")
                attString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 87/255.0, green: 160/255.0, blue: 83/255.0, alpha: 1.0), range: NSMakeRange(0, attString.length))
                var completed = UIImage(named: "completed")
                let completedView = UIImageView(image: completed)
                completedView.frame = CGRectMake(230, yPosition + 40, completed!.size.width/2, completed!.size.height/2)
                
                aView.addSubview(completedView)
                
            } else {
                println("Nog Niet Voltooid")
                attString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 219/255.0, green: 100/255.0, blue: 96/255.0, alpha: 1.0), range: NSMakeRange(0, attString.length))
                var incomplete = UIImage(named: "incomplete")
                let incompleteView = UIImageView(image: incomplete)
                incompleteView.frame = CGRectMake(230, yPosition + 40, incomplete!.size.width/2, incomplete!.size.height/2)
                
                aView.addSubview(incompleteView)
            }
            
            yPosition += 50
            
            var customFontLabel = UILabel(frame: CGRectMake(50, yPosition - 15, 200, 44))
            customFontLabel.attributedText = attString
            customFontLabel.font = UIFont(name: "Bitter-Regular", size: 20)
            
           aView.addSubview(customFontLabel)
        }
        
//        let closeImage = UIImage(named: "close")
//        var newNoteButton = UIImageView(image: closeImage)
//        let pop = UITapGestureRecognizer(target: self, action: "pop:")
//        newNoteButton = UIImageView(frame: CGRectMake(230, 180, closeImage!.size.width/2, closeImage!.size.height/2))
//        newNoteButton.userInteractionEnabled = true
//        newNoteButton.addGestureRecognizer(pop)
        
        
//        let closeImage = UIImage(named: "close")
//        var newNoteButton = UIButton(frame: CGRectMake(230, 180, closeImage!.size.width/2, closeImage!.size.height/2))
//        newNoteButton.setBackgroundImage(closeImage, forState: UIControlState.Normal)
//        newNoteButton.addTarget(self.popUpView, action: "pop:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        aView.addSubview(newNoteButton)
        
        if animated {
            self.showAnimate()
        }
    }
    
    func pizzaDidFinish(){
        println("pizzaDidFinish")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func closeView(){
        println("close view")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    func pop(sender: AnyObject) {
        println("close")
    }
    
    func buttonTapped(sender: AnyObject) {
        println("Button Tapped!!!")
    }
}
