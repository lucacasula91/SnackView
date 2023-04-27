//
//  Extensions.swift
//  
//
//  Created by Luca Casula on 21/04/23.
//

import UIKit

extension UIImage {
    class func generateBlackSquare() -> UIImage {
        let size = CGSize(width: 100, height: 100)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.black.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
