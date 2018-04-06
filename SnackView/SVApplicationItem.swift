//
//  BADescripionItem.swift
//  BottomAllert
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

public class SVApplicationItem: SVItem {
    
    public init(withIcon icon:UIImage, withTitle title:String, andDescription description:String) {
        super.init()
        
        //Create Image container
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageContainer)
        
        let imageContainerHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageContainer(==111)]", options: [], metrics: nil, views: ["imageContainer":imageContainer])
        self.addConstraints(imageContainerHContraints)
        
        let imageContainerVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageContainer]-|", options: [], metrics: nil, views: ["imageContainer":imageContainer])
        self.addConstraints(imageContainerVContraints)
        
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = icon
        imageContainer.addSubview(imageView)
        
        let imageHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageView(40)]|", options: [], metrics: nil, views: ["imageView":imageView])
        imageContainer.addConstraints(imageHContraints)
        
        let imageVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView(40)]-(>=0)-|", options: [], metrics: nil, views: ["imageView":imageView])
        imageContainer.addConstraints(imageVContraints)
        
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
        
        
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageContainer]-[titleLabel]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel, "imageContainer":imageContainer])
        self.addConstraints(titleHContraints)
        
        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleVContraints)
        
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = description
        descriptionLabel.textColor = grayTextColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)
        
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageContainer]-[descriptionLabel]-|", options: [], metrics: nil, views: ["imageContainer":imageContainer, "descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionHContraints)
        
        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[titleLabel][descriptionLabel]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel, "descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionVContraints)
        
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

