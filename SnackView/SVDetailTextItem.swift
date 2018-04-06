//
//  SVDetailText.swift
//  BottomAllert
//
//  Created by Luca Casula on 10/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

public class SVDetailTextItem: SVItem {
    
    public init(withTitle title:String, andContent content:String) {
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
        
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==111)]", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleHContraints)
        
        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(8)-[titleLabel(>=28)]-(8)-|", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleVContraints)
        
        //Add description item
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = content
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)
        
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-[descriptionLabel]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel, "descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionHContraints)
        
        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionVContraints)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
