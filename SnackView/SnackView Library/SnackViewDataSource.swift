//
//  SnackViewDataSource.swift
//  SnackView
//
//  Created by Luca Casula on 09/01/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import UIKit

/**
 The methods adopted by the object you use to manage data and provide SVItem array for a SnackView

 SnackView manage only the presentation of their data; they do not manage the data itself. To manage the data, you provide the SnackView with a data source object—that is, an object that implements the SnackViewDataSource protocol. A data source object responds to data-related requests from the SnackView. It also manages the SnackView's data directly, or coordinates with other parts of your app to manage that data. Other responsibilities of the data source object include:
 Reporting the title for a specific SnackView.
 Providing the title for the cancel / dismiss button for a specific SnackView.
 Providing the SVItem array containing the items to display for a specific SnackView.
 
 */
public protocol SnackViewDataSource: class {

    /// Tells the data source to return the title for a specific SnackView.
    ///
    /// - Parameter snackView: Instance of SnackView for which get title string
    /// - Returns: String value rapresenting SnackView title
    func titleFor(snackView: SnackView) -> String

    /// Tells the data source to return the title of **cancel** or **dismiss** button for a specific SnackView.
    ///
    /// - Parameter snackView: Instance of SnackView for which get cancel button title string
    /// - Returns: Optional string value rapresenting SnackView cancel button title or nil if you want to hide Cancel button.
    func cancelTitleFor(snackView: SnackView) -> String?

    /// Tells the data source to return an SVItem array for a specific SnackView.
    ///
    /// - Parameter snackView: Instance of SnackView for which get items array
    /// - Returns: Array containing SVItem's to display in SnackView
    func itemsFor(snackView: SnackView) -> [SVItem]
}
