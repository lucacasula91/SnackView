//
//  SnackViewExtension.swift
//  SnackView
//
//  Created by Luca Casula on 27/12/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

extension SnackView {

    // MARK: - SnackView Setup

    internal func setupViewController() {
        //Add custom input accessory view to handle keyboard dismiss interactively
        self.customInputAccessoryView.frame.size.height = 44
        self.customInputAccessoryView.backgroundColor = UIColor.red

        //Set the presentation style as over current context
        self.modalPresentationStyle = .overCurrentContext

        //Set SnackView hidden
        self.contentView.isHidden = true
    }

    internal func setBackgroundForWillAppear() {
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.clear

            //Hide the SnackView out the screen bounds and set visible
            let contentViewHeight = self.contentView.frame.size.height + self.safeAreaView.frame.height
            self.contentView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)

            //Set SnackView visible
            self.contentView.isHidden = false
        }
    }

    internal func showSnackViewWithAnimation() {
        DispatchQueue.main.async {
            //Background Color Animation
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }) { (_) in
                //Show SnackView Animation
                UIView.animate(withDuration: 0.2, animations: {
                    self.contentView.transform = CGAffineTransform.identity
                })
            }
        }
    }

    /** This method add notification observer for keyboard events */
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

    internal func addContentViewWithConstraints() {
        self.contentView = UIView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        self.view.addSubview(contentView)

        //Use safe area layout guide if possible
        if #available(iOS 11.0, *) {
            self.contentView.topAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        } else {
            self.contentView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 0).isActive = true
        }
        self.contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

        self.bottomContentViewConstant = self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.view.addConstraint(bottomContentViewConstant)
    }

    internal func addVisualEffectViewToContentView() {
        //Add Visual Effect
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = contentView.bounds
        visualEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.contentView.addSubview(visualEffectView)
    }

    internal func addTitleBarToContentView() {
        //Title Bar View
        self.titleBar = SVTitleItem(withTitle: self.titleOptions.title, andCancelButton: self.titleOptions.closeButtonTitle)
        self.titleBar.translatesAutoresizingMaskIntoConstraints = false
        self.titleBar.cancelButton.addTarget(self, action: #selector(closeActionSelector), for: UIControlEvents.touchUpInside)

        //Check if close button must be visible or hidden
        self.titleBar.cancelButton.isHidden = self.titleOptions.closeButtonVisible ? false : true
        self.contentView.addSubview(self.titleBar)
    }

    internal func addScrollViewToContentView() {
        //Scroll Content View
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.keyboardDismissMode = .interactive
        self.scrollView.bounces = true
        self.scrollView.alwaysBounceVertical = false
        self.scrollView.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.scrollView)
    }

    internal func addSafeAreaViewToContentView() {
        //Safe Area View
        self.safeAreaView = UIView()
        self.safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        self.safeAreaView.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.safeAreaView)
    }

    internal func addMainConstraintsToContentView() {
        //Add vertical constraints
        let verticalContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[title(44)][scrollView]-|", options: [], metrics: nil, views: ["title": titleBar, "scrollView": scrollView])
        self.contentView.addConstraints(verticalContraints)

        self.safeAreaView.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        self.safeAreaView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        //Add horizontal constraints
        let items = [self.titleBar, self.scrollView, self.safeAreaView] as [Any]
        for item in items {
            let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: [], metrics: nil, views: ["item": item])
            self.contentView.addConstraints(horizontalConstraint)
        }
    }

    internal func addStackViewInsideScrollViewWithConstraints() {
        //Add StackView
        self.stackView = UIStackView(arrangedSubviews: [])
        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.stackView)

        //Add ScrollView Constraints
        let stackViewHConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView(==scrollView)]|", options: [], metrics: nil, views: ["stackView": self.stackView, "scrollView": self.scrollView])
        scrollView.addConstraints(stackViewHConstraint)

        let stackViewVConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: [], metrics: nil, views: ["stackView": self.stackView, "scrollView": self.scrollView])
        scrollView.addConstraints(stackViewVConstraint)

        let scrollViewHeight = self.scrollView.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 1, constant: 0)
        scrollViewHeight.priority = .defaultLow
        scrollViewHeight.isActive = true
    }

    /** This method add all SVItems to scrollView content view */
    internal func addItemsInsideStackView() {
        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        //Make sure self.items is not empty
        if self.snackViewItems.isEmpty {
            let info = SVDescriptionItem(withDescription: "SnackView needs a non empty SVItem array to work properly.")
            self.snackViewItems = [info]
        }

        //Add BottomAlertItems to ScrollView
        for item in self.snackViewItems {
            item.translatesAutoresizingMaskIntoConstraints = false
            self.stackView.addArrangedSubview(item)
        }

        self.contentView.layoutIfNeeded()
    }

}
