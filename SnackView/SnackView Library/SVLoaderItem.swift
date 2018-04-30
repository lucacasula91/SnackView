//
//  SVLoaderItem.swift
//  SnackView
//
//  Created by Luca Casula on 22/03/18.
//  Copyright © 2018 Luca Casula. All rights reserved.
//

import UIKit

/** SVLoaderItem is an item that show an animated activity indicator view. The item can be more specific by showing a text message. */
public class SVLoaderItem: SVItem {
    
    /** Enumerator describing the size of activity indicator item */
    public enum ActivityIndicatorSize {
        /** The default size of UIActivityIndicatorView */
        case little
        
        /** The large style of UIActivityIndicatorView */
        case large
    }
    
    
    //MARK: - Initialization Method
    /**
     Initialization method for SVLoaderItem view. You can customize this item with size of the activity indicator view and a custom text message.
     - parameter size: The size of activity indicator view
     - parameter text: A text that can appear on top of activity indicator view
     */
    public init(withSize size: ActivityIndicatorSize, andText text: String?) {
        super.init()
        
        //Disable auto height to handle it manually
        self.setMinimumHeightActive(active: false)
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: size == .little ? 50 : 70).isActive = true
        
        
        //Add activity indicator view
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: size == .little ? .gray : .whiteLarge )
        activityIndicator.color = UIColor.gray
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        
        
        //Check for text
        if let unwrappedText = text {
            let messageLabel = UILabel()
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.textColor = self.grayTextColor
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.text = unwrappedText
            self.addSubview(messageLabel)
            
            
            //Add constraints to message label
            let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[messageLabel]-|", options: [], metrics: nil, views: ["messageLabel":messageLabel])
            
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[messageLabel]-[activityIndicator]-|", options: [], metrics: nil, views: ["messageLabel":messageLabel, "activityIndicator":activityIndicator])
            self.addConstraints(hConstraints + vConstraints)
            
            
            //Add constraint to center the activity indicator in center X anchor
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
        else {
            //Add constraints to center the anctivity indicator inside the container.
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
