//
//  SnackViewProtocol.swift
//  SnackView
//
//  Created by Kevin Morton on 1/6/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import Foundation

public protocol SnackViewProtocol {
    
    /// Displayed in the top left of the SnackView.
    var title: String { get }
    
    /// Array of SVItem's.
    var items: [SVItem] { get }
    
    /// Title option used for customizing SVTitleItems appearance.
    var titleOptions: SVTitleOptions? { get }
    
    /// Close buttons title.  Default is 'close'.
    var closeTitle: String { get }
    
    /// Presents the SnackView.
    func show()
    
    /// Dismisses the SnackView.
    func close()
}

public extension SnackViewProtocol {
    
    // MARK: Defaults
    
    var items: [SVItem] {
        return []
    }
    
    var titleOptions: SVTitleOptions? {
        return nil
    }
    
    var title: String {
        return ""
    }
    
    var closeTitle: String {
        return "Done"
    }
}
