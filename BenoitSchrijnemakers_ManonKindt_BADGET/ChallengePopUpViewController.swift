//
//  ChallengePopUpViewController.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 10/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit
import Social
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire

class ChallengePopUpViewController: UIViewController, PopDelegate {
    
    var popUpView: UIView
    var bounds:CGRect
    let shareButton:UIButton
    let shareImage = UIImage(named: "share")
    var retakeButtonStart = UIButton()
    var imageButtonStart = UIButton()
    let closeImage = UIImage(named: "close")
    var location:NSDictionary!
    var city:NSString
    
    var badgesArray:Array<BadgeData>?
    
    var theView:PopUpView! {
        get {
            return self.view as! PopUpView!
        }
    }
    
    init () {
        
        location = NSDictionary()
        city = NSString()
        
        bounds = UIScreen.mainScreen().bounds  //screensize instellen
        
        imageButtonStart = UIButton(frame: CGRectMake(20, bounds.size.height/2 - 62, shareImage!.size.width/2.3, shareImage!.size.height/2.3))
        imageButtonStart.setBackgroundImage(shareImage, forState: UIControlState.Normal)
        self.popUpView = UIView()

        self.shareButton = UIButton(frame: CGRectMake(bounds.size.width/2 - shareImage!.size.width/4, 320, shareImage!.size.width/2, shareImage!.size.height/2))
        shareButton.setBackgroundImage(shareImage, forState: UIControlState.Normal)

        super.init(nibName: nil, bundle: nil)
        
        Alamofire.request(.GET, "http://student.howest.be/manon.kindt/testmajor/api/todos").responseJSON { (request, response, theData, error) -> Void in
            
            self.badgesArray = Array<BadgeData>()
            
            println("Error : \(error)")
            let theJSON = JSON(theData!)
            
            for BadgeDict in theJSON.arrayValue {
                var id = BadgeDict["id"].intValue
                var title = BadgeDict["title"].stringValue
                var created = BadgeDict["created"].stringValue
                var Description = BadgeDict["Description"].stringValue
                var subtitle = BadgeDict["subtitle"].stringValue
                var image = BadgeDict["image"].stringValue
                var bg = BadgeDict["bg"].stringValue
                
                var badgeData:BadgeData = BadgeData(id: id, title: title, created: created, Description: Description, subtitle: subtitle, image: image, bg: bg)
                
                self.badgesArray?.append(badgeData)
                
            }
        }
        
        println(self.badgesArray)

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        
        self.theView.delegate = self
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
    }
    
    func showInViewCompleted(aView: UIView!, withBadge badge: String!, withMessage message: String!, withImage image: UIImage, withPulse pulse: Int, animated: Bool){
        
        aView.addSubview(self.view)
        
        self.theView.completed(aView, withBadge: badge, withMessage: message, withImage: image, withPulse: pulse, animated: animated)
        
        if animated {
            self.showAnimate()
        }
    }
    
    func showBadgesInView( badges:Array<BadgeData>, ArrayaView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool) {
        
        ArrayaView.addSubview(self.view)
        
        self.theView.badgesView(badges, ArrayaView: ArrayaView, withImage: image, withMessage: message, animated: animated)
        
        if animated {
            self.showAnimate()
        }
    }

    
    func showInViewFailed(aView: UIView!,withBadge badge: String!, withMessage message: String!, animated: Bool){
        
        aView.addSubview(self.view)
        
        self.theView.failed(aView, withBadge: badge, withMessage: message, animated: animated)
        
        if animated {
            self.showAnimate()
        }
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
       
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds  //screensize instellen
        self.view = PopUpView(frame: bounds) //sliderview inladen!!
        
    }
    
    func removeAnimate(index:Int) {
        
        println("laat het stoppen!!!!")
        UIView.animateWithDuration(0.25, animations: {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
          self.view.alpha = 0.0
          }, completion:{(finished : Bool)  in
              if (finished)
              {
                self.view.removeFromSuperview()
                self.navigationController?.popViewControllerAnimated(true)

            }
        })
    }
    
    func overview() {
        println("dismiss!!!!")
        println("laat het stoppen!!!!")
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0
            }, completion:{(finished : Bool)  in
                if (finished)
                {
//                    let secondViewController = ScrollViewController(nibName: nil, bundle: nil)
//                    self.view.window!.rootViewController!.presentViewController(secondViewController, animated: true, completion: nil)
//
//                    
//                    let secondViewController = ScrollViewController(nibName: nil, bundle: nil)
//                    self.presentViewController(secondViewController, animated: true, completion: nil)
                    
                    println("hallo")
//                    let detailVC = ScrollViewController(nibName: nil, bundle: nil)
//                    self.navigationController?.pushViewController(detailVC, animated: true)

                    self.view.removeFromSuperview()
        
                }
        })
    }

    
    func retakePicture(index:Int) {
        
        println("laat het stoppen!!!!")
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                 
                    
                }
        })
                
    }
    
    func facebookShare(image: UIImage, data: Int, check: Bool, message: String) {
        let facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        presentViewController(facebookVC, animated: true, completion: { () -> Void in
        })
        
        println(image.size)
        if(image.size == CGSize(width: 0, height: 0)){
            facebookVC.addImage(UIImage(named: "Default"))
        } else {
            facebookVC.addImage(image)
        }
        if ( data != 0){
            if(check == true){
                facebookVC.setInitialText("We Just made our Tent dance to \(String(stringInterpolationSegment: data)) mph")
            } else {
                facebookVC.setInitialText("My Heart Beat just raised to \(String(stringInterpolationSegment: data)) BPM Thanks to the awesome beats from \(message)")
            }
        }
        facebookVC.addURL(NSURL(string: "http://student.howest.be/manon.kindt/20142015/MA4/BADGET/"))
        
        self.view.removeFromSuperview()
    }

    
}
