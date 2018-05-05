//
//  SVTitleItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

class SVTitleItem: SVItem {
    
    //MARK: - Variables
    var title:String!
    var cancelButtonTitle:String!
    var cancelButton:UIButton!
    
    
    public init(withTitle title:String, andCancelButton cancelButtonTitle:String) {
        super.init()
        
        //Disable minimum height value
        self.setMinimumHeightActive(active: false)
        
        self.title = title
        self.cancelButtonTitle = cancelButtonTitle
        
        //Add title label
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = self.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(titleLabel)
        
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]|", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleVContraints)
        
        //Add cancel Button
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle(self.cancelButtonTitle, for: UIControlState())
        cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: UIControlState.normal)
        cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5), for: UIControlState.highlighted)
        self.addSubview(cancelButton)

        let cancelButtonHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[cancelButton]-|", options: [], metrics: nil, views: ["cancelButton":cancelButton])
        self.addConstraints(cancelButtonHContraints)
        
        let cancelButtonVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[cancelButton]|", options: [], metrics: nil, views: ["cancelButton":cancelButton])
        self.addConstraints(cancelButtonVContraints)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}
