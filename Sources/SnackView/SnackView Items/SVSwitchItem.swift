//
//  SVSwitchItem.swift
//  SnackView
//
//  Created by Luca Casula on 09/04/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

import UIKit

/** SVSwitchItem is an SVItem with which to show a title, a description and a UISwitch */
public class SVSwitchItem: SVItem {

    // MARK: - Private Properties
    private var titleLabel: UILabel = UILabel()
    private var switchItem: UISwitch = UISwitch()
    private var descriptionLabel: UILabel = UILabel()

    // MARK: - Properties
    private(set) var title: String?
    private(set) var descriptionText: String?
    private(set) var currentState: Bool

    // MARK: - Initialization Method
    /**
     Initialization method for SVSwitchItem view. You can customize this item with a title, a description text and an action to assign when UISwitch value change.
     - parameter title: The title you want to show
     - parameter description: The description text you want to show. This parameter is nullable
     - parameter state: The initial state of UISwitch
     - parameter switchAction: The action to perform when UISwitch value change

     **Note that label text on the left will be rendered as uppercased text**.

     To force the placeholder text to be rendered in multi-line please enter **\n** where you want the text to wrap.


     **Here an example of wrapped text**:
     ```
     SVSwitchItem(withTitle: "Push\nNotifications",
     andDescription: "Ipsum lorem sit...",
     withState: false) { isSwitchOn in
        print(isSwitchOn)
     }
     ```
     */
    public init(withTitle title: String?, andDescription description: String?, withState state: Bool, withSwitchAction switchAction: @escaping (_ switchValue: Bool) -> Void) {
        self.title = title
        self.descriptionText = description
        self.currentState = state

        super.init()
        [titleLabel, switchItem, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        self.addTitleLabel()
        self.addSwitch()
        self.addDescriptionLabel()

        //Assign the UISwitch action to tmpAction
        self.tmpAction = switchAction
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func addTitleLabel() {
        self.titleLabel.text = title?.uppercased()
        self.titleLabel.textAlignment = .right
        self.titleLabel.textColor = secondaryTextColor
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.numberOfLines = 0

        let views: [String: Any] = ["titleLabel": titleLabel]
        self.addVisualConstraint("H:|-[titleLabel(==\(self.leftContentWidth))]", for: views)
        self.addVisualConstraint("V:|-[titleLabel(>=28)]-|", for: views)
    }

    private func addSwitch() {
        self.switchItem.addTarget(self, action: #selector(switchSelector(switchItem:)), for: .valueChanged)
        self.switchItem.tintColor = self.secondaryTextColor

        let views: [String: Any] = ["switch": switchItem]
        self.addVisualConstraint("H:[switch]-|", for: views)
        self.switchItem.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }

    private func addDescriptionLabel() {
        if let text = descriptionText {
            descriptionLabel.text = text
        }
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.textColor = self.primaryTextColor
        self.descriptionLabel.textColor = self.primaryTextColor
        self.descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.descriptionLabel.adjustsFontForContentSizeCategory = true
        self.descriptionLabel.numberOfLines = 0

        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        let views: [String: Any] = ["titleLabel": titleLabel, "switch": switchItem, "descriptionLabel": descriptionLabel]
        self.addVisualConstraint("V:|-[descriptionLabel]-|", for: views)
        self.addVisualConstraint("H:[titleLabel]-[descriptionLabel]-[switch]", for: views)
    }

    // MARK: - Custom stuff
    var tmpAction:(_ switchValue: Bool) -> Void = {_ in }
    @objc func switchSelector(switchItem: UISwitch) {
        let currentState = switchItem.isOn
        
        self.tmpAction(currentState)
        self.currentState = currentState
    }

}
