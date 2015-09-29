//
//  ScrollView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 27/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit
import Alamofire

class ScrollViewController: UIViewController, BadgeDetailDelegate, UIScrollViewDelegate {
    
    var badgesArray:Array<BadgeData>?
    
    var scrollView: UIScrollView!
    
    var pageControl = UIPageControl()
    let active = UIImage(named: "ball")
    let inactive = UIImage(named: "circle")
    
    var theView:SliderView! {
        get {
            return self.view as! SliderView!
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.pageControl.currentPage = 0
        println("in de ScrollViewController")
        self.getTweets()
        
        self.dismissViewControllerAnimated( true, completion:nil)
        

        
        println(self.badgesArray)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTweets(){
        println("[TweetsTVC] Getting Tweets")
        
        Alamofire.request(.GET, "http://student.howest.be/manon.kindt/20142015/MA4/BADGET/api/todos").responseJSON { (request, response, theData, error) -> Void in
            
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
                
                for challenge in self.badgesArray! {
                    
                    for index in 1...3 {
                        
                        var badge = "badge"+String(index)
                        
                        if NSUserDefaults.standardUserDefaults().boolForKey(String(badge)){
                            NSUserDefaults.standardUserDefaults().synchronize()
                        } else {
                            NSUserDefaults.standardUserDefaults().synchronize()
                        }
                    }
                }
            }
            
            self.theView.createImageViews(self.badgesArray!)
            
        }
    }
    
    func popView(badge: String, index: Int) {
        
        var popViewController = ChallengePopUpViewController()
        popViewController.showBadgesInView(self.badgesArray!, ArrayaView: self.view, withImage: UIImage(named: "tap"), withMessage: "You just triggered a great popup window", animated: true)
        
        if NSUserDefaults.standardUserDefaults().boolForKey(String(badge)){
            //            println("Voltooid")
        } else {
            //            println("Nog Niet Voltooid")
        }
    }
    
    func imageTapped(index:Int) {
        println("imageTapped")
        var data = badgesArray![index]
        if( index == 0){
            let camVC = CameraViewController(badgeData: data)
            self.navigationController?.pushViewController(camVC, animated: true)
        } else {
            
            let detailVC = DetailViewController(badgeData: data)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        
        println("[SVController] loaded sliderController")
        
        super.viewDidLoad()
        
        let arrow = UIImage(named: "arrowBack")
        
        let backButton = UIBarButtonItem(image: arrow, style: UIBarButtonItemStyle.Done, target: self, action: "closeView")
        navigationItem.setLeftBarButtonItem(backButton, animated: true)
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.tintColor = UIColor(patternImage: arrow!)
        
        self.theView.scrollView.delegate = self
        self.theView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        self.theView.scrollView.contentSize = CGSizeMake(self.theView.frame.size.width * 3, self.theView.scrollView.frame.size.height)
        self.theView.scrollView.pagingEnabled = true
        self.theView.scrollView.showsHorizontalScrollIndicator = false
        
        self.pageControl.frame = CGRectMake(110, theView.scrollView.frame.size.height - 150, 100, 100)
        self.pageControl.numberOfPages = 3
        self.pageControl.backgroundColor = UIColor(white: 0, alpha: 0)
        self.pageControl.userInteractionEnabled = false
        self.view.addSubview(self.pageControl)
        self.theView.arrowView.addSubview(self.theView.ArrowRightView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        var pageWidth = scrollView.frame.size.width
        
        var fractionalPage = scrollView.contentOffset.x / pageWidth
        var page = round(fractionalPage)
        
        self.theView.ArrowRightView.removeFromSuperview()
        self.theView.ArrowLeftView.removeFromSuperview()
        
        self.pageControl.currentPage = Int(page)
        
        if (self.pageControl.currentPage == 0){
            println("0")
            self.theView.arrowView.addSubview(self.theView.ArrowRightView)
        }
        if self.pageControl.currentPage == 1 {
            println("1")
            self.theView.arrowView.addSubview(self.theView.ArrowRightView)
            self.theView.arrowView.addSubview(self.theView.ArrowLeftView)
        }
        if self.pageControl.currentPage == 2 {
            println("2")
            self.theView.arrowView.addSubview(self.theView.ArrowLeftView)
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
        var bounds = UIScreen.mainScreen().bounds  //screensize instellen
        //        println("[ViewController] Loading custom view")
        self.view = SliderView(frame: bounds) //sliderview inladen!!
        
    }
}