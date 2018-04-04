//
//  SVTitleItem.swift
//  SnackView
//
//  Created by Luca Casula on 21/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

public struct SVTitleOptions {
    
    //MARK: - Variables
    var title:String!
    var closeButtonVisible:Bool!
    var closeButtonTitle:String!
    
    public init(withTitle title:String, setCloseButtonVisible isVisible:Bool, setCloseButtonTitle closeButtonTitle:String) {
        self.title = title
        self.closeButtonVisible = isVisible
        self.closeButtonTitle = closeButtonTitle
    }
}
