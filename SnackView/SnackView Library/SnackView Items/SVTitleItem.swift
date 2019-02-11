//
//  SVTitleItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

class SVTitleItem: SVItem {

    // MARK: - Variables
    var titleLabel: UILabel
    var cancelButton: UIButton
    var title: String!
    var cancelButtonTitle: String!

    public init(withTitle title: String, andCancelButton cancelButtonTitle: String) {
        self.title = title
        self.cancelButtonTitle = cancelButtonTitle
        self.titleLabel = UILabel()
        self.cancelButton = UIButton()

        super.init()

        //Disable minimum height value
        self.setMinimumHeightActive(active: false)

        self.title = title
        self.cancelButtonTitle = cancelButtonTitle

        //Add title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = self.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(titleLabel)

        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]|", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleVContraints)

        //Add cancel Button
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle(self.cancelButtonTitle, for: UIControl.State())
        cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: UIControl.State.normal)
        cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5), for: UIControl.State.highlighted)
        self.addSubview(cancelButton)

        let cancelButtonHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[cancelButton]-|", options: [], metrics: nil, views: ["cancelButton": cancelButton])
        self.addConstraints(cancelButtonHContraints)

        let cancelButtonVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[cancelButton]|", options: [], metrics: nil, views: ["cancelButton": cancelButton])
        self.addConstraints(cancelButtonVContraints)

    }

    public override init() {
        self.titleLabel = UILabel()
        self.cancelButton = UIButton()

        super.init()

        //Disable minimum height value
        self.setMinimumHeightActive(active: false)

        //Add title label
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = "SnackView"
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(self.titleLabel)

        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]|", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleVContraints)

        //Add cancel Button
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.setTitle("Cancel", for: UIControl.State())
        self.cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: UIControl.State.normal)
        self.cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).withAlphaComponent(0.5), for: UIControl.State.highlighted)
        self.addSubview(self.cancelButton)

        let cancelButtonHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[cancelButton]-|", options: [], metrics: nil, views: ["cancelButton": cancelButton])
        self.addConstraints(cancelButtonHContraints)

        let cancelButtonVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[cancelButton]|", options: [], metrics: nil, views: ["cancelButton": cancelButton])
        self.addConstraints(cancelButtonVContraints)

    }

    public func setTitle(_ title: String) {
        self.titleLabel.text = title
    }

    public func setCancelTitle(_ cancelTitle: String?) {
        guard let cancelTitle = cancelTitle else {
            self.cancelButton.isHidden = true
            return
        }

        self.cancelButton.isHidden = false
        self.cancelButton.setTitle(cancelTitle, for: UIControl.State())
    }
}
