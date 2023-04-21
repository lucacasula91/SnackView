//
//  SVLoaderItem.swift
//  SnackView
//
//  Created by Luca Casula on 22/03/18.
//  Copyright © 2018 Luca Casula. All rights reserved.
//

import UIKit

/** SVLoaderItem is an item that show an animated activity indicator view. The item can be more specific by showing a text message. */
public class SVLoaderItem: SVItem {

    /** Enumerator describing the size of activity indicator item */
    public enum ActivityIndicatorSize {
        /** The default size of UIActivityIndicatorView */
        case little

        /** The large style of UIActivityIndicatorView */
        case large
    }

    // MARK: - Properties
    private var messageLabel: UILabel
    private var activityIndicator: UIActivityIndicatorView
    private(set) var size: ActivityIndicatorSize
    private(set) var text: String?

    // MARK: - Initialization Method
    /**
     Initialization method for SVLoaderItem view. You can customize this item with size of the activity indicator view and a custom text message.
     - parameter size: The size of activity indicator view
     - parameter text: A text that can appear on top of activity indicator view
     */
    public init(withSize size: ActivityIndicatorSize, andText text: String?) {
        self.messageLabel = UILabel()
        self.activityIndicator = UIActivityIndicatorView(style: size == .little ? .white : .whiteLarge)

        self.size = size
        self.text = text
        super.init()

        self.addActivityIndicator()
        self.addMessageLabelFor(text: text)
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Method

    private func addActivityIndicator() {
        self.setMinimumHeightActive(active: false)
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: size == .little ? 50 : 70).isActive = true

        self.activityIndicator.color = UIColor.gray
        self.activityIndicator.startAnimating()
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.activityIndicator)
    }

    private func addMessageLabelFor(text: String?) {
        if let unwrappedText = text {
            self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
            self.messageLabel.textColor = self.secondaryTextColor
            self.messageLabel.numberOfLines = 0
            self.messageLabel.font = UIFont.preferredFont(forTextStyle: .body)
            self.messageLabel.adjustsFontForContentSizeCategory = true
            self.messageLabel.textAlignment = .center
            self.messageLabel.text = unwrappedText
            self.addSubview(self.messageLabel)

            //Add constraints to message label
            let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[messageLabel]-|",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["messageLabel": messageLabel])

            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[messageLabel]-[activityIndicator]-|",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["messageLabel": messageLabel, "activityIndicator": activityIndicator])
            self.addConstraints(hConstraints + vConstraints)

            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        } else {
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
}
