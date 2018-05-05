//
//  SVImageViewItem.swift
//  SnackView
//
//  Created by Luca Casula on 02/05/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

import UIKit

class SVImageViewItem: SVItem {
    
    public init(withImage image: UIImage) {
        super.init()
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        
        
        //Add constraints to descriptionLabel
        let imageViewHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: ["imageView":imageView])
        self.addConstraints(imageViewHContraints)
        
        let imageViewVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: ["imageView":imageView])
        self.addConstraints(imageViewVContraints)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

}
