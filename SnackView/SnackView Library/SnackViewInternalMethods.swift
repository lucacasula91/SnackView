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
            // Set SnackView visible
            self.contentView.isHidden = false

            self.view.backgroundColor = UIColor.clear

            // Hide the SnackView out the screen bounds and set visible
            let contentViewHeight = self.contentView.frame.size.height + self.safeAreaView.frame.height
            self.contentView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)
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
    internal func addKeyboardNotificationsObserver() {
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

    // MARK: - SnackView skeleton

    /// ContentView is a view that contains all the items of SnackView such as TitleBar, ScrollView with all the items inside and the safeArea view.
    internal func addContentViewWithConstraints() {
        self.contentView = UIView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        self.view.addSubview(contentView)

        /// Default top constraint anchor
        var topConstraint = self.view.topAnchor

        // Use safe area layout guide if possible
        if #available(iOS 11.0, *) {
            topConstraint = self.view.safeAreaLayoutGuide.topAnchor
        }

        self.contentView.topAnchor.constraint(greaterThanOrEqualTo: topConstraint, constant: 0).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

        self.bottomContentViewConstant = self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.view.addConstraint(bottomContentViewConstant)
    }

    /// This method adds a UIVisualEffectView under ContentView to reproduce blur effect.
    internal func addVisualEffectViewToContentView() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

        visualEffectView.frame = contentView.bounds
        visualEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        self.contentView.addSubview(visualEffectView)
    }

    /// Adds the three main views of SnackView, TitleBar, ScrollView and SafeArea View
    internal func addMainSkeletonView() {
        // Add TitleBar
        self.titleBar = SVTitleItem()
        self.titleBar.translatesAutoresizingMaskIntoConstraints = false
        self.titleBar.cancelButton.addTarget(self, action: #selector(closeActionSelector), for: UIControl.Event.touchUpInside)
        self.contentView.addSubview(self.titleBar)

        // Add ScrollView
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.keyboardDismissMode = .interactive
        self.scrollView.bounces = true
        self.scrollView.alwaysBounceVertical = false
        self.scrollView.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.scrollView)

        // Safe Area View
        self.safeAreaView = UIView()
        self.safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        self.safeAreaView.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.safeAreaView)
    }

    /// Adds the constraints for the three main views. Here is managed also the safeArea view constraints.
    internal func addMainConstraintsToContentView() {
        // Add vertical constraints
        let views = ["title": titleBar, "scrollView": scrollView] as [String: Any]
        let verticalContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[title(44)][scrollView]-|",
                                                                options: [],
                                                                metrics: nil,
                                                                views: views)
        self.contentView.addConstraints(verticalContraints)

        self.safeAreaView.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        self.safeAreaView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        // Add horizontal constraints
        let items = [self.titleBar, self.scrollView, self.safeAreaView] as [Any]
        for item in items {
            let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: [], metrics: nil, views: ["item": item])
            self.contentView.addConstraints(horizontalConstraint)
        }
    }

    /// Insert a subview (UIStackView) inside the UIScrollView and manage constraints.
    internal func addStackViewInsideScrollViewWithConstraints() {

        // Add StackView
        self.stackView = UIStackView(arrangedSubviews: [])
        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.stackView)

        // Add ScrollView Constraints
        let views = ["stackView": self.stackView, "scrollView": self.scrollView] as [String: Any]
        let stackViewHConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView(==scrollView)]|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: views)
        scrollView.addConstraints(stackViewHConstraint)

        let stackViewVConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: views)
        scrollView.addConstraints(stackViewVConstraint)

        // Set scrollView height constraint with low priority
        let scrollViewHeight = self.scrollView.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 1, constant: 0)
        scrollViewHeight.priority = .defaultLow
        scrollViewHeight.isActive = true
    }

    internal func getDataFromDataSource() {
        let title = self.dataSource?.titleFor(snackView: self) ?? ""
        self.titleBar.setTitle(title)

        let cancelTitle = self.dataSource?.cancelTitleFor(snackView: self)
        self.titleBar.setCancelTitle(cancelTitle)

        let items = self.dataSource?.itemsFor(snackView: self) ?? []
        self.items = items
    }
    
    /// This method add all SVItems to scrollView content view.
    internal func addItemsInsideStackView() {
        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add BottomAlertItems to ScrollView
        var items = [SVItem]()
        if let tmpItems = self.dataSource?.itemsFor(snackView: self) { items = tmpItems }
        for item in items {
            self.stackView.addArrangedSubview(item)
        }

        self.checkSnackViewContainsItemsOrAddDescriptionItem()
    }

    internal func checkSnackViewContainsItemsOrAddDescriptionItem() {
        if self.stackView.arrangedSubviews.isEmpty {

            if let image = self.getCodePreviewImage() {
                self.stackView.addArrangedSubview(image)
            }

            let info = SVDescriptionItem(withDescription: "SnackView needs a non empty SVItem array to work properly.")
            self.stackView.addArrangedSubview(info)
        }
        self.view.layoutIfNeeded()
    }

    private func getCodePreviewImage() -> SVImageViewItem? {
        let frameworkBundle = Bundle(for: SnackView.self)
        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("SnackView.bundle")
        let resourceBundle = Bundle(url: bundleURL!)

        if let image = UIImage(named: "Code_preview", in: resourceBundle, compatibleWith: nil) {
            let imageCode = SVImageViewItem(with: image, andContentMode: UIView.ContentMode.scaleToFill, andHeight: 149)
            return imageCode
        }

        return nil
    }

    // MARK: - Layout SnackView

    /// This method creates a view that contains all the SnackView items.
    internal func layoutSnackViewSkeleton() {
        self.view.subviews.forEach { $0.removeFromSuperview() }

        self.addContentViewWithConstraints()
        self.addVisualEffectViewToContentView()

        self.addMainSkeletonView()
        self.addMainConstraintsToContentView()
        self.addStackViewInsideScrollViewWithConstraints()
    }

    // MARK: - Helper methods

    /// This method creates a UIViewController which is the root view controller of UIWindow.
    ///
    /// - Returns: UIViewController to use to present the SnackView
    internal func getPresenterViewController() -> UIViewController {
        let containerViewController = UIViewController()
        containerViewController.modalPresentationStyle = .overFullScreen
        containerViewController.view.backgroundColor = UIColor.clear
        containerViewController.view.isUserInteractionEnabled = true

        window = nil
        window = UIWindow(frame: UIScreen.main.bounds)

        if #available(iOS 13.0, *) {
           let _scene = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }.first
            if
                let scene = _scene as? UIWindowScene {
                self.window = UIWindow(windowScene: scene)
            }
        }

        window?.rootViewController = containerViewController
        window?.backgroundColor = UIColor.clear
        window?.windowLevel = UIWindow.Level.alert+1
        window?.makeKeyAndVisible()
        window?.resignFirstResponder()

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
                    self.dismiss(animated: false) {
                        self.window?.rootViewController = nil
                        self.window?.resignFirstResponder()
                        self.window?.removeFromSuperview()
                        self.window = nil 
                    }
                }
            }
        }
    }
}
