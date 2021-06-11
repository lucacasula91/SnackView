//
//  SVScrollView.swift
//  SnackView
//
//  Created by Luca Casula on 11/06/21.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import UIKit

class SVScrollView: UIView {

    // MARK: - Public Properties
    public var scrollView = UIScrollView()

    // MARK: - Internal Properties
    internal var stackView = UIStackView(arrangedSubviews: [])

    // MARK: - Initialization Methods
    init(with items: [SVItem]) {
        super.init(frame: CGRect.zero)
        self.setupUI(with: items)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI(with: [])
    }

    // MARK: - Public Methods
    public func reload(with items: [SVItem]) {
        self.addItemsInsideStackView(items)
    }

    // MARK: - Private Method
    internal func setupUI(with items: [SVItem]) {
        self.addScrollView()
        self.addStackViewInsideScrollViewWithConstraints()
        self.addItemsInsideStackView(items)
    }

    internal func addScrollView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.keyboardDismissMode = .interactive
        self.scrollView.bounces = true
        self.scrollView.alwaysBounceVertical = false
        self.scrollView.backgroundColor = UIColor.clear
        self.addSubview(self.scrollView)

        let views: [String: Any] = ["scrollView": self.scrollView]
        self.addVisualConstraint("H:|[scrollView]|", for: views)
        self.addVisualConstraint("V:|[scrollView]|", for: views)
    }

    internal func addStackViewInsideScrollViewWithConstraints() {
        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.stackView)

        let views: [String: Any] = ["stackView": self.stackView, "scrollView": self.scrollView]
        self.addVisualConstraint("H:|[stackView(==scrollView)]|", for: views)
        self.addVisualConstraint("V:|[stackView]|", for: views)

        // Set scrollView height constraint with low priority
        let scrollViewHeight = self.scrollView.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 1, constant: 0)
        scrollViewHeight.priority = .defaultLow
        scrollViewHeight.isActive = true
    }

    /// This method add all SVItems to scrollView content view.
    internal func addItemsInsideStackView(_ items: [SVItem]) {
        self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items.forEach { self.stackView.addArrangedSubview($0)}
        self.stackView.layoutIfNeeded()
    }

}
