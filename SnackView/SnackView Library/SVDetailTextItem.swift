//
//  SVDetailText.swift
//  SnackView
//
//  Created by Luca Casula on 10/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVDetailTextItem is an SVItem with which to show a title and a multi-line description text. */
public class SVDetailTextItem: SVItem {
    
    //MARK: - Initialization Method
    /**
     Initialization method for SVDetailTextItem view. You can customize this item with a title and a description text.
     - parameter title: The title to show
     - parameter description: The description text to show
     */
    public init(withTitle title: String, andDescription description: String) {
        super.init()
        
        //Add title item
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title.uppercased()
        titleLabel.textAlignment = .right
        titleLabel.textColor = grayTextColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        
        
        //Add constraints to titleLabel
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==\(self.leftContentWidth))]", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleHContraints)
        
        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleVContraints)
        
        
        //Add description item
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = description
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)
        
        
        //Add constraints to descriptionLabel
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-[descriptionLabel]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel, "descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionHContraints)
        
        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionVContraints)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}
