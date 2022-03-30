//
//  UIView-Extensions.swift
//  SnackView
//
//  Created by Luca Casula on 11/06/21.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import UIKit

extension UIView {
    public func addVisualConstraint(_ constrantFormat: String, for views: [String : Any]) {

        let constraint = NSLayoutConstraint.constraints(withVisualFormat: constrantFormat,
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: views)
        self.addConstraints(constraint)
    }
}

