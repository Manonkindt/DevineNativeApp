//
//  OverviewViewController.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 27/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit
import Alamofire
import UIFont_Enumerate

class OverviewViewController: UIViewController, DetailDelegate {
    
    
    var theView:MyView! {
        get {
            return self.view as! MyView!
        }
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
                
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//         UIFont.enumerateFonts()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        self.theView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds  //screensize instellen
        println("[ViewController] Loading custom view")
        
        self.view = MyView(frame: bounds) //sliderview inladen!!
        
    }
    
    func introClicked(){
        
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if firstLaunch  {
            println("Not first launch.")
            let detailVC = ScrollViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(detailVC, animated: true)

        }
        else {
            println("First launch, setting NSUserDefault.")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            let detailVC = IntroViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(detailVC, animated: true)
            
            NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "onvoltooid")
            NSUserDefaults.standardUserDefaults().synchronize()


        }
    }
    
}

