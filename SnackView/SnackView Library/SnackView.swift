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
    public internal(set) var items: [SVItem] = []
    @IBOutlet internal var contentView: UIView!
    @IBOutlet internal var effectView: UIView!
    @IBOutlet internal var stackView: UIStackView!
    @IBOutlet internal var scrollView: UIScrollView!
    internal var titleBar: SVTitleItem!
    internal var safeAreaView: UIView = UIView()
    internal var scrollViewBottomConstraint: NSLayoutConstraint?
    internal var bottomContentViewConstant: NSLayoutConstraint?
    internal var customInputAccessoryView: UIView = UIView()
    internal var keyboardHeight: CGFloat = 0
    internal var animationSpeed: TimeInterval = 0.25
    override public var inputAccessoryView: UIView? {
        let customInput = CustomInputAccessoryView()
        customInput.frame.size.height = 0.1
        return customInput
    }
    
    //private let dataSource: SnackViewProtocol
    internal let dataSource: SnackViewDataSource

    /// Initialization method for SnackView object
    ///
    /// - Parameter dataSource: Class conformed to SnackViewProtocol
    public init(with dataSource: SnackViewDataSource) {

        self.dataSource = dataSource
        super.init(nibName: "SnackViewSkeleton", bundle: Bundle(for: type(of: self)))

        let title = dataSource.titleFor(snackView: self)
        let cancelTitle = dataSource.cancelTitleFor(snackView: self)
        let isCancelButtonVisible = dataSource.cancelTitleFor(snackView: self) != nil
        let items = dataSource.itemsFor(snackView: self)

        self.items = items
        self.titleOptions = SVTitleOptions(withTitle: title, setCloseButtonVisible: isCancelButtonVisible, setCloseButtonTitle: cancelTitle)
        
    }

    @available(*, deprecated, message: "This method will be removed later. Please use 'init(with: SnackViewProtocol)' instead.")
    public init(withTitleOptions titleOptions: SVTitleOptions, andItems items: [SVItem]) {

        // Workaround to initialize dataSource
        let tmpDataSource = MockDataSource(withTitleOptions: titleOptions, andItems: items)
        dataSource = tmpDataSource
        super.init(nibName: nil, bundle: nil)

        //Set the title
        self.titleOptions = titleOptions
        self.items = items
    }

    @available(*, deprecated, message: "This method will be removed later. Please use 'init(with: SnackViewProtocol)' instead.")
    public init(withTitle title: String, andCloseButtonTitle closeTitle: String, andItems items: [SVItem]) {

        // Workaround to initialize dataSource
        let tmpDataSource = MockDataSource(withTitle: title, andCloseButtonTitle: closeTitle, andItems: items)
        dataSource = tmpDataSource

        super.init(nibName: nil, bundle: nil)

        //Set the title
        self.titleOptions = SVTitleOptions(withTitle: title, setCloseButtonVisible: true, setCloseButtonTitle: closeTitle)
        self.items = items
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if #available(iOS 10.0, *) {
            os_log("SnackView has been deinitialized.")
        } else {
            NSLog("SnackView<\(self.titleOptions.title)> has been deinitialized.")
        }
    }

    // MARK: - System Methods
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewController()

        // Add constraints to contentView and scrollView
        self.addContentViewBottomConstraint()
        self.addScrollViewBottomConstraint()

        // Register SnackView for keyboard notifications
        self.addNotificationsObserver()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Populate stackview with items
        let items = self.dataSource.itemsFor(snackView: self)
        self.items = items
        self.addItemsInsideStackView()
        
        self.setBackgroundForWillAppear()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showSnackViewWithAnimation()
    }
}
