//
//  SnackViewExtension.swift
//  SnackView
//
//  Created by Luca Casula on 27/12/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

extension SnackView {

    // MARK: - SnackView Setup

    /// Prepare the SnackView view controller with modalPresentationStyle and contentView hidden.
    internal func setupViewController() {
        // Add custom input accessory view to handle keyboard dismiss interactively
        self.customInputAccessoryView.frame.size.height = 44
        self.customInputAccessoryView.backgroundColor = UIColor.red

        // Set the presentation style as over current context
        self.modalPresentationStyle = .overCurrentContext

        // Set SnackView hidden
        self.contentView.isHidden = true
    }

    /// Prepare SnackView for will appear state, set background color to clear and translate view off screen.
    internal func setBackgroundForWillAppear() {
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.clear

            // Hide the SnackView out the screen bounds and set visible
            let contentViewHeight = self.contentView.frame.size.height + self.safeAreaView.frame.height
            self.contentView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)

            // Set SnackView visible
            self.contentView.isHidden = false
        }
    }

    /// Animate the SnackView presentation, set a background color with alpha 0.5 and then translate SnackView to original position.
    internal func showSnackViewWithAnimation() {
        DispatchQueue.main.async {
            // Background Color Animation
            UIView.animate(withDuration: self.animationSpeed, animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }) { (_) in
                // Show SnackView Animation
                UIView.animate(withDuration: self.animationSpeed, animations: {
                    self.contentView.transform = CGAffineTransform.identity
                })
            }
        }
    }

    /// This method add notification observer for keyboard events.
    internal func addNotificationsObserver() {
        let notificationCenter = NotificationCenter.default

        let keyboardWillShow = NSNotification.Name.UIKeyboardWillShow
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(notification:)),
                                       name: keyboardWillShow,
                                       object: nil)

        let keyboardWillHide = NSNotification.Name.UIKeyboardWillHide
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

    // MARK: - SnackView skeleton

    /// This method add all SVItems to scrollView content view.
    internal func addItemsInsideStackView() {
        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add BottomAlertItems to ScrollView
        for item in self.items {
            self.stackView.addArrangedSubview(item)
        }

        self.checkSnackViewContainsItemsOrAddDescriptionItem()

    }

    internal func checkSnackViewContainsItemsOrAddDescriptionItem() {
        if self.stackView.arrangedSubviews.isEmpty {
            let info = SVDescriptionItem(withDescription: "SnackView needs a non empty SVItem array to work properly.")

            self.stackView.addArrangedSubview(info)
        }
        self.view.layoutIfNeeded()
    }

    // MARK: - Layout SnackView

    internal func addContentViewBottomConstraint() {
        bottomContentViewConstant?.isActive = false
        bottomContentViewConstant = nil
        bottomContentViewConstant = self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        bottomContentViewConstant?.isActive = true
    }

    /// This method creates a view that contains all the SnackView items.
    internal func addScrollViewBottomConstraint() {

        scrollViewBottomConstraint?.isActive = false
        scrollViewBottomConstraint = nil

        var bottomAnchor = self.view.bottomAnchor
        if #available(iOS 11.0, *) {
            bottomAnchor = self.view.safeAreaLayoutGuide.bottomAnchor
        }

//        scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor)
        scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        scrollViewBottomConstraint?.isActive = true
    }

    // MARK: - Helper methods

    /// This method creates a UIViewController which is the root view controller of UIWindow.
    ///
    /// - Returns: UIViewController to use to present the SnackView
    internal func getPresenterViewController() -> UIViewController {
        let containerViewController = UIViewController()
        containerViewController.view.backgroundColor = UIColor.clear
        containerViewController.view.isUserInteractionEnabled = true

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = containerViewController
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindowLevelAlert+1
        window.makeKeyAndVisible()
        window.resignFirstResponder()

        return containerViewController
    }

    // MARK: - Private custom selector

    /// Animate the SnackView dismiss, translate SnackView off screen and set background color to clear.
    @objc internal func closeActionSelector() {

        DispatchQueue.main.async {
            // Hide the SnackView out the screen bounds and set visible
            let contentViewHeight = self.contentView.frame.size.height + self.safeAreaView.frame.height

            // Background Color Animation
            UIView.animate(withDuration: self.animationSpeed, animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)
            }) { (_) in
                UIView.animate(withDuration: self.animationSpeed, animations: {
                    self.view.backgroundColor = UIColor.clear
                }) { (_) in
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
}
