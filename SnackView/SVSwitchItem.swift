//
//  SVSwitchItem.swift
//  SnackView
//
//  Created by Luca Casula on 09/04/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

import UIKit

public class SVSwitchItem: SVItem {
    
    var tmpAction:(_ switchValue: Bool) -> Void = {_ in }
    @objc func switchSelector(switchItem: UISwitch) {
        self.tmpAction(switchItem.isOn)
    }
    
    public init(withTitle title:String, andContent content:String?, withSwitchAction switchAction:@escaping (_ switchValue: Bool) -> Void) {
        super.init()
        self.tmpAction = switchAction
        
        
        //Add title item
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title.uppercased()
        titleLabel.textAlignment = .right
        titleLabel.textColor = grayTextColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==\(self.leftContentWidth))]", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleHContraints)
        
        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleVContraints)
        

        
        //Add switch item
        let switchItem = UISwitch()
        switchItem.translatesAutoresizingMaskIntoConstraints = false
        switchItem.addTarget(self, action: #selector(switchSelector(switchItem:)), for: .valueChanged)
        switchItem.tintColor = self.grayTextColor
        self.addSubview(switchItem)

        let switchHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[switch]-|", options: [], metrics: nil, views: ["switch":switchItem])
        self.addConstraints(switchHContraints)
       
        let switchVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[switch]", options: [], metrics: nil, views: ["switch":switchItem])
        self.addConstraints(switchVContraints)
        
        
        //Add description item
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        if let text = content {
            descriptionLabel.text = text
        }
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)
        
        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionVContraints)
        
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[titleLabel]-[descriptionLabel]-[switch]", options: [], metrics: nil, views: ["titleLabel":titleLabel, "switch":switchItem, "descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionHContraints)
        
    }
    
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}
