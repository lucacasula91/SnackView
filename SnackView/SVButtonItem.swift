//
//  BAbuttonItem.swift
//  BottomAllert
//
//  Created by Luca Casula on 09/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

public class SVButtonItem: SVItem {
    
    var tmpAction:() -> Void = {}
    @objc func buttonSelector() {
        self.tmpAction()
    }
    
    public init(withTitle title:String, tintColor color:UIColor = #colorLiteral(red: 0, green: 0.4779834747, blue: 0.9985283017, alpha: 1), withButtonAction buttonAction:@escaping () -> Void) {
        super.init()
       
        self.tmpAction = buttonAction
        
        let buttonItem = UIButton()
        buttonItem.translatesAutoresizingMaskIntoConstraints = false
        buttonItem.setTitle(title, for: UIControlState())
        buttonItem.setTitleColor(color, for: UIControlState.normal)
        buttonItem.setTitleColor(color.withAlphaComponent(0.5), for: UIControlState.highlighted)
        buttonItem.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        self.addSubview(buttonItem)
        
        let buttonHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[buttonItem]-|", options: [], metrics: nil, views: ["buttonItem":buttonItem])
        self.addConstraints(buttonHContraints)
        
        let buttonVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[buttonItem]-|", options: [], metrics: nil, views: ["buttonItem":buttonItem])
        self.addConstraints(buttonVContraints)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}

