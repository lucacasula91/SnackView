//
//  SVSegmentedControllerItem.swift
//  SnackView
//
//  Created by Luca Casula on 18/05/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import Foundation
/** SVSliderItem is an SVItem with which to show a title and a UISlider item. */
public class SVSegmentedControllerItem: SVItem {

    // MARK: - Properties
    private var titleLabel: UILabel
    private var segmentedController: UISegmentedControl
    private(set) var title: String

    private(set) var segments: [String]
    public var selectedSegment: Int {
        set {
            self.segmentedController.selectedSegmentIndex = newValue
            self.segmentedController.sendActions(for: .valueChanged)
        }
        
        get { return self.segmentedController.selectedSegmentIndex }
    }

    // MARK: - Initialization Method
    public init(withTitle title: String, segments: [String], selectionDidChange: @escaping (Int) -> Void) {
        self.title = title
        self.segments = segments
        self.titleLabel = UILabel()
        self.segmentedController = UISegmentedControl()

        //Assign the UISwitch action to tmpAction
        self.tmpAction = selectionDidChange
        super.init()

        self.setupUI()
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func setupUI() {
        self.addTitleLabel()
        self.addSegmentedController()
    }

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

    private func addSegmentedController() {
        self.segmentedController.addTarget(self, action: #selector(segmentedControllerSelectionDidChange(_:)), for: .valueChanged)
        self.segmentedController.translatesAutoresizingMaskIntoConstraints = false
        for (index, title) in segments.enumerated() {
            self.segmentedController.insertSegment(withTitle: title, at: index, animated: false)
        }
        self.addSubview(self.segmentedController)

        //Add constraints to slider item
        let segmentControllerHContraints = NSLayoutConstraint.constraints(withVisualFormat:
                                                                "H:|-[titleLabel]-[segment]-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["titleLabel": titleLabel as Any, "segment": segmentedController])
        self.addConstraints(segmentControllerHContraints)

        let segmentControllerVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[segment]-|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["segment": segmentedController])
        self.addConstraints(segmentControllerVContraints)
    }

    // MARK: - Custom Stuff
    private var tmpAction:(Int) -> Void = {_ in }
    @objc public func segmentedControllerSelectionDidChange(_ sender: UISegmentedControl) {
        self.tmpAction(sender.selectedSegmentIndex)
    }
}
