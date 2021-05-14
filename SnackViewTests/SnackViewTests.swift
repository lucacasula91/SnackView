//
//  SnackViewTests.swift
//  SnackViewTests
//
//  Created by Luca Casula on 14/05/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import Nimble
import Quick

@testable import SnackView

class MockSnackView: SnackViewDataSource {

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

class SVItemsTests: QuickSpec {
    override func spec() {

        var snackView: SnackView?
        var snackViewSpy: MockSnackView?

        beforeEach {
            snackViewSpy = MockSnackView()
            snackView = SnackView(with: snackViewSpy!)

            _ = snackView?.view
        }

        describe("SnackView with invalid configuration") {

            it("had to be titled 'Invalid configuration'") {
                expect(snackView?.titleBar.titleLabel.text).to(equal("Invalid configuration"))
            }

            it("had to contains 'Close' button.") {
                expect(snackView?.titleBar.cancelButtonTitle).to(equal("Close"))
            }

            it("had to contains three elements.") {
                expect(snackView?.items?.count).to(equal(3))
            }
        }

        describe("SnackView reloadData method") {
            let detailedTextItem = SVDetailTextItem(withTitle: "Details", andDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")

            it("had to update the items.") {
                snackViewSpy?.set(items: [detailedTextItem])
                snackView?.reloadData()

                expect(snackView?.items?.count).to(equal(1))
                expect(detailedTextItem.frame.height).to(beGreaterThan(50))
            }
        }

    }
}

