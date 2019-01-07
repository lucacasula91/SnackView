//
//  SVCustomItem.swift
//  SnackViewExample
//
//  Created by Kevin Morton on 1/6/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import Foundation
import SnackView
import UIKit

/// Example for creating custom SVItems.
class SVCustomItem: SVItem {
    
    init(with color: UIColor) {
        super.init()
        
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = color
        self.addSubview(customView)
        
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[customView(70)]-|", options: [], metrics: nil, views: ["customView": customView])
        
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[customView]-|", options: [], metrics: nil, views: ["customView": customView])
        
        self.addConstraints(vConstraints + hConstraints)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}
