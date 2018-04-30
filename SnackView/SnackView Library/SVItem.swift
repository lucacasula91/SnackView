//
//  SVItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/**
 SVItem is the main class with which all the items that can be used with SnackView have been created.
 
 SVItem provides by default some properties common to all elements such as the separator line that appears between the items or the minimum height of the item that is active by default.
 
 If you need to create a custom item, subclass the SVItem class first.
 */
open class SVItem: UIView {
    
    //MARK: - Private variables
    private var bottomLine:UIView!
    private var heightConstraint: NSLayoutConstraint?
    
    //MARK: - Public Variables
    public let leftContentWidth: CGFloat = 111
    public let grayTextColor = #colorLiteral(red: 0.5553562641, green: 0.5649003983, blue: 0.5733956099, alpha: 1)
    public let blueButtonColor = #colorLiteral(red: 0, green: 0.4779834747, blue: 0.9985283017, alpha: 1)
    
    //MARK: - Init Method
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear

        //Add separator line
        if bottomLine == nil {
            bottomLine = UIView()
            bottomLine.backgroundColor = UIColor.lightGray
            bottomLine.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(bottomLine)
            
            
            //Add constraints to bottomLine
            let bottomLineHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomLine]|", options: [], metrics: nil, views: ["bottomLine":bottomLine])
            let bottomLineVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomLine(0.5)]|", options: [], metrics: nil, views: ["bottomLine":bottomLine])
            self.addConstraints(bottomLineHConstraints + bottomLineVConstraints)
            
            
            //Add minimum view height
            self.heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
            if let tmpConstraint = self.heightConstraint {
                self.addConstraint(tmpConstraint)
            }
        }
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    //MARK: - Public Method
    /**
     Use this method to add or remove the automatic height constraint. SVItem has a minimum height value equal or greater than 50 pixels.
     - parameter active: Bool value
     */
    public func setMinimumHeightActive(active: Bool) {
        if active {
            if self.heightConstraint == nil {
                self.heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
                if let tmpConstraint = self.heightConstraint {
                    self.addConstraint(tmpConstraint)
                }
            }
        }
        else {
            if let tmpConstraint = self.heightConstraint {
                self.removeConstraint(tmpConstraint)
                self.heightConstraint = nil
            }
        }
    }
}
