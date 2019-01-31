//
//  SnackViewNotifications.swift
//  SnackView
//
//  Created by Luca Casula on 27/12/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

extension SnackView {

    // MARK: - Notifications handler

    @objc func keyboardWillShow(notification: Notification) {
        scrollView.alwaysBounceVertical = true

        let keyboardSize = self.getKeyboardSizeFrom(notification: notification)
        let animationSpeed = self.getAnimationDurationFrom(notification: notification)

        self.keyboardHeight = keyboardSize.height
        bottomContentViewConstant.constant = -self.keyboardHeight

        UIView.animate(withDuration: animationSpeed.doubleValue) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollView.alwaysBounceVertical = false

        let keyboardSize = self.getKeyboardSizeFrom(notification: notification)
        let animationSpeed = self.getAnimationDurationFrom(notification: notification)

        self.keyboardHeight = keyboardSize.height
        self.bottomContentViewConstant.constant = 0

        UIView.animate(withDuration: animationSpeed.doubleValue) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardFrameDidChange(notification: Notification) {
        if let constant = notification.userInfo?["constant"] as? CGFloat {
            bottomContentViewConstant.constant = -constant
        }
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
        return NSNumber(value: self.animationSpeed)
    }
}
