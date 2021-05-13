//
//  SVButtonItem.swift
//  SnackView
//
//  Created by Luca Casula on 09/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVButtonItem is an SVItem consisting of a simple button that can perform the action that you want. */
public class SVButtonItem: SVItem {

    // MARK: - Properties
    private(set) var title: String

    // MARK: - Initialization Method
    /**
     Initialization method for SVButtonItem view. You can customize this item with title, tint color and action.
     - parameter title: The title of the button
     - parameter color: The button text color
     - parameter buttonAction: A closure in which to write the action that the button must perform
     */
    public init(withTitle title: String, tintColor color: UIColor? = nil, withButtonAction buttonAction: @escaping () -> Void) {
        self.title = title
        super.init()

        //Assign the action block to tmpAction variable
        self.tmpAction = buttonAction

        //Add button item
        let buttonItem = UIButton()
        buttonItem.translatesAutoresizingMaskIntoConstraints = false
        buttonItem.setTitle(title, for: UIControl.State())
        buttonItem.setTitleColor((color ?? blueButtonColor), for: UIControl.State.normal)
        buttonItem.setTitleColor((color ?? blueButtonColor).withAlphaComponent(0.5), for: UIControl.State.highlighted)
        buttonItem.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        self.addSubview(buttonItem)

        //Add constraints to buttonItem
        let buttonHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[buttonItem]-|", options: [], metrics: nil, views: ["buttonItem": buttonItem])
        self.addConstraints(buttonHContraints)

        let buttonVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[buttonItem]-|", options: [], metrics: nil, views: ["buttonItem": buttonItem])
        self.addConstraints(buttonVContraints)
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Custom Stuff
    private var tmpAction:() -> Void = {}
    @objc public func buttonSelector() {
        self.tmpAction()
    }
}
