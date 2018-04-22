//
//  SSVTitleOptions.swift
//  SnackView
//
//  Created by Luca Casula on 21/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVTitleOptions is a struct with which to customize the appearance of SVTitleItem. */
public struct SVTitleOptions {
    
    //MARK: - Variables
    
    /** The title of SVTitleItem */
    var title:String
    
    /** A boolean value with which to set visible or hidden the close button. */
    var closeButtonVisible:Bool
    
    /** The title of the close button */
    var closeButtonTitle:String
    
    
    //MARK: - Initialization Method
    /**
     Initialization method for SVTitleOptions struct. You can customize SVTitleItem with title, can also choose to set Close button hidden and change the title of Close button.
     - parameter title: The title of SVTitleItem
     - parameter isVisible: A boolean value with which to set close button visible or hidden
     - parameter closeButtonTitle: The title of Close button
     */
    public init(withTitle title: String, setCloseButtonVisible isVisible: Bool, setCloseButtonTitle closeButtonTitle: String?) {
        self.title = title
        self.closeButtonVisible = isVisible
        self.closeButtonTitle = closeButtonTitle ?? ""
    }
}
