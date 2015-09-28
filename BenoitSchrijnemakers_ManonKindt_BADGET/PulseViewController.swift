////
////  PulseViewController.swift
////  BenoitSchrijnemakers_ManonKindt_BADGET
////
////  Created by Manon Kindt on 29/05/15.
////  Copyright (c) 2015 Manon Kindt. All rights reserved.
////
//
import UIKit
import CoreHeart
//import CircleProgressView
import Alamofire

class PulseViewController: UIViewController, CoreHeartDelegate, UIImagePickerControllerDelegate {
    
    var progressView =  UIProgressView()
    var core = CoreHeart()
    //	@IBOutlet weak var p: EKGPlotter?
    var l2: UILabel?
    var p2:EKGPlotter?
    var buttonImage = UIImage(named: "FingerCam")
    var filmImage = UIImage(named: "film")
    var imageButtonStart = UIImageView()
    var filmStart = UIImageView()
    var Sendconcert:String
    var progressLabel = UILabel()
    var attString:NSMutableAttributedString
    var customFontLabel = UILabel()
    var displayLabel = UILabel()
    var averageLabel = UILabel()
    var update = CAShapeLayer()
    var update2 = CAShapeLayer()
    var bounds = CGRect()
    var sendPulse = Int()
    
    var counter = Int()

    var theView:PulseView {
        get {
            return self.view as! PulseView!
        }
    }
    
