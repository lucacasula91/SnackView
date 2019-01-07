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
    internal var contentView: UIView = UIView()
    internal var titleBar: SVTitleItem!
    internal var scrollView: UIScrollView = UIScrollView()
    internal var stackView: UIStackView = UIStackView()
    internal var safeAreaView: UIView = UIView()
    internal var bottomContentViewConstant: NSLayoutConstraint = NSLayoutConstraint()
    internal var customInputAccessoryView: UIView = UIView()
    internal var keyboardHeight: CGFloat = 0
    internal var animationSpeed: TimeInterval = 0.25
    override public var inputAccessoryView: UIView? {
        let customInput = CustomInputAccessoryView()
        customInput.frame.size.height = 0.1
        return customInput
    }
    
    private let dataSource: SnackViewProtocol
    
    public init(with dataSource: SnackViewProtocol) {
        self.dataSource = dataSource
        
        self.items = dataSource.items
        self.titleOptions = SVTitleOptions(withTitle: self.dataSource.title, setCloseButtonVisible: true, setCloseButtonTitle: self.dataSource.closeTitle)
        
        super.init(nibName: nil, bundle: nil)
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

        // Create the SnackView skeleton view
        self.layoutSnackViewSkeleton()

        // Register SnackView for keyboard notifications
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
}
