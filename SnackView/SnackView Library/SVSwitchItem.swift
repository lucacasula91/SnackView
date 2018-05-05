//
//  SVSwitchItem.swift
//  SnackView
//
//  Created by Luca Casula on 09/04/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

import UIKit

/** SVSwitchItem is an SVItem with which to show a title, a description and a UISwitch */
public class SVSwitchItem: SVItem {
    
    //MARK: - Initialization Method
    /**
     Initialization method for SVSwitchItem view. You can customize this item with a title, a description text and an action to assign when UISwitch value change.
     - parameter title: The title you want to show
     - parameter description: The description text you want to show. This parameter is nullable
     - parameter switchAction: The action to perform when UISwitch value change
     */
    public init(withTitle title: String, andDescription description: String?, withSwitchAction switchAction:@escaping (_ switchValue: Bool) -> Void) {
        super.init()
        
        //Assign the UISwitch action to tmpAction
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
        
        
        //Add constraints to titleLabel
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

        
        //Add constraints to switchItem
        let switchHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[switch]-|", options: [], metrics: nil, views: ["switch":switchItem])
        self.addConstraints(switchHContraints)
       
        let switchVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[switch]", options: [], metrics: nil, views: ["switch":switchItem])
        self.addConstraints(switchVContraints)
        
        
        //Add description item
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        if let text = description {
            descriptionLabel.text = text
        }
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)
        
        //Add contraints to descriptionLabel
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionVContraints)
        
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[titleLabel]-[descriptionLabel]-[switch]", options: [], metrics: nil, views: ["titleLabel":titleLabel, "switch":switchItem, "descriptionLabel":descriptionLabel])
        self.addConstraints(descriptionHContraints)
        
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    
    //MARK: - Custom stuff
    var tmpAction:(_ switchValue: Bool) -> Void = {_ in }
    @objc func switchSelector(switchItem: UISwitch) {
        self.tmpAction(switchItem.isOn)
    }
}
