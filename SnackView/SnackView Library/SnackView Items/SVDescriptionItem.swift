//
//  SVDescriptionItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVDescriptionItem is an SVItem with which to show a multi-line description text. */
public class SVDescriptionItem: SVItem {

    // MARK: - Properties
    private var descriptionLabel: UILabel
    private(set) var descriptionText: String

    // MARK: - Initialization Method
    /**
     Initialization method for SVDescriptionItem view. You can customize this item with a description text.
     - parameter description: The text you want to show
     */
    public init(withDescription description: String) {
        self.descriptionLabel = UILabel()
        self.descriptionText = description
        super.init()

        self.addDescriptionLabel()
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func addDescriptionLabel() {
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.text = self.descriptionText
        self.descriptionLabel.textColor = secondaryTextColor
        self.descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.descriptionLabel.adjustsFontForContentSizeCategory = true
        self.descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)

        //Add constraints to descriptionLabel
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel": descriptionLabel])
        self.addConstraints(descriptionHContraints)

        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel": descriptionLabel])
        self.addConstraints(descriptionVContraints)
    }

}
