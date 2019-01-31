//
//  SVImageViewItem.swift
//  SnackView
//
//  Created by Luca Casula on 02/05/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

import UIKit

public class SVImageViewItem: SVItem {

    public init(withImage image: UIImage, andContentMode contentMode: UIView.ContentMode, andHeight height: CGFloat? = nil) {
        super.init()
        
        self.setMinimumHeightActive(active: false)

        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = contentMode
        self.addSubview(imageView)

        //Add constraints to descriptionLabel
        let views = ["imageView": imageView] as [String: Any]
        let imageViewHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: views)

        let imageViewVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: views)
        self.addConstraints(imageViewHContraints)
        self.addConstraints(imageViewVContraints)

        if let customHeight = height {
            imageView.heightAnchor.constraint(equalToConstant: customHeight).isActive = true
        }
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

}
