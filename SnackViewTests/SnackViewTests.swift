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

            context("When initialized by deprecated init") {

                let snackViewTitle = "My SnackView title"
                let cancelButtonTitle = "Cancel"

                var items = [SVItem]()
                let buttonItem = SVButtonItem(withTitle: "Continue", withButtonAction: { })
                items.append(buttonItem)

                let newSnackView = SnackView(withTitle: snackViewTitle, andCloseButtonTitle: cancelButtonTitle, andItems: items)

                it("has one item") {
                    expect(newSnackView.items).to(haveCount(1))
                    expect(newSnackView.titleOptions.title).to(equal(snackViewTitle))
                    expect(newSnackView.titleOptions.closeButtonTitle).to(equal(cancelButtonTitle))
                }
            }

            context("When initialized with title options") {
                let snackViewTitle = "My SnackView title"
                let cancelButtonTitle = "Cancel"
                let titleOptions = SVTitleOptions(withTitle: snackViewTitle, setCloseButtonVisible: true, setCloseButtonTitle: cancelButtonTitle)


                var items = [SVItem]()
                let buttonItem = SVButtonItem(withTitle: "Continue", withButtonAction: { })
                items.append(buttonItem)

                let newSnackView = SnackView(withTitleOptions: titleOptions, andItems: items)

                it("has one item") {
                    expect(newSnackView.items).to(haveCount(1))
                    expect(newSnackView.titleOptions.title).to(equal(snackViewTitle))
                    expect(newSnackView.titleOptions.closeButtonTitle).to(equal(cancelButtonTitle))
                }
            }

            it("has two items") {
                let items = snackViewSpy?.itemsFor(snackView: snackView!)
                expect(items).to(haveCount(2))
            }

            it("did not invoke Show ") {
                expect(snackViewSpy?.invokedShow).to(beFalsy())
            }

            it("must be deinitialized when nil") {
                snackView = nil
                expect(snackView).to(beNil())
            }
            
            context("When initialized via coder") {
                it("had to return nil") {
                    let archiverData = NSMutableData()
                    let archiver = NSKeyedArchiver(forWritingWith: archiverData)
                    let newSnackView = SnackView(coder: archiver)
                    expect(newSnackView).to(beNil())
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

