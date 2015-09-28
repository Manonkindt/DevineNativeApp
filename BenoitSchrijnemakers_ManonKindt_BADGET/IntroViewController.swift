//
//  IntroViewController.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 02/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

//
//  OverviewViewController.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 27/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit
import Alamofire

class IntroViewController: UIViewController, IntroDelegate {
    
    var theView:IntroView! {
        get {
            return self.view as! IntroView!
        }
    }

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    func rotated(){
        
      let delayTime = dispatch_time(DISPATCH_TIME_NOW,
          Int64(1.0 * Double(NSEC_PER_SEC)))
      dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.theView.rotateView.alpha = 1
        
        if(self.theView.rotateView.alpha == 1){
            UIView.animateWithDuration(
                Double(1.0),
                delay: 0.0,
                options: UIViewAnimationOptions.TransitionCrossDissolve ,
                animations: {
                    println(self.theView.rotateView.alpha)
                    
                    if ( self.theView.rotateView.alpha == 1){
                        println("true")
                        self.theView.rotateView.transform = CGAffineTransformMakeRotation((0.0 * CGFloat(M_PI)) / 180.0)
                    }
                    
                }, completion: { finished in
                    if(finished) {
                        println("rotated")
                    }
                }
            )
        }
      }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let arrow = UIImage(named: "arrowBack")
        
        
        let backButton = UIBarButtonItem(image: arrow, style: UIBarButtonItemStyle.Done, target: self, action: "closeView")
        navigationItem.setLeftBarButtonItem(backButton, animated: true)
        navigationItem.backBarButtonItem = backButton
        backButton.setBackButtonBackgroundVerticalPositionAdjustment(-20, forBarMetrics: UIBarMetrics.Default)
        navigationItem.backBarButtonItem?.tintColor = UIColor(patternImage: arrow!)
        
        self.theView.delegate = self
    }
    
    func closeView(){
        println("close view")
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds  //screensize instellen
        println("[IntroViewController] Loading intro")
        self.view = IntroView(frame: bounds) //sliderview inladen!!
        
        rotated()
        
    }
    
    func startClicked(){
        let detailVC = ScrollViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

