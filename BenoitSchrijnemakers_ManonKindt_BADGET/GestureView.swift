//
//  GestureView.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 11/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

//
//  MyView.swift
//  GestureFun
//
//  Created by Les on 3/15/15.
//  Copyright (c) 2015 Benoit Schrijnemakers. All rights reserved.
//

import UIKit

class GestureView: UIView {
    
    let imageView:UIImageView
    
    override init(frame: CGRect){
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        
        super.init(frame:frame)
        
        self.imageView.center = self.center
        
        self.addSubview(self.imageView)
        
    }
    
    func showImage(selected:String){
        
        self.imageView.image = UIImage(named:selected)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
