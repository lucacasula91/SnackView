//
//  SVApplicationItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVApplicationItem is an SVItem with which to show an image, a title and a description text.
 
 It can be useful to show the icon with title and description of an application, of an in-app purchase or to show a list of steps.
 */
public class SVApplicationItem: SVItem {

    // MARK: - Private Properties
    private var titleLabel: UILabel
    private var descriptionLabel: UILabel
    private var imageContainer: UIView

    // MARK: - Public Properties
    private(set) var icon: UIImage
    private(set) var title: String
    private(set) var descriptionText: String

    // MARK: - Initialization Method
    /**
     Initialization method for SVApplicationItem view. You can customize this item with image, title and description text.
     - parameter icon: The image you want to show at left of title and description text
     - parameter title: The title of application or in-app purchase
     - parameter description: The description text of application or in-app purchase
     */
    public init(withIcon icon: UIImage, withTitle title: String, andDescription description: String) {
        self.titleLabel = UILabel()
        self.descriptionLabel = UILabel()
        self.imageContainer = UIView()

        self.icon = icon
        self.title = title
        self.descriptionText = description

        super.init()
        self.addImageView()
        self.addTitleLabel()
        self.addDescriptionLabel()
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func addImageView() {
        self.imageContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageContainer)

        //Add constraints for left container
        let imageContainerHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageContainer(==\(self.leftContentWidth))]",
                                                                       options: [],
                                                                       metrics: nil,
                                                                       views: ["imageContainer": imageContainer])
        self.addConstraints(imageContainerHContraints)

        let imageContainerVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageContainer]-|",
                                                                       options: [],
                                                                       metrics: nil,
                                                                       views: ["imageContainer": imageContainer])
        self.addConstraints(imageContainerVContraints)

        //Add image view into container
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = icon
        imageContainer.addSubview(imageView)

        //Add constraints to imageView
        let imageHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageView(40)]|",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["imageView": imageView])
        imageContainer.addConstraints(imageHContraints)

        let imageVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView(40)]-(>=0)-|",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["imageView": imageView])
        imageContainer.addConstraints(imageVContraints)

        //Customize the UI of imageView
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
    }

    private func addTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = self.primaryTextColor

        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        titleLabel.adjustsFontForContentSizeCategory = true

        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)

        //Add constraints to titleLabel
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageContainer]-[titleLabel]-|",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["titleLabel": titleLabel, "imageContainer": imageContainer])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["titleLabel": titleLabel])
        self.addConstraints(titleVContraints)
    }

    private func addDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = self.descriptionText
        descriptionLabel.textColor = secondaryTextColor

        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true

        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)

        //Add constraints to descriptionLabel
        let descriptionHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageContainer]-[descriptionLabel]-|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["imageContainer": imageContainer, "descriptionLabel": descriptionLabel])
        self.addConstraints(descriptionHContraints)

        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[titleLabel][descriptionLabel]-|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["titleLabel": titleLabel, "descriptionLabel": descriptionLabel])
        self.addConstraints(descriptionVContraints)
    }
    
}
