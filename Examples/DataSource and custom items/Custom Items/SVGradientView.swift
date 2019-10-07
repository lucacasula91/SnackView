//
//  SVGradientView.swift
//  SnackViewExample
//
//  Created by Luca Casula on 23/01/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import UIKit

@IBDesignable class SVGradientView: UIView {

    // MARK: - Properties
    fileprivate var gradientView: CAGradientLayer?
    @IBInspectable public var startColor: UIColor!
    @IBInspectable public var endColor: UIColor!

    // MARK: - System Methods
    override func draw(_ rect: CGRect) {

        self.setGradientView(with: rect)
    }

    // MARK: - Fileprivate methods
    fileprivate func setGradientView(with rect: CGRect) {
        if gradientView == nil {
            gradientView = CAGradientLayer()
            gradientView?.frame = rect
            gradientView?.startPoint = CGPoint(x: 0, y: 0)
            gradientView?.endPoint = CGPoint(x: 1, y: 1)

            self.layer.insertSublayer(gradientView!, at: 0)
        }
        gradientView?.colors = [startColor.cgColor, endColor.cgColor]

    }
}
