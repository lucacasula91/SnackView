//
//  SVSkeletonView.swift
//  SnackView
//
//  Created by Luca Casula on 11/06/21.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import UIKit

class SVSkeletonView: UIView {

    // MARK: - Public Properties
    public var titleBar = SVTitleItem()

    // MARK: - Private Properties
    internal var scrollView = SVScrollView()
    internal var safeAreaView = UIView()

    // MARK: - Initialization Method
    init() {
        super.init(frame: CGRect.zero)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public Methods
    public func setTitle(_ title: String, andCancelTitle cancelTitle: String?) {
        self.titleBar.setTitle(title)
        self.titleBar.setCancelTitle(cancelTitle)
    }

    public func reload(with items: [SVItem]) {
        self.scrollView.reload(with: items)
    }

    public func getSafeAreaHeight() -> CGFloat {
        return safeAreaView.frame.height
    }

    public func injectCancelButton(from snackView: SnackView) {
        self.titleBar.cancelButton.addTarget(snackView, action: #selector(snackView.closeActionSelector), for: UIControl.Event.touchUpInside)
    }
    // MARK: - Private Methods

    internal func setupUI() {
        self.isHidden = true
        self.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        if #available(iOS 13.0, *) {
            self.backgroundColor = UIColor.tertiarySystemBackground
        }
        self.addVisualEffectViewToContentView()
        self.addMainSkeletonView()
        self.addMainConstraintsToContentView()
    }

    /// This method adds a UIVisualEffectView under ContentView to reproduce blur effect.
    internal func addVisualEffectViewToContentView() {
        var effect: UIBlurEffect = UIBlurEffect(style: .light)

        if #available(iOS 13.0, *) {
            effect = UIBlurEffect(style: .systemMaterial)
        }

        let visualEffectView = UIVisualEffectView(effect: effect)
        visualEffectView.frame = self.bounds
        visualEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        self.addSubview(visualEffectView)
    }

    /// Adds the three main views of SnackView, TitleBar, ScrollView and SafeArea View
    internal func addMainSkeletonView() {
        // Add TitleBar
        self.titleBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleBar)

        // Add ScrollView
        self.scrollView = SVScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.scrollView)

        // Safe Area View
        self.safeAreaView = UIView()
        self.safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        self.safeAreaView.backgroundColor = UIColor.clear
        self.addSubview(self.safeAreaView)
    }

    /// Adds the constraints for the three main views. Here is managed also the safeArea view constraints.
    internal func addMainConstraintsToContentView() {
        // Add vertical constraints
        let views: [String: Any] = ["title": titleBar, "scrollView": scrollView]
        self.addVisualConstraint("V:|[title(>=44)][scrollView]-|", for: views)

        self.safeAreaView.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        self.safeAreaView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        // Add horizontal constraints
        let items = [self.titleBar, self.scrollView, self.safeAreaView] as [Any]
        items.forEach { self.addVisualConstraint("H:|[item]|", for: ["item": $0])}
    }
}
