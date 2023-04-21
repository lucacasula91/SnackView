//
//  MockSnackViewDataSource.swift
//  SnackViewTests
//
//  Created by Luca Casula on 14/05/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import UIKit
import SnackView

class MockSnackViewDataSource: SnackViewDataSource {

    private var items: [SVItem] = []

    func titleFor(snackView: SnackView) -> String {
        return "Mock SnackView"
    }

    func cancelTitleFor(snackView: SnackView) -> String? {
        "Cancel"
    }

    func itemsFor(snackView: SnackView) -> [SVItem] {
        return self.items
    }

    public func set(items: [SVItem]) {
        self.items = items
    }

}
