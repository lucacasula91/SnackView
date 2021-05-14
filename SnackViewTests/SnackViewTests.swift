//
//  SnackViewTests.swift
//  SnackViewTests
//
//  Created by Luca Casula on 14/05/2021.
//  Copyright © 2021 LucaCasula. All rights reserved.
//
//
import Nimble
import Quick

@testable import SnackView

class SVItemsTests: QuickSpec {
    override func spec() {

        var snackView: SnackView?
        var snackViewSpy: MockSnackViewDataSource?

        beforeEach {
            snackViewSpy = MockSnackViewDataSource()
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

        describe("SnackView from init with coder") {
            let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
            let mySnackView = SnackView(coder: archiver)

            it("had to return nil.") {
                expect(mySnackView).to(beNil())
            }
        }

        describe("SnackView") {
            it("had to have not nil inputAccessoryView property.") {
                expect(snackView?.inputAccessoryView).toNot(beNil())
            }
        }

        describe("SnackView") {
            context("when presented") {
                it("had to have a parent called 'SnackView Container'.") {
                    snackView?.show()

                    waitUntil(timeout: DispatchTimeInterval.seconds(3)) { (done) in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            done()
                        }
                    }

                    expect(snackView?.presentingViewController?.title).to(equal("SnackView Container"))
                }
            }

            context("when dismissed") {
                it("had to have window property nil.") {
                    snackView?.close()

                    waitUntil(timeout: DispatchTimeInterval.seconds(3)) { (done) in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            done()
                        }
                    }

                    expect(snackView?.window).to(beNil())
                }
            }

        }
    }
}

