//
//  SnackView.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit
import os.log

public class SnackView: UIViewController {

    // MARK: - Outlets and Variables
    internal var titleOptions: SVTitleOptions!
    internal var snackViewItems: [SVItem] = []
    internal var contentView: UIView = UIView()
    internal var titleBar: SVTitleItem!
    internal var scrollView: UIScrollView = UIScrollView()
    internal var safeAreaView: UIView = UIView()
    internal var stackView: UIStackView = UIStackView()

    internal var widthScrollContentView: CGFloat = 0
    internal var heightScrollViewConstant: NSLayoutConstraint = NSLayoutConstraint()

    internal var bottomContentViewConstant: NSLayoutConstraint = NSLayoutConstraint()
    internal var customInputAccessoryView: UIView = UIView()
    internal var keyboardHeight: CGFloat = 0

    override public var inputAccessoryView: UIView? {
        let customInput = CustomInputAccessoryView()
        customInput.frame.size.height = 0.1
        return customInput
    }

    // MARK: - Initialization methods
    public init(withTitleOptions titleOptions: SVTitleOptions, andItems items: [SVItem]) {
        super.init(nibName: nil, bundle: nil)

        //Set the title
        self.titleOptions = titleOptions
        self.snackViewItems = items
    }

    public init(withTitle title: String, andCloseButtonTitle closeTitle: String, andItems items: [SVItem]) {
        super.init(nibName: nil, bundle: nil)

        //Set the title
        self.titleOptions = SVTitleOptions(withTitle: title, setCloseButtonVisible: true, setCloseButtonTitle: closeTitle)
        self.snackViewItems = items
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if #available(iOS 10.0, *) {
            os_log("SnackView has been deinitialized.")
        } else {
            NSLog("SnackView has been deinitialized.")
        }
    }

    // MARK: - System Methods
    override public func viewDidLoad() {
        super.viewDidLoad()

        //
        self.setupViewController()

        //Create the SnackView skeleton view
        self.layoutSnackViewSkeleton()

        //Register SnackView for keyboard and rotation notifications
        self.addNotificationsObserver()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setBackgroundForWillAppear()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showSnackViewWithAnimation()
    }

    // MARK: - Public Methods
    public func show() {

        let containerViewController = UIViewController()
        containerViewController.view.backgroundColor = UIColor.clear
        containerViewController.view.isUserInteractionEnabled = true

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = containerViewController
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindowLevelAlert+1
        window.makeKeyAndVisible()
        window.resignFirstResponder()

        containerViewController.present(self, animated: false, completion: nil)
    }

    public func close() {
        self.closeActionSelector()
    }

    public func insertItem(item: SVItem, atIndex index: Int?) {
        if let aIndex = index {
            self.snackViewItems.insert(item, at: aIndex)
        } else {
            self.snackViewItems.append(item)
        }
        self.addItemsInsideStackView()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) { [weak self] in
            guard let width = self?.scrollView.frame.width, let height = self?.scrollView.frame.height else { return }

            self?.scrollView.scrollRectToVisible(CGRect(x: 0, y: height, width: width, height: height), animated: true)
        }
    }

    public func removeItem(item: SVItem) {
        for (index, tmpItem) in self.snackViewItems.enumerated() {
            if tmpItem == item {
                self.removeItemAtIndex(index: index)
                break
            }
        }
    }

    public func removeItemAtIndex(index: Int) {
        self.snackViewItems.remove(at: index)
        self.addItemsInsideStackView()
    }

    public func update(withItems items: [SVItem]) {
        self.snackViewItems = items
        self.addItemsInsideStackView()
    }

    // MARK: - Private Methods

    /** This method creates a view that contains all the SnackView items */
    private func layoutSnackViewSkeleton() {
        self.view.subviews.forEach { $0.removeFromSuperview() }

        self.addContentViewWithConstraints()
        self.addVisualEffectViewToContentView()

        self.addTitleBarToContentView()
        self.addScrollViewToContentView()
        self.addSafeAreaViewToContentView()
        self.addMainConstraintsToContentView()
        self.addStackViewInsideScrollViewWithConstraints()

        self.addItemsInsideStackView()
    }

    // MARK: - Private Custom Actions
    @objc internal func closeActionSelector() {

        DispatchQueue.main.async {
            //Hide the SnackView out the screen bounds and set visible
            let contentViewHeight = self.contentView.frame.size.height + self.safeAreaView.frame.height

            //Background Color Animation
            UIView.animate(withDuration: 0.3, animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.backgroundColor = UIColor.clear
                }) { (_) in
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
}
