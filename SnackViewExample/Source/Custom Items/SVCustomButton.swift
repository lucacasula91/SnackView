//
//  SVCustomButton.swift
//  SnackViewExample
//
//  Created by Luca Casula on 23/01/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import UIKit

class SVCustomButton: UIButton {

    override func draw(_ rect: CGRect) {

        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: 5).cgPath
        backgroundLayer.fillColor   = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        backgroundLayer.strokeColor = #colorLiteral(red: 0.09934405237, green: 0.5319405794, blue: 0.9981620908, alpha: 1)
        backgroundLayer.lineWidth   = 2.0

        self.layer.insertSublayer(backgroundLayer, at: 0)

        self.setTitleColor(.white, for: UIControl.State())
        self.backgroundColor = UIColor.clear

    }

}
