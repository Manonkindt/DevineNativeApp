//
//  ViewController.swift
//  CoreMotionTests
//
//  Created by Manon Kindt on 30/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit
import CoreMotion

class TentViewController: UIViewController {
    
    let manager = CMMotionManager()
   
    var imageButtonStart = UIButton()
    
    
    var theView:TentView! {
        get {
            return self.view as! TentView!
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
         var bounds = UIScreen.mainScreen().bounds
        super.init(nibName: nil, bundle: nil)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let arrow = UIImage(named: "arrowBack")
        
        let backButton = UIBarButtonItem(image: arrow, style: UIBarButtonItemStyle.Done, target: self, action: "closeView")
        navigationItem.setLeftBarButtonItem(backButton, animated: true)
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.tintColor = UIColor(patternImage: arrow!)

        // Do any additional setup after loading the view.
    }
    
    func startMoment(){
        var bounds = UIScreen.mainScreen().bounds
        self.view = TentView(frame: bounds)
        
        self.view.addSubview(imageButtonStart)
        
        if manager.gyroAvailable {
            println("[Gyro] is Available")
            
            manager.gyroUpdateInterval = 0.1;
            manager.startGyroUpdates()
            
            manager.stopGyroUpdates()
            
        } else {
            println("[Gyro] is Not Available")
        }

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
        var bounds = UIScreen.mainScreen().bounds
        self.view = TentView(frame: bounds)
        
         self.view.addSubview(imageButtonStart)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
