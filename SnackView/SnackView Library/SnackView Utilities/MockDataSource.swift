//
//  MockDataSource.swift
//  SnackView
//
//  Created by Luca Casula on 08/01/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import UIKit

/// This class is a temporary workaround to allow old init method to work properly.
/// This class and old init method will be removed with some SnackView update.

class MockDataSource: NSObject, SnackViewDataSource {
    private(set) var items: [SVItem] = []
    private(set) var titleOptions: SVTitleOptions?
    private(set) var title: String
    private(set) var closeTitle: String

    init(withTitle title: String, andCloseButtonTitle closeTitle: String, andItems items: [SVItem]) {
        self.items = items
        self.title = title
        self.closeTitle = closeTitle
    }

    init(withTitleOptions titleOptions: SVTitleOptions, andItems items: [SVItem]) {
        self.titleOptions = titleOptions
        self.items = items

        self.title = titleOptions.title
        self.closeTitle = titleOptions.closeButtonTitle
    }

    func titleFor(snackView: SnackView) -> String {
        return self.title
    }

    func cancelTitleFor(snackView: SnackView) -> String? {
        return self.closeTitle
    }

    func itemsFor(snackView: SnackView) -> [SVItem] {
        return self.items
    }


}
