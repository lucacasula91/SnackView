//
//  SVTitleItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

class SVTitleItem: SVItem {

    // MARK: - Private Properties
    private var titleLabel: UILabel
    private(set) var title: String!
    private(set) var cancelButtonTitle: String!

    // MARK: - Public Properties
    public var cancelButton: UIButton

    // MARK: - Initialization Method
    public override init() {
        self.titleLabel = UILabel()
        self.cancelButton = UIButton()

        super.init()
        self.addTitleLabel()
        self.addCancelButton()
    }

    // MARK: - Public Methods
    public func setTitle(_ title: String) {
        self.title = title
        self.titleLabel.text = title
    }

    public func setCancelTitle(_ cancelTitle: String?) {
        guard let cancelTitle = cancelTitle else {
            self.cancelButton.isHidden = true
            return
        }
        self.cancelButtonTitle = cancelTitle
        self.cancelButton.isHidden = false
        self.cancelButton.setTitle(cancelTitle, for: UIControl.State())
    }

    // MARK: - Private Methods
    private func addTitleLabel() {
        //Disable minimum height value
        self.setMinimumHeightActive(active: false)

        //Add title label
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = "SnackView"

        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        self.titleLabel.textColor = self.primaryTextColor
        self.addSubview(self.titleLabel)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-|", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleVContraints)
    }

    private func addCancelButton() {
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.setTitle("Cancel", for: UIControl.State())
        self.cancelButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        self.cancelButton.titleLabel?.adjustsFontForContentSizeCategory = true
        self.cancelButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.cancelButton.setTitleColor(blueButtonColor, for: UIControl.State.normal)
        self.cancelButton.setTitleColor(blueButtonColor.withAlphaComponent(0.5), for: UIControl.State.highlighted)
        self.addSubview(self.cancelButton)

        self.cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        let cancelButtonHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-(>=8)-[cancelButton]-|",
                                                                     options: [],
                                                                     metrics: nil,
                                                                     views: ["titleLabel": titleLabel, "cancelButton": cancelButton])
        self.addConstraints(cancelButtonHContraints)

    }
}
