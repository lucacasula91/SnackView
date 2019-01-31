//
//  SnackViewDataSource.swift
//  SnackView
//
//  Created by Luca Casula on 09/01/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import UIKit

/// Description
public protocol SnackViewDataSource: class {

    /// Description
    ///
    /// - Parameter snackView: Instance of SnackView for which get title string
    /// - Returns: String value rapresenting SnackView title
    func titleFor(snackView: SnackView) -> String

    /// Description
    ///
    /// - Parameter snackView: Instance of SnackView for which get cancel button title string
    /// - Returns: Optional string value rapresenting SnackView cancel button title or nil if you wanna hide Cancel button.
    func cancelTitleFor(snackView: SnackView) -> String?

    /// Description
    ///
    /// - Parameter snackView: Instance of SnackView for which get items array
    /// - Returns: Array containing SVItem's to display in SnackView
    func itemsFor(snackView: SnackView) -> [SVItem]
}
