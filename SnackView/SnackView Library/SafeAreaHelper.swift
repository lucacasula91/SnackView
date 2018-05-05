//
//  SafeAreaHelper.swift
//  SnackView
//
//  Created by Luca Casula on 26/04/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

import UIKit

class SafeAreaHelper {
    
    /** Boolean value indicating if device is in portrait orientation or not */
    var isPortrait: Bool {
        return UIScreen.main.bounds.width < UIScreen.main.bounds.height
    }
    
    /** Boolean value indicating if device is an iPhone X or not */
    var isiPhoneX: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            //Check for screen height
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return true
            default:
                return false
            }
        }
        return false
    }
    
    /** Return the top safe area height according device and orientation */
    func getTopSafeAreaHeight() -> CGFloat {
        var statusBarHeight: CGFloat

        if self.isPortrait {
            statusBarHeight = isiPhoneX ? 44 : 20
        }
        else {
            statusBarHeight = 0
        }
        
        return statusBarHeight
    }
    
    /** Return the botton safe area height according device and orientation */
    func getBottomSafeAreaHeight() -> CGFloat {
        var bottomSafeAreaHeight: CGFloat
        
        if self.isPortrait {
            bottomSafeAreaHeight = isiPhoneX ? 44 : 8
        }
        else {
            bottomSafeAreaHeight = isiPhoneX ? 29 : 8
        }
        
        return bottomSafeAreaHeight
    }
    
    
}
