//
//  DetailViewController.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 28/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, PulseDetailDelegate {
    
    var badgeData:BadgeData
    
    var theView:DetailView! {
        get {
            return self.view as! DetailView!
        }
    }
    
    init (badgeData: BadgeData) {

        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let theFile = documentsPath.stringByAppendingString("likes")
        
                if let loadedFile = NSKeyedUnarchiver.unarchiveObjectWithFile(theFile) as? BadgeData {
                    self.badgeData = loadedFile
                    println(loadedFile)
                }
                else{
                    self.badgeData = badgeData
                }
        
        super.init(nibName: nil, bundle: nil)
        self.navigationController?.navigationBar
        self.theView.createLabels(badgeData)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = DetailView(frame: bounds)
    }
    
    override func viewDidLoad() {
        //add title with incoming data
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let arrow = UIImage(named: "arrowBack")
        
        let backButton = UIBarButtonItem(image: arrow, style: UIBarButtonItemStyle.Done, target: self, action: "closeView")
        navigationItem.setLeftBarButtonItem(backButton, animated: true)
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.tintColor = UIColor(patternImage: arrow!)
        
        self.theView.delegate = self
    }
    func closeView(){
        println("close view")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func pulseTapped(concert:String) {
        println("pulseTapped functie")
        let detailVC = PulseViewController(concert: concert)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    func moveTapped() {
        println("moveTapped functie")
        let TentVC = TentViewController()
        self.navigationController?.pushViewController(TentVC, animated: true)
    }

}
