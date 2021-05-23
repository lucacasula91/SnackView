//
//  SVStepperItem.swift
//  SnackView
//
//  Created by Luca Casula on 20/05/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import UIKit

/** SVStepperItem is an SVItem with which to show a title and a UIStepper item. */
public class SVStepperItem: SVItem {

    // MARK: - Properties
    private var titleLabel: UILabel
    private var countLabel: UILabel
    private var stepper: UIStepper

    // Title property of the SVStepperItem
    private(set) var title: String

    // The amount selected from the stepper
    public var count: Double {
        set {
            self.stepper.value = newValue
            self.countLabel.text = "\(Int(count))"
        }
        get { stepper.value }
    }

    // MARK: - Initialization Method

    /// Initialization method for SVStepperItem view.
    /// - Parameters:
    ///   - title: Title of the SVStepperItem
    ///   - minimum: Minimum value of the UIStepper controller
    ///   - maximum: Maximum value of the UIStepper controller
    ///   - current: Current value of the UIStepper controller
    ///   - amountDidChange: Completion handler invoked at the change of amount
    public init(withTitle title: String, minimum: Double, maximum: Double, current: Double, amountDidChange: @escaping (Double) -> Void) {
        self.title = title
        self.titleLabel = UILabel()
        self.countLabel = UILabel()
        self.stepper = UIStepper()

        //Assign the action to tmpAction
        self.tmpAction = amountDidChange
        super.init()

        self.addTitleLabel()
        self.addCountLabel(with: current)
        self.addStepperController(withMinimum: minimum, maximum: maximum, andCurrent: current)
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
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==\(self.leftContentWidth))]",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["titleLabel": self.titleLabel])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["titleLabel": self.titleLabel])
        self.addConstraints(titleVContraints)
    }

    private func addCountLabel(with currentValue: Double) {
        self.countLabel.translatesAutoresizingMaskIntoConstraints = false
        self.countLabel.text = "\(Int(currentValue))"
        self.countLabel.textAlignment = .left
        self.countLabel.textColor = primaryTextColor
        self.countLabel.font = UIFont.boldSystemFont(ofSize: 22)
        self.countLabel.numberOfLines = 1
        self.addSubview(self.countLabel)

        //Add constraints to titleLabel
        let countLabelVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[countLabel(>=28)]-|",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["countLabel": self.countLabel])
        self.addConstraints(countLabelVContraints)
    }

    private func addStepperController(withMinimum minimum: Double, maximum: Double, andCurrent current: Double) {
        self.stepper.addTarget(self, action: #selector(stepperDidChangeAmount(_:)), for: .valueChanged)
        self.stepper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stepper)
        self.stepper.minimumValue = minimum
        self.stepper.maximumValue = maximum
        self.stepper.value = current

        //Add constraints to slider item
        let segmentControllerHContraints = NSLayoutConstraint.constraints(withVisualFormat:
                                                                "H:|-[titleLabel]-[countLabel]-(>=8)-[stepper]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["titleLabel": titleLabel as Any,
                                                                       "countLabel": self.countLabel,
                                                                       "stepper": stepper])
        self.addConstraints(segmentControllerHContraints)

        let segmentControllerVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[stepper]-|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["stepper": stepper])
        self.addConstraints(segmentControllerVContraints)
    }

    // MARK: - Custom Stuff
    private var tmpAction:(Double) -> Void = {_ in }
    @objc public func stepperDidChangeAmount(_ sender: UIStepper) {
        self.tmpAction(sender.value)
        self.countLabel.text = "\(Int(sender.value))"
    }
}
