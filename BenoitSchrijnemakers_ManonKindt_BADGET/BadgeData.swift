//
//  BadgeData.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 27/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

class BadgeData: NSObject {
    
    let id:Int
    let title:String
    let created:String
    let Description:String
    let subtitle:String
    let image:String
    let bg:String
    
    init(id:Int, title:String, created:String, Description:String, subtitle:String, image:String, bg:String){
        
        self.id = id
        self.title = title
        self.created = created
        self.Description = Description
        self.subtitle = subtitle
        self.image = image
        self.bg = bg

    }
    
    override var description:String{
        get{
            return "[BadgeData] \(id) - \(title) - \(created) - \(Description) - \(subtitle) - \(image)"
        }
    }
    
}

