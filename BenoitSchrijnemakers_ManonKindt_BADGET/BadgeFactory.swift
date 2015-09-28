//
//  BadgeFactory.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 27/05/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import Foundation

class BadgeFactory {

    
    class func createFromJSONData( data:NSData ) -> Array<BadgeData> {
        
        let json = JSON(data: data)
        
        var badgeArray = Array<BadgeData>()
        
        for (index: String, subJson: JSON) in json {
            
            let id = subJson["id"]
            let title = subJson["title"]
            let subtitle = subJson["subtitle"]
            let created = subJson["created"]
            let desc = subJson["Description"]
            let image = subJson["image"]
            let bg = subJson["bg"]
            
            let badgedata = BadgeData(id: id.intValue, title: title.stringValue, created: created.stringValue,  Description: desc.stringValue, subtitle: subtitle.stringValue, image: image.stringValue, bg: bg.stringValue)
            
            badgeArray.append(badgedata)
            
        }
        
        return badgeArray;
    }
    
}