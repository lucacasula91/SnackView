//
//  SnackViewKeyboardObserver.swift
//  SnackView
//
//  Created by Luca Casula on 10/06/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import UIKit

class SnackViewConstant {
    static public let animationSpeed: TimeInterval = 0.25
}

class SnackViewKeyboardObserver {

    // MARK: - Private Properties
    private var bottomContentViewConstant: NSLayoutConstraint
    private var snackView: SnackView
    private var scrollView: UIScrollView

    // MARK: - Init Method
    init(with constraint: NSLayoutConstraint, from snackView: SnackView, and scrollView: UIScrollView) {
        self.bottomContentViewConstant = constraint
        self.snackView = snackView
        self.scrollView = scrollView

        self.addNotificationsObserver()
    }

    @objc func keyboardWillShow(notification: Notification) {
        scrollView.alwaysBounceVertical = true

        let keyboardSize = self.getKeyboardSizeFrom(notification: notification)
        let animationSpeed = self.getAnimationDurationFrom(notification: notification)

        bottomContentViewConstant.constant = -keyboardSize.height

        UIView.animate(withDuration: animationSpeed.doubleValue) {
            self.snackView.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollView.alwaysBounceVertical = false
        let animationSpeed = self.getAnimationDurationFrom(notification: notification)

        self.bottomContentViewConstant.constant = 0

        UIView.animate(withDuration: animationSpeed.doubleValue) {
            self.snackView.view.layoutIfNeeded()
        }
    }

    @objc func keyboardFrameDidChange(notification: Notification) {
        if let constant = notification.userInfo?["constant"] as? CGFloat {
            bottomContentViewConstant.constant = -constant
        }
    }

    // MARK: - Private Methods
    private func addNotificationsObserver() {
        let notificationCenter = NotificationCenter.default
        let keyboardWillShow = UIResponder.keyboardWillShowNotification
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(notification:)),
                                       name: keyboardWillShow,
                                       object: nil)

        let keyboardWillHide = UIResponder.keyboardWillHideNotification
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide(notification:)),
                                       name: keyboardWillHide,
                                       object: nil)

        let keyboardFrameDidChange = NSNotification.Name(rawValue: "KeyboardFrameDidChange")
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardFrameDidChange(notification:)),
                                       name: keyboardFrameDidChange,
                                       object: nil)
    }

    private func getKeyboardSizeFrom(notification: Notification) -> CGRect {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            return keyboardSize
        }
        return CGRect.zero
    }

    private func getAnimationDurationFrom(notification: Notification) -> NSNumber {
        if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            return animationDuration
        }
        return NSNumber(value: SnackViewConstant.animationSpeed)
    }

}
