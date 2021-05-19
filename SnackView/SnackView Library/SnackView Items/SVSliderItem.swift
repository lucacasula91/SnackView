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
    private var titleLabel: UILabel
    private var slider: UISlider
    private(set) var title: String
    public var currentValue: Float {
        set {
            self.slider.value = newValue
            self.sliderValueDidChanged(self.slider)
        }
        get {return self.slider.value}
    }

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
        self.titleLabel = UILabel()
        self.slider = UISlider()
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
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = self.title.uppercased()
        self.titleLabel.textAlignment = .right
        self.titleLabel.textColor = secondaryTextColor
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)

        //Add constraints to titleLabel
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==\(self.leftContentWidth))]", options: [], metrics: nil, views: ["titleLabel": self.titleLabel])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|", options: [], metrics: nil, views: ["titleLabel": self.titleLabel])
        self.addConstraints(titleVContraints)
    }

    private func addSliderItem(withMinimumValue minimum: Float, andMaximumValue maximum: Float, andCurrentValue current: Float) {
        //Add UISlider item
        self.slider.translatesAutoresizingMaskIntoConstraints = false
        self.slider.minimumValue = minimum
        self.slider.maximumValue = maximum
        self.slider.value = current
        self.slider.addTarget(self, action: #selector(sliderValueDidChanged(_:)), for: .valueChanged)
        self.addSubview(self.slider)

        //Add constraints to slider item
        let sliderHContraints = NSLayoutConstraint.constraints(withVisualFormat:
                                                                "H:|-[titleLabel]-[slider]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["titleLabel": titleLabel as Any, "slider": self.slider])
        self.addConstraints(sliderHContraints)

        let descriptionVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[slider]-|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["slider": self.slider])
        self.addConstraints(descriptionVContraints)
    }

    @objc private func sliderValueDidChanged(_ sender: UISlider) {
        self.setTitle(for: sender.value)
    }

    private func setTitle(for value: Float) {
        let formattedValue = String(format: "%.2f", value)
        self.titleLabel.text = "\(self.title)\n\(formattedValue)"
    }

}
