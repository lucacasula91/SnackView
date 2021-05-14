//
//  SVSliderItem.swift
//  SnackView
//
//  Created by Luca Casula on 13/05/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import UIKit

/** SVSliderItem is an SVItem with which to show a title and a UISlider item. */
public class SVSliderItem: SVItem {

    // MARK: - Properties
    private var titleLabel: UILabel?
    private var slider: UISlider?
    private(set) var title: String
    public var currentValue: Float { return self.slider?.value ?? 0}

    // MARK: - Initialization Method

    /**
     Initialization method for SVSliderItem view. You can customize this item with a title and a description text.
     - parameter title: The title to show
     - parameter minimum: The minimum value of the slider.
     - parameter maximum: The maximum value of the slider.
     - parameter current: The slider’s current value.
     */
    public init(withTitle title: String, minimum: Float, maximum: Float, current: Float) {
        self.title = title
        super.init()

        self.addTitleLabel()
        self.addSliderItem(withMinimumValue: minimum, andMaximumValue: maximum, andCurrentValue: current)

        self.setTitle(for: current)
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods

    private func addTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = self.title.uppercased()
        titleLabel.textAlignment = .right
        titleLabel.textColor = secondaryTextColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel

        //Add constraints to titleLabel
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==\(self.leftContentWidth))]", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|", options: [], metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(titleVContraints)
    }

    private func addSliderItem(withMinimumValue minimum: Float, andMaximumValue maximum: Float, andCurrentValue current: Float) {
        //Add UISlider item
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = minimum
        slider.maximumValue = maximum
        slider.value = current
        slider.addTarget(self, action: #selector(sliderValueDidChanged(_:)), for: .valueChanged)
        self.addSubview(slider)
        self.slider = slider

        //Add constraints to slider item
        let sliderHContraints = NSLayoutConstraint.constraints(withVisualFormat:
                                                                "H:|-[titleLabel]-[slider]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["titleLabel": titleLabel as Any, "slider": slider])
        self.addConstraints(sliderHContraints)

        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[slider]-|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["slider": slider])
        self.addConstraints(descriptionVContraints)
    }

    @objc private func sliderValueDidChanged(_ sender: UISlider) {
        self.setTitle(for: sender.value)
    }

    private func setTitle(for value: Float) {
        let formattedValue = String(format: "%.2f", value)
        self.titleLabel?.text = "\(self.title)\n\(formattedValue)"
    }

}
