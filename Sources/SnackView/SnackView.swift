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
    internal var skeletonView: SVSkeletonView
    internal var bottomContentViewConstant = NSLayoutConstraint()
    internal var keyboardObserver: SnackViewKeyboardObserver?
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
        self.skeletonView = SVSkeletonView()

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

        /// Prepare the SnackView view controller with modalPresentationStyle and contentView hidden.
        self.modalPresentationStyle = .overCurrentContext
        self.addContentViewWithConstraints()
        self.skeletonView.injectCancelButton(from: self)

        let scrollView = self.skeletonView.scrollView.scrollView
        let snackView: SnackView = self
        self.keyboardObserver = SnackViewKeyboardObserver(with: self.bottomContentViewConstant,
                                                          from: snackView,
                                                          and: scrollView)

    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackgroundForWillAppear()
        self.getDataFromDataSource()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showSnackViewWithAnimation()
    }

}
