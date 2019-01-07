//
//  SnackViewTests.swift
//  SnackViewTests
//
//  Created by Luca Casula on 14/03/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

import Nimble
import Quick

@testable import SnackView

class SnackViewTests: QuickSpec {
    override func spec() {

        var snackView: SnackView?
        var snackViewSpy: MockSnackView?

        beforeEach {
            snackViewSpy = MockSnackView()
            snackView = SnackView(with: snackViewSpy!)
            _ = snackView?.view
        }

        describe("initialization") {
            it("has two items") {
                expect(snackView?.getItems()).to(haveCount(2))
            }

            it("did not invoke Show ") {
                expect(snackViewSpy?.invokedShow).to(beFalsy())
            }

            context("when no SVItems") {

                it("should append an SVDescriptionItem") {
                    snackView?.updateWith(items: [])

                    expect(snackView?.getItems().first).to(beAKindOf(SVDescriptionItem.self))
                }
            }
        }

        describe("Modifying") {

            let applicationItem = SVApplicationItem(withIcon: UIImage(), withTitle: "SVItem", andDescription: "")

            context("when an application item is inserted at index 0") {
                it("adds the item to first index of its items") {
                    snackView?.insert(item: applicationItem, atIndex: 0)

                    expect(snackView?.getItems().first).to(equal(applicationItem))
                }
            }

            context("when the first item is removed") {
                it("has a count of 2") {
                    let firstItem = snackView?.getItems().first

                    snackView?.remove(item: firstItem!)
                    expect(snackView?.getItems()).to(haveCount(2))
                }
            }
        }

        describe("Presenting a SnackView") {

            beforeEach {
                snackView?.show()
            }

            it("should be the topmost view controller") {
                expect(topMostController()).to(beAKindOf(SnackView.self))
            }

            context("when close tapped") {

                it("should not be the topmost view controller") {
                    snackView?.close()

                    expect(topMostController()).toEventuallyNot(beAKindOf(SnackView.self))
                }
            }
        }
    }
}

