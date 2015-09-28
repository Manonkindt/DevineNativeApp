//
//  PageItemController.swift
//  BenoitSchrijnemakers_ManonKindt_BADGET
//
//  Created by Manon Kindt on 09/06/15.
//  Copyright (c) 2015 Manon Kindt. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    var contentImageView: UIImageView?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView?.image = UIImage(named: imageName)
    }
}
