//
//  SnackViewItemsTests.swift
//  SnackViewTests
//
//  Created by Luca Casula on 14/05/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//

import Nimble
import Quick

@testable import SnackView

class SnackViewItemsTests: QuickSpec {
    override func spec() {

        var snackView: SnackView?
        var snackViewSpy: MockSnackView?

        beforeEach {
            snackViewSpy = MockSnackView()
            snackView = SnackView(with: snackViewSpy!)

            _ = snackView?.view
        }

        describe("SVDetailTextItem") {
            let detailedTextItem = SVDetailTextItem(withTitle: "Details", andDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")

            it("with long text had to have at least 50 px of height.") {
                snackViewSpy?.set(items: [detailedTextItem])
                snackView?.reloadData()

                expect(detailedTextItem.frame.height).to(beGreaterThan(50))
            }
        }
        describe("SVDetailTextItem from init with coder") {
            let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
            let detailedTextItem = SVDetailTextItem(coder: archiver)

            it("had to return nil.") {
                expect(detailedTextItem).to(beNil())
            }
        }

        describe("SVDescriptionItem") {
            let descriptionItem = SVDescriptionItem(withDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")

            it("with long text had to have at least 50 px of height.") {
                snackViewSpy?.set(items: [descriptionItem])
                snackView?.reloadData()

                expect(descriptionItem.frame.height).to(beGreaterThan(50))
            }
        }

        describe("SVDescriptionItem from init with coder") {
            let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
            let descriptionItem = SVDescriptionItem(coder: archiver)

            it("had to return nil.") {
                expect(descriptionItem).to(beNil())
            }
        }


        describe("SVTextFieldItem") {
            let textFieldItem = SVTextFieldItem(withPlaceholder: "First name", isSecureField: false)
            textFieldItem.text = "John"

            it("had to have 'First name' as placeholder") {
                snackViewSpy?.set(items: [textFieldItem])
                snackView?.reloadData()

                expect(textFieldItem.text).to(equal("John"))
                expect(textFieldItem.placeholder).to(equal("First name"))
                expect(textFieldItem.isSecure).to(beFalse())
            }
        }

        describe("SVTextFieldItem from init with coder") {
            let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
            let textFieldItem = SVTextFieldItem(coder: archiver)

            it("had to return nil.") {
                expect(textFieldItem).to(beNil())
            }
        }

        describe("SVTitleItem") {
            let titleItem = SVTitleItem(withTitle: "My custom title", andCancelButton: "Close")

            it("had to have 'My custom title' as title") {
                expect(titleItem.title).to(equal("My custom title"))
            }

            it("had to have close button visible.") {
                expect(titleItem.cancelButton.isHidden).to(beFalse())
            }

            it("had to have close button hidden.") {
                titleItem.setCancelTitle(nil)
                expect(titleItem.cancelButton.isHidden).to(beTrue())
            }

            it("had to have 'My second title' as title with setTitle method.") {
                titleItem.setTitle("My second title")
                expect(titleItem.title).to(equal("My second title"))
            }


        }

    }
}

