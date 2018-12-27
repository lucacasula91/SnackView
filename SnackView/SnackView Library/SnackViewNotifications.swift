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

        guard
            let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationSpeed = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
            else { return }

        self.keyboardHeight = keyboardSize.height
        bottomContentViewConstant.constant = -self.keyboardHeight

        UIView.animate(withDuration: animationSpeed.doubleValue) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollView.alwaysBounceVertical = false

        guard
            let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationSpeed = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
            else { return }

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
}
