//
//  SVItem.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/**
 SVItem is the main class with which all the items that can be used with SnackView have been created.
 
 SVItem provides by default some properties common to all elements such as the separator line that appears between the items or the minimum height of the item that is active by default.
 
 If you need to create a custom item, subclass the SVItem class first.
 */
open class SVItem: UIView {

    // MARK: - Private variables
    private var bottomLine: UIView!

    // MARK: - Public Variables
    private(set) var heightConstraint: NSLayoutConstraint?
    public let leftContentWidth: CGFloat = 111


    /// The color for text labels that contain primary content.
    public var primaryTextColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }

    /// The color for text labels that contain secondary content.
    public var secondaryTextColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        } else {
            return #colorLiteral(red: 0.5553562641, green: 0.5649003983, blue: 0.5733956099, alpha: 1)
        }
    }

    /// A blue color that automatically adapts to the current trait environment.
    public var blueButtonColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue
        } else {
            return #colorLiteral(red: 0, green: 0.4779834747, blue: 0.9985283017, alpha: 1)
        }
    }

    /// The color for thin borders or divider lines that allows some underlying content to be visible.
    public var separatorColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.separator
        } else {
            return #colorLiteral(red: 0.8010786772, green: 0.8010975718, blue: 0.8010874391, alpha: 1)
        }
    }
    

    // MARK: - Init Method
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear

        // Add separator line
        self.addBottomLine()

        self.clipsToBounds = true
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Public Method
    /**
     Use this method to add or remove the automatic height constraint. SVItem has a minimum height value equal or greater than 50 pixels.
     - parameter active: Bool value
     */
    public func setMinimumHeightActive(active: Bool) {

        if active {
            self.setDefaultHeightConstraint()
        }
        else {
            if let tmpConstraint = self.heightConstraint {
                self.removeConstraint(tmpConstraint)
                self.heightConstraint = nil
            }
        }
    }

    // MARK: - Internal methods
    internal func addBottomLine() {
        if bottomLine == nil {
            bottomLine = UIView()
            bottomLine.backgroundColor = self.separatorColor
            bottomLine.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(bottomLine)

            //Add constraints to bottomLine
            if let _bottomLine = bottomLine {
                let bottomLineHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomLine]|", options: [], metrics: nil, views: ["bottomLine": _bottomLine])
                let bottomLineVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomLine(0.5)]|", options: [], metrics: nil, views: ["bottomLine": _bottomLine])
                self.addConstraints(bottomLineHConstraints + bottomLineVConstraints)
            }

            //Add minimum view height
            self.setDefaultHeightConstraint()
        }
    }

    internal func setDefaultHeightConstraint() {
        self.heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)

        if let tmpConstraint = self.heightConstraint {
            self.addConstraint(tmpConstraint)
        }
    }
}
