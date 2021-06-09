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
    private var titleLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var imageContainer: UIView = UIView()

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
        self.icon = icon
        self.title = title
        self.descriptionText = description

        super.init()
        self.setupUI()
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func setupUI() {
        [imageContainer, titleLabel, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }

        self.addImageView()
        self.addTitleLabel()
        self.addDescriptionLabel()
    }

    private func addImageView() {
        self.addVisualConstraint("H:|-[imageContainer(==\(self.leftContentWidth))]", for: ["imageContainer": imageContainer])
        self.addVisualConstraint("V:|-[imageContainer]-|", for: ["imageContainer": imageContainer])

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = icon
        imageContainer.addSubview(imageView)

        self.addVisualConstraint("H:[imageView(40)]|", for: ["imageView": imageView])
        self.addVisualConstraint("V:|[imageView(40)]-(>=0)-|", for: ["imageView": imageView])

        //Customize the UI of imageView
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
    }

    private func addTitleLabel() {
        titleLabel.text = title
        titleLabel.textColor = self.primaryTextColor
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0

        self.addVisualConstraint("H:[imageContainer]-[titleLabel]-|", for: ["titleLabel": titleLabel, "imageContainer": imageContainer])
        self.addVisualConstraint("V:|-[titleLabel]", for: ["titleLabel": titleLabel])
    }

    private func addDescriptionLabel() {
        descriptionLabel.text = self.descriptionText
        descriptionLabel.textColor = secondaryTextColor
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = 0

        self.addVisualConstraint("H:[imageContainer]-[descriptionLabel]-|", for: ["imageContainer": imageContainer, "descriptionLabel": descriptionLabel])
        self.addVisualConstraint("V:[titleLabel][descriptionLabel]-|", for: ["titleLabel": titleLabel, "descriptionLabel": descriptionLabel])
    }

}
