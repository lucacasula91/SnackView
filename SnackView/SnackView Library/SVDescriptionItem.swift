//
//  SVDescriptionItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVDescriptionItem is an SVItem with which to show a multi-line description text. */
public class SVDescriptionItem: SVItem {
    
    //MARK: - Initialization Method
    /**
     Initialization method for SVDescriptionItem view. You can customize this item with a description text.
     - parameter description: The text you want to show
     */
    public init(withDescription description: String) {
        super.init()
        
        //Add label item
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = description
        descriptionLabel.textColor = grayTextColor
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)
        
        
        //Add constraints to descriptionLabel
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionHContraints)
        
        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionVContraints)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}

