//
//  BottomAlertItem.swift
//  BottomAllert
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

open class SVItem: UIView {

    private var bottomLine:UIView!
    public let leftContentWidth:Int! = 103

    public let grayTextColor = #colorLiteral(red: 0.5553562641, green: 0.5649003983, blue: 0.5733956099, alpha: 1)
    public let blueButtonColor = #colorLiteral(red: 0, green: 0.4779834747, blue: 0.9985283017, alpha: 1)

    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear

        if bottomLine == nil {
            bottomLine = UIView()
            bottomLine.backgroundColor = UIColor.lightGray
            bottomLine.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(bottomLine)
            
            let bottomLineHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomLine]|", options: [], metrics: nil, views: ["bottomLine":bottomLine])
            let bottomLineVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomLine(0.5)]|", options: [], metrics: nil, views: ["bottomLine":bottomLine])
            self.addConstraints(bottomLineHConstraints + bottomLineVConstraints)
            
            self.initializeItem()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initializeItem() {
        
    }
}
