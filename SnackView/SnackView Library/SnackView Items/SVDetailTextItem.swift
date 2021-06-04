//
//  SVDetailText.swift
//  SnackView
//
//  Created by Luca Casula on 10/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVDetailTextItem is an SVItem with which to show a title and a multi-line description text. */
public class SVDetailTextItem: SVItem {

    // MARK: - Properties
    private var titleLabel: UILabel
    private var descriptionLabel: UILabel
    private(set) var title: String
    private(set) var descriptionText: String

    // MARK: - Initialization Method
    /**
     Initialization method for SVDetailTextItem view. You can customize this item with a title and a description text.
     - parameter title: The title to show
     - parameter description: The description text to show

        **Note that label text on the left will be rendered as uppercased text**.

        To force the placeholder text to be rendered in multi-line please enter **\n** where you want the text to wrap.


        **Here an example of wrapped text**:
        ```
        SVDetailTextItem(withTitle: "Terms and\nConditions",
        andDescription: "Ipsum lorem sit...")
        ```
     */
    public init(withTitle title: String, andDescription description: String) {
        self.titleLabel = UILabel()
        self.descriptionLabel = UILabel()
        self.title = title
        self.descriptionText = description
        super.init()

        self.addTitleLabel()
        self.addDescriptionLabel()
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func addTitleLabel() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = self.title.uppercased()
        self.titleLabel.textAlignment = .right
        self.titleLabel.textColor = secondaryTextColor
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)

        //Add constraints to titleLabel
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==\(self.leftContentWidth))]", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleVContraints)
    }

    private func addDescriptionLabel() {
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.text = self.descriptionText
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.textColor = self.primaryTextColor
        self.descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.descriptionLabel.adjustsFontForContentSizeCategory = true
        self.descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)

        //Add constraints to descriptionLabel
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-[descriptionLabel]-|", options: [], metrics: nil, views: ["titleLabel": titleLabel, "descriptionLabel": descriptionLabel])
        self.addConstraints(descriptionHContraints)

        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: [], metrics: nil, views: ["descriptionLabel": descriptionLabel])
        self.addConstraints(descriptionVContraints)
    }
}
