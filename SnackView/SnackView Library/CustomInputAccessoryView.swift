//
//  CustomInputAccessoryView.swift
//  SnackView
//
//  Created by Luca Casula on 15/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

class CustomInputAccessoryView: UIView {

    override func willMove(toSuperview newSuperview: UIView?) {
        if let oldSuperView = self.superview {
            oldSuperView.removeObserver(self, forKeyPath: "center")
        }
        newSuperview?.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.new, context: nil)
        super.willMove(toSuperview: newSuperview)
    }

    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let _ = change?[NSKeyValueChangeKey.newKey]  {
            if let originY = self.superview?.frame.origin.y {
                let screenHeight = UIScreen.main.bounds.height
                let constant = screenHeight - originY
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "KeyboardFrameDidChange"), object: nil, userInfo: ["constant":constant])
            }
        }
    }
}
