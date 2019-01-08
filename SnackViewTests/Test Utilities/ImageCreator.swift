//
//  ImageCreator.swift
//  SnackViewTests
//
//  Created by Luca Casula on 08/01/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import UIKit

class ImageCreator {

    static func getImageWith(size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.orange.setFill()
        UIRectFill(rect)

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image
    }

}
