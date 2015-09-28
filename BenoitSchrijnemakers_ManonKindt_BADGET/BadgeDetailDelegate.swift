//
//  BadgeDetailDelegate.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 28/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

protocol BadgeDetailDelegate:class {
    
    func imageTapped(index:Int)
    
    func popView(badge:String, index:Int)
    
}

