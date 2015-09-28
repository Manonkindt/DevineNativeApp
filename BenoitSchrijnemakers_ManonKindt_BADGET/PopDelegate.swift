//
//  PopDelegate.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 10/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

protocol PopDelegate:class {
    
    func removeAnimate(index:Int)
    
    func overview()
    
    func retakePicture(index:Int)
    
    func facebookShare(image:UIImage, data:Int, check: Bool, message: String)
    
}
