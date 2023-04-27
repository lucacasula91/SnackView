//
//  SVPriceRowItem.swift
//
//
//  Created by Luca Casula on 27/04/23.
//

import UIKit

/** SVPriceRowItem is an SVItem with which to show a title, a multi-line description text and a price label. */
public class SVPriceRowItem: SVItem {
    
    public enum Size: CGFloat {
        case large = 22
        case medium = 17
        case small = 12
    }

    // MARK: - Properties
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var priceLabel = UILabel()
    private(set) var title: String?
    private(set) var descriptionText: String?
    private(set) var priceText: String
    private(set) var size: Size

    // MARK: - Initialization Method
    /**
     Initialization method for SVPriceRowItem view. You can customize this item with a title and a description text.
     
     **Note that label text on the left will be rendered as uppercased text**.
     To force the placeholder text to be rendered in multi-line please enter **\n** where you want the text to wrap.


     **Here an example of wrapped text**:
     ```
     SVPriceRowItem(withTitle: "Price\nOrder", andDescription: "Nike Shoes", andPrice: "€ 79.50")
     ```
     
     - parameter title: The title to show
     - parameter description: The description text to show

     */
    public init(withTitle title: String?, andDescription description: String?, andPrice priceText: String, size: Size = .large) {
        self.title = title
        self.descriptionText = description
        self.priceText = priceText
        self.size = size
        super.init()

        [titleLabel, descriptionLabel, priceLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        self.addTitleLabel()
        self.addDescriptionAndPriceLabels()
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func addTitleLabel() {
        self.titleLabel.text = self.title?.uppercased()
        self.titleLabel.textAlignment = .right
        self.titleLabel.textColor = secondaryTextColor
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)
        
        let views = ["titleLabel": titleLabel]
        self.addVisualConstraint("H:|-[titleLabel(==\(self.leftContentWidth))]", for: views)
        self.addVisualConstraint("V:|-[titleLabel(>=28)]-|", for: views)
    }

    private func addDescriptionAndPriceLabels() {
        self.descriptionLabel.text = self.descriptionText
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.textColor = self.primaryTextColor
        self.descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.descriptionLabel.adjustsFontForContentSizeCategory = true
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.addSubview(descriptionLabel)
        
        self.priceLabel.text = self.priceText
        self.priceLabel.textAlignment = .right
        self.priceLabel.textColor = self.primaryTextColor
        self.priceLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(size.rawValue)
        self.priceLabel.adjustsFontForContentSizeCategory = true
        self.priceLabel.numberOfLines = 1
        self.priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        self.addSubview(priceLabel)

        let views = ["titleLabel": titleLabel, "descriptionLabel": descriptionLabel, "priceLabel": priceLabel]
        self.addVisualConstraint("V:|-[descriptionLabel]-|", for: views)
        self.addVisualConstraint("H:|-[titleLabel]-[descriptionLabel]-[priceLabel]-|", for: views)
        self.addVisualConstraint("V:|-[priceLabel]-|", for: views)
    }

}

