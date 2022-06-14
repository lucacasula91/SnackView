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

    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if change?[NSKeyValueChangeKey.newKey] != nil {
            if let originY = self.superview?.frame.origin.y {
                let screenHeight = UIScreen.main.bounds.height
                let constant = screenHeight - originY
                let notificationName = NSNotification.Name(rawValue: "KeyboardFrameDidChange")
                NotificationCenter.default.post(name: notificationName,
                                                object: nil,
                                                userInfo: ["constant": constant])
            }
        }
    }
}