    init(concert:String) {
        
        bounds = UIScreen.mainScreen().bounds
        println(concert)
        Sendconcert = String(concert)
        
        attString = NSMutableAttributedString()
        
        super.init(nibName: nil, bundle: nil)
        
        var anchor = CGPoint(x: 0 , y : 0)
        var transform = CATransform3DRotate(self.update.transform, CGFloat( ( -1.2 ) / 180.0 * M_PI )  , 0, 0, 1)
        var color = UIColor(red: 72/255, green: 153/255, blue: 211/255, alpha: 1.0).CGColor
        
        self.update.anchorPoint = anchor
        self.update.transform = transform
        self.update.fillColor = color
        
        self.update2.anchorPoint = anchor
        self.update2.transform = transform
        self.update2.fillColor = color
    
        var frameSize = CGRectMake(25, bounds.size.height/2 - 104, buttonImage!.size.width/2, buttonImage!.size.height/1.9)
        
        imageButtonStart = UIImageView(frame: frameSize)
        imageButtonStart.image = buttonImage
        
        filmStart = UIImageView(frame: frameSize)
        filmStart.image = filmImage
        
        self.customFontLabel = UILabel(frame: CGRectMake(90, 370, 175, 240))
        self.customFontLabel.numberOfLines = 0
        self.customFontLabel.tintColor = UIColor.yellowColor()
        self.customFontLabel.font = UIFont(name: "EvelethLight", size: 17)
    
        progressLabel.frame = CGRectMake(bounds.size.width/2 - 60, 100 , 175, 240)
        progressLabel.textColor = UIColor(red: 203/255, green: 74/255, blue: 79/255, alpha: 1.0)
        progressLabel.font = UIFont(name: "EvelethLight", size: 25)
        
        averageLabel.frame = CGRectMake(bounds.size.width/2 - 90, 200 , 240, 240)
        averageLabel.textColor = UIColor(red: 72/255, green: 153/255, blue: 211/255, alpha: 1.0)
        averageLabel.font = UIFont(name: "EvelethLight", size: 17)
        
        displayLabel = UILabel()
        displayLabel.frame = CGRectMake(10, 390, 200, 200)
        displayLabel.font = UIFont(name: "EvelethLight", size: 50)
        self.displayLabel.textColor = UIColor(red: 88/255, green: 200/255, blue: 250/255, alpha: 1.0)

        self.view.addSubview(averageLabel)
        self.view.addSubview(displayLabel)
        self.view.addSubview(progressLabel)
        self.view.addSubview(averageLabel)

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = PulseView(frame: bounds)
        self.view.addSubview(imageButtonStart)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLabel.text = "2"
        
        self.attString = NSMutableAttributedString(string: "let us find out how much you love them live.")
        
        self.attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, self.attString.length))
        self.customFontLabel.attributedText = self.attString
    
        self.view.addSubview(self.customFontLabel)

        
        var bounds = UIScreen.mainScreen().bounds
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        println("CoreHeart version: \(core.version)")
        
        let arrow = UIImage(named: "arrowBack")

          let backButton = UIBarButtonItem(image: arrow, style: UIBarButtonItemStyle.Done, target: self, action: "closeView")
          navigationItem.setLeftBarButtonItem(backButton, animated: true)
          navigationItem.backBarButtonItem = backButton
          navigationItem.backBarButtonItem?.tintColor = UIColor(patternImage: arrow!)

        if(UIImagePickerController.isSourceTypeAvailable(.Camera)){
            println("Pulse beschikbaar")
            
            core.delegate = self
            core.start()
            
            self.p2 = EKGPlotter(frame: CGRectMake(70, bounds.size.height/2 - 90, 180, 100))
            self.p2?.plotColor = UIColor(red: 36/255, green: 65/255, blue: 154/255, alpha: 1.0)
            self.p2?.backgroundColor = UIColor(white: 0, alpha: 0)
            core.plotter = p2
            
            
            p2?.drawGrid = false
            
            
            self.l2 = UILabel(frame: CGRectMake(50, 200, 20, 20))
            
            self.progressView.setProgress(0, animated: true)
//            self.progressView = CircleProgressView(frame: CGRectMake(50, 200, 50, 50))
            //        self.progressView?.backgroundColor = UIColor.whiteColor()
            self.view.addSubview(self.progressView)
            self.view.addSubview(self.progressLabel)
            
        }else{
            
            println("Pulse niet beschikbaar")
            
        }
    }
    
    
    func closeView(){
        println("close view")
        self.navigationController?.popViewControllerAnimated(true)
    }

    func receivedPulse(bpm: Int, progress: Double) {
        println("Received pulse \(bpm) with progression: \(progress)")
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            var width = (self.buttonImage!.size.height/2.3 + 2) * CGFloat(1 - progress)
            
            self.update.path = UIBezierPath(rect: CGRectMake(27, self.bounds.size.height/2 - 93, 7, width )).CGPath
            self.update2.path = UIBezierPath(rect: CGRectMake(261, self.bounds.size.height/2 - 95, 7, width )).CGPath
            
            self.imageButtonStart.removeFromSuperview()
            self.progressView.progress = Float(progress)
            self.progressLabel.text = "\(bpm) BPM"
            self.l2?.adjustsFontSizeToFitWidth = true
            self.view.addSubview(self.l2!)
            
            if(progress >= 0.2){
                
                self.counter = self.counter + bpm
                println(self.counter )
                println(progress * 10)
                
                var average = Double(self.counter) / ( progress / 0.2 )
                self.averageLabel.text = "average: \(Int(average)) BPM"
            
                println("average: \(average) bpm")
                self.view.bringSubviewToFront(self.averageLabel)
                self.sendPulse = Int(average)
            }

        })
    }
    
    func statusDidChange(status: CHStatus) {
        switch(status) {
        case .Waiting:
            println("Waiting for finger")
        case .DetectingPulse:
            println("Detecting pulse")
            
            self.view.layer.addSublayer(self.update)
            self.view.layer.addSublayer(self.update2)
            self.view.addSubview(filmStart)
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(30.0 * Double(NSEC_PER_SEC)))
            
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                if self.progressView.progress < 0.1 {
                    let message = "Are you alive? We did not register a pulse... Wanna try again?"
                    
                    var popViewController = ChallengePopUpViewController()
                    popViewController.showInViewFailed(self.view, withBadge: "badge2", withMessage: message, animated: true)

                }
                
            }
            imageButtonStart.removeFromSuperview()
            self.view.addSubview(self.p2!)
        case .Measurement:
            println("Measuring...")
        case .Completed:
            println("Completed!")
            
            self.customFontLabel.removeFromSuperview()
            
            displayLabel.text = "3"
            
            self.attString = NSMutableAttributedString(string: "Looks like your heart belongs to \(Sendconcert)...")
            
            self.attString.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(0, self.attString.length))
                       self.customFontLabel.attributedText = self.attString
            
            self.view.addSubview(self.customFontLabel)
            
            
        default:
            println("Unknown status")
        }
    }
    
    func completed(bpm: Int) {
        println("Completed with BPM: \(self.sendPulse)")
        
        let BadgeRetrieved = NSUserDefaults.standardUserDefaults().boolForKey("Badge2")
        if BadgeRetrieved  {
            println("Didn't retrieve")
        }
        else {
            
            println("Congratulations, You scored Badge 2")
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Badge2")
            
            var score = NSUserDefaults.standardUserDefaults().integerForKey("onvoltooid")
            
            NSUserDefaults.standardUserDefaults().setInteger(score - 1, forKey: "onvoltooid")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let message = "You unlocked the badge. You need" + String(Sendconcert)
            var popViewController = ChallengePopUpViewController()
            popViewController.showInViewCompleted(self.view, withBadge: "badge2", withMessage: message, withImage: UIImage(), withPulse: self.sendPulse, animated: false)

            
            let parameters = [
                "pulse": self.sendPulse,
                "concert": String(Sendconcert)
            ]
            
            Alamofire.request(.POST, "http://student.howest.be/manon.kindt/20142015/MA4/BADGET/api/pulse", parameters: parameters as? [String : AnyObject], encoding: .JSON)
                .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                println(totalBytesWritten)
                }
                .responseJSON { (request, response, JSON, error) in
                    println(request)
                    println(response)
                    println(JSON)
                    println(error)
            }
            // HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}
        }
    }
    
    func error(err: CHError) {
        switch(err) {
        case .Auth:
            println("Check for AVAuthorizationStatus")
        default:
            println("Unknown error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

