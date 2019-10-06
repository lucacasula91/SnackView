//
//  MockDataSourceTests.swift
//  SnackViewTests
//
//  Created by Luca Casula on 11/02/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import Nimble
import Quick

@testable import SnackView
class MockDataSourceTests: QuickSpec {

    var mockDataSource: MockDataSource!
    var snackView: SnackView!
    var items: [SVItem]!
    var title: String!
    var isCancelButtonVisible: Bool!
    var cancelButtonTitle: String!

    override func spec() {

        beforeEach {
            let items = self.getItems()
            self.items = items

            self.title = "My title"
            self.isCancelButtonVisible = true
            self.cancelButtonTitle = "Cancel"

            self.mockDataSource = MockDataSource(withTitle: self.title, andCloseButtonTitle: self.cancelButtonTitle, andItems: self.items)
            self.snackView = SnackView(with: self.mockDataSource)

        }

        describe("MockDataSource") {
            context("when initialized") {

                it("has 1 item") {
                    let items = self.mockDataSource.items
                    expect(items).to(haveCount(1))
                }

                it("has title and close title") {
                    expect(self.mockDataSource.title).to(equal(self.title))
                    expect(self.mockDataSource.closeTitle).to(equal(self.cancelButtonTitle))
                }
            }

            it("has item") {
                let items = self.mockDataSource.itemsFor(snackView: self.snackView)
                expect(items.count).to(equal(self.items.count))
            }

            it("has title") {
                let title = self.mockDataSource.titleFor(snackView: self.snackView)
                expect(title).to(equal(self.title))
            }

            it("has cancel title button") {
                let cancelTitle = self.mockDataSource.cancelTitleFor(snackView: self.snackView)
                expect(cancelTitle).to(equal(self.cancelButtonTitle))
            }
        }
    }

    private func getItems() -> [SVItem] {
        let buttonItem = SVButtonItem(withTitle: "Continue") { }
        return [buttonItem]
    }
}
