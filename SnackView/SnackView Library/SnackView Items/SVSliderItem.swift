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
    private var titleLabel: UILabel = UILabel()
    private var slider: UISlider = UISlider()
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

     **Note that label text on the left will be rendered as uppercased text**.

     To force the placeholder text to be rendered in multi-line please enter **\n** where you want the text to wrap.


     **Here an example of wrapped text**:
     ```
     SVSliderItem(withTitle: "Photo\nSaturation",
     minimum: 5,
     maximum: 20,
     current: 12)
     ```
     */
    public init(withTitle title: String, minimum: Float, maximum: Float, current: Float) {
        self.title = title
        super.init()

        [titleLabel, slider].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = true
            self.addSubview($0)
        }

        self.addTitleLabel()
        self.addSliderItem(withMinimumValue: minimum, andMaximumValue: maximum, andCurrentValue: current)
        self.setTitle(for: current)
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods

    private func addTitleLabel() {
        self.titleLabel.text = self.title.uppercased()
        self.titleLabel.textAlignment = .right
        self.titleLabel.textColor = secondaryTextColor
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.numberOfLines = 0

        let views: [String: Any] = ["titleLabel": self.titleLabel]
        self.addVisualConstraint("H:|-[titleLabel(==\(self.leftContentWidth))]", for: views)
        self.addVisualConstraint("V:|-[titleLabel(>=28)]-|", for: views)
    }

    private func addSliderItem(withMinimumValue minimum: Float, andMaximumValue maximum: Float, andCurrentValue current: Float) {
        self.slider.minimumValue = minimum
        self.slider.maximumValue = maximum
        self.slider.value = current
        self.slider.addTarget(self, action: #selector(sliderValueDidChanged(_:)), for: .valueChanged)

        let views: [String: Any] = ["titleLabel": titleLabel as Any, "slider": self.slider]
        self.addVisualConstraint("H:|-[titleLabel]-[slider]-|", for: views)
        self.slider.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    @objc private func sliderValueDidChanged(_ sender: UISlider) {
        self.setTitle(for: sender.value)
    }

    private func setTitle(for value: Float) {
        let formattedValue = String(format: "%.2f", value)
        let title = self.title.uppercased()
        self.titleLabel.text = "\(title)\n\(formattedValue)"
    }

}
