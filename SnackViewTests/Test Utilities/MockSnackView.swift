//
//  MockSnackView.swift
//  SnackViewTests
//
//  Created by Kevin Morton on 1/6/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import Foundation

@testable import SnackView

// codebeat:disable[TOO_MANY_IVARS]

class MockSnackView: SnackViewDataSource {

    func titleFor(snackView: SnackView) -> String {
        return "SnackView Test"
    }

    func cancelTitleFor(snackView: SnackView) -> String? {
        return "Cancel"
    }

    func itemsFor(snackView: SnackView) -> [SVItem] {
        let buttonItem = SVButtonItem(withTitle: "Do something", withButtonAction: {})
        let titleItem = SVTitleItem(withTitle: "SnackView item", andCancelButton: "Done")

        return [buttonItem, titleItem]
    }


    var invokedShow = false
    var invokedShowCount = 0
    func show() {
        invokedShow = true
        invokedShowCount += 1
    }

    var invokedClose = false
    var invokedCloseCount = 0
    func close() {
        invokedClose = true
        invokedCloseCount += 1
    }

    var invokedInsertItem = false
    var invokedInsertItemCount = 0
    var invokedInsertItemParameters: (item: SVItem, index: Int?)?
    var invokedInsertItemParametersList = [(item: SVItem, index: Int?)]()
    func insert(item: SVItem, atIndex index: Int?) {
        invokedInsertItem = true
        invokedInsertItemCount += 1
        invokedInsertItemParameters = (item, index)
        invokedInsertItemParametersList.append((item, index))
    }

    var invokedRemoveItem = false
    var invokedRemoveItemCount = 0
    var invokedRemoveItemParameters: (item: SVItem, Void)?
    var invokedRemoveItemParametersList = [(item: SVItem, Void)]()
    func remove(item: SVItem) {
        invokedRemoveItem = true
        invokedRemoveItemCount += 1
        invokedRemoveItemParameters = (item, ())
        invokedRemoveItemParametersList.append((item, ()))
    }

    var invokedRemoveItemAtIndex = false
    var invokedRemoveItemAtIndexCount = 0
    var invokedRemoveItemAtIndexParameters: (index: Int, Void)?
    var invokedRemoveItemAtIndexParametersList = [(index: Int, Void)]()
    func removeItemAt(index: Int) {
        invokedRemoveItemAtIndex = true
        invokedRemoveItemAtIndexCount += 1
        invokedRemoveItemAtIndexParameters = (index, ())
        invokedRemoveItemAtIndexParametersList.append((index, ()))
    }

    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (items: [SVItem], Void)?
    var invokedUpdateParametersList = [(items: [SVItem], Void)]()
    func updateWith(items: [SVItem]) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (items, ())
        invokedUpdateParametersList.append((items, ()))
    }
}

extension MockSnackView {
    var items: [SVItem] {

        let buttonItem = SVButtonItem(withTitle: "Do something", withButtonAction: {})
        let titleItem = SVTitleItem(withTitle: "SnackView item", andCancelButton: "Done")

        return [buttonItem, titleItem]
    }
}

// codebeat:enable[TOO_MANY_IVARS]
