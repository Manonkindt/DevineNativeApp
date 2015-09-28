//
//  CameraViewController.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 28/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//


import UIKit
import Alamofire
import Photos
import AFNetworking

//16.   Implement two protocols to get delegate methods of imagepicker.
class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagepicker = UIImagePickerController()
    var imageView:UIImageView?
    var overlayIV:UIImageView?
    var customFontLabel:UILabel?
    let staticView: UIView
    var textFontLabel:UILabel!
    
    var badgeData:BadgeData
    
    var theView:CameraView {
        get {
            return self.view as! CameraView!
        }
    }

   init (badgeData: BadgeData) {
        
        self.staticView = UIView()
        
        self.badgeData = badgeData
        
        super.init(nibName: nil, bundle: nil)
        
        self.navigationController?.navigationBar
        self.theView.loadBG(badgeData)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        var bounds = UIScreen.mainScreen().bounds
        self.view = CameraView(frame: bounds)
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            println("missing image at: (path)")
        }
        println("(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.theView.imageButtonStart.addTarget(self, action: "CameraButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
        self.theView.retakeButtonStart.addTarget(self, action: "CameraButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
        
        let arrow = UIImage(named: "arrowBack")
        
        let backButton = UIBarButtonItem(image: arrow, style: UIBarButtonItemStyle.Done, target: self, action: "closeView")
        navigationItem.setLeftBarButtonItem(backButton, animated: true)
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.tintColor = UIColor(patternImage: arrow!)
        println("[CameraVC] Getting Camera")
    }
    
    func closeView(){
        println("close view")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //9.    Execute when camera button is tapped.
    func CameraButtonTouched(){
        
        println("in camerabuttontouchedfunctie")
        
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)){
            println("Camera beschikbaar")
            
//            var mediatypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)
            
            imagepicker.sourceType = UIImagePickerControllerSourceType.Camera
            
             imagepicker.mediaTypes = [kUTTypeImage]
            
            let square = imagepicker.view.bounds
            square.size.height ==  square.size.height - imagepicker.navigationBar.bounds.size.height*2
            
            println(imagepicker.navigationBar.bounds.size.height)
            
            let barHeight = (square.size.height - square.size.width) / 2
            UIGraphicsBeginImageContext(square.size)
        
            drawRect(square, barHeight: barHeight)

            let overlayImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            overlayIV = UIImageView(frame: square)
            overlayIV!.image = overlayImage
            imagepicker.cameraOverlayView!.addSubview(overlayIV!)
            imagepicker.cameraOverlayView!.sendSubviewToBack(overlayIV!)

        
            imagepicker.delegate = self
            self.presentViewController(imagepicker, animated: true, completion: nil)
            self.imagepicker.cameraOverlayView = nil
            
            addPhotoObservers()
            
        }else{
            
            println("Camera niet beschikbaar")
            
        }
        
    }
    
    func drawRect(square:CGRect, barHeight: CGFloat){
        UIColor(white: 0, alpha: 0.5).setFill()
        
        UIRectFillUsingBlendMode(CGRectMake(0, 0, square.size.width, barHeight), kCGBlendModeNormal)
        UIRectFillUsingBlendMode(CGRectMake(0, square.size.height - barHeight, square.size.width, barHeight), kCGBlendModeNormal)
        

    }
    
    func addPhotoObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeCameraOverlay", name: "UIImagePickerControllerUserDidCaptureItem", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addCameraOverlay", name: "_UIImagePickerControllerUserDidRejectItem", object: nil)
        
    }
    
    func removePhotoObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func addCameraOverlay() {
        self.imagepicker.cameraOverlayView = self.overlayIV
    }
    
    func removeCameraOverlay() {
        self.imagepicker.cameraOverlayView = nil;
    }

    //18.   Execute when image is taken.
    func imagePickerController(picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        
        if(picker.sourceType == UIImagePickerControllerSourceType.Camera){
            // Access the uncropped image from info dictionary
            var imageToSave: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage //same but with different way
            println("image save")
            
           let croppedImage: UIImage = ImageUtil.cropToSquare(image: imageToSave)
            
            UIImageWriteToSavedPhotosAlbum(croppedImage, nil, nil , nil)
            self.dismissViewControllerAnimated(true, completion: nil)
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(1.0 * Double(NSEC_PER_SEC)))
            
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.theView.saveLala()

            }
        }
    }
    
    func urlRequestWithComponents(urlString:String, parameters:Dictionary<String, String>, imageData:NSData) -> (URLRequestConvertible, NSData) {
        
        // create url request to send
        var mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
        let boundaryConstant = "myRandomBoundary12345";
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add image
        uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Disposition: form-data; name=\"file\"; filename=\"file.png\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Type: image/png\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData(imageData)
        
        // add parameters
        for (key, value) in parameters {
            uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        // return URLRequestConvertible and NSData
        return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

