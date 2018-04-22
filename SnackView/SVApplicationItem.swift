//
//  SVApplicationItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVApplicationItem is an SVItem with which to show an image, a title and a description text.
 
 It can be useful to show the icon with title and description of an application, of an in-app purchase or to show a list of steps.
 */
public class SVApplicationItem: SVItem {
    
    //MARK: - Initialization Method
    /**
     Initialization method for SVApplicationItem view. You can customize this item with image, title and description text.
     - parameter icon: The image you want to show at left of title and description text
     - parameter title: The title of application or in-app purchase
     - parameter description: The description text of application or in-app purchase
     */
    public init(withIcon icon: UIImage, withTitle title: String, andDescription description: String) {
        super.init()
        
        //Create left container
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageContainer)
        
        
        //Add constraints for left container
        let imageContainerHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageContainer(==\(self.leftContentWidth))]", options: [], metrics: nil, views: ["imageContainer":imageContainer])
        self.addConstraints(imageContainerHContraints)
        
        let imageContainerVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageContainer]-|", options: [], metrics: nil, views: ["imageContainer":imageContainer])
        self.addConstraints(imageContainerVContraints)
        
        
        //Add image view into container
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = icon
        imageContainer.addSubview(imageView)
        
        
        //Add constraints to imageView
        let imageHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageView(40)]|", options: [], metrics: nil, views: ["imageView":imageView])
        imageContainer.addConstraints(imageHContraints)
        
        let imageVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView(40)]-(>=0)-|", options: [], metrics: nil, views: ["imageView":imageView])
        imageContainer.addConstraints(imageVContraints)
        
        
        //Customize the UI of imageView
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
        
        
        //Add title label
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        
        
        //Add constraints to titleLabel
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageContainer]-[titleLabel]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel, "imageContainer":imageContainer])
        self.addConstraints(titleHContraints)
        
        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleVContraints)
        
        
        //Add description label
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = description
        descriptionLabel.textColor = grayTextColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)
        
        
        //Add constraints to descriptionLabel
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageContainer]-[descriptionLabel]-|", options: [], metrics: nil, views: ["imageContainer":imageContainer, "descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionHContraints)
        
        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[titleLabel][descriptionLabel]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel, "descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionVContraints)
    }
    
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}

