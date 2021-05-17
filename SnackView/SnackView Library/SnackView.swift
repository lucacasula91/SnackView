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
    internal weak var dataSource: SnackViewDataSource?

    public internal(set) var items: [SVItem]? = []
    internal var window: UIWindow?
    internal var contentView = UIView()
    internal var titleBar = SVTitleItem()
    internal var scrollView = UIScrollView()
    internal var stackView = UIStackView()
    internal var safeAreaView = UIView()
    internal var bottomContentViewConstant = NSLayoutConstraint()
    internal var customInputAccessoryView = UIView()
    internal var keyboardHeight: CGFloat = 0
    internal var animationSpeed: TimeInterval = 0.25
    override public var inputAccessoryView: UIView? {
        let customInput = CustomInputAccessoryView()
        customInput.frame.size.height = 0.1
        return customInput
    }

    // MARK: - Initialization Methods
    /// Initialization method for SnackView object
    ///
    /// - Parameter dataSource: Class conformed to SnackViewProtocol
    public init(with dataSource: SnackViewDataSource) {
        self.dataSource = dataSource

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    deinit {
        NSLog("SnackView has been deinitialized.")
    }

    // MARK: - UIViewController Methods
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewController()
        self.layoutSnackViewSkeleton()
        self.addKeyboardNotificationsObserver()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackgroundForWillAppear()
        self.getDataFromDataSource()
        self.addItemsInsideStackView()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showSnackViewWithAnimation()
    }
}
