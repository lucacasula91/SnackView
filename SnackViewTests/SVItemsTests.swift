//
//  SVItemsTests.swift
//  SnackViewTests
//
//  Created by Kevin Morton on 1/6/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import Nimble
import Quick

@testable import SnackView

class SVItemsTests: QuickSpec {
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

            it("has a height greater than the minimum value") {
                snackView?.insert(item: detailedTextItem, atIndex: 0)

                expect(detailedTextItem.frame.height).to(beGreaterThan(50))
            }
        }

        describe("SVSwitchItem") {
            var invokedSwitchAction = false

            let switchItem = SVSwitchItem(withTitle: "Toggle", andDescription: nil, withSwitchAction: { _ in
                invokedSwitchAction = true
            })

            it("invokedSwitchAction is false") {
                expect(invokedSwitchAction).to(beFalse())
            }

            context("when switch is toggled") {

                it("invokedSwitchAction is true") {
                    switchItem.switchSelector(switchItem: UISwitch())
                    expect(invokedSwitchAction).to(beTrue())
                }
            }
        }

        describe("SVLoaderItem") {

            it("has a height greater than or equal to 50") {
                let littleLoaderItem = SVLoaderItem(withSize: .little, andText: nil)
                snackView?.insert(item: littleLoaderItem, atIndex: 0)

                expect(littleLoaderItem.frame.height).to(beGreaterThanOrEqualTo(50))
            }

            context("when large loader") {

                it("has a height greater than or equal to 70") {
                    let largerLoaderItem = SVLoaderItem(withSize: .large, andText: nil)
                    snackView?.insert(item: largerLoaderItem, atIndex: 0)

                    expect(largerLoaderItem.frame.height).to(beGreaterThanOrEqualTo(70))
                }
            }
        }

        describe("SVImageViewItem") {
            context("After being initialized with a little image") {
                it("height must be less than 50") {
                    let littleImage = ImageCreator.getImageWith(size: CGSize(width: 320, height: 25))

                    let imageViewItem = SVImageViewItem(withImage: littleImage,
                                                        andContentMode: UIViewContentMode.scaleAspectFill)
                    snackView?.insert(item: imageViewItem, atIndex: 0)

                    expect(imageViewItem.frame.height).to(beLessThan(50))
                }
            }

            context("After being initialized with a large image") {
                it("height must be equal to image height") {
                    let largeImage = ImageCreator.getImageWith(size: CGSize(width: 320, height: 125))

                    let imageViewItem = SVImageViewItem(withImage: largeImage,
                                                        andContentMode: UIViewContentMode.scaleAspectFill)
                    snackView?.insert(item: imageViewItem, atIndex: 0)

                    expect(imageViewItem.frame.height).to(equal(125))
                }

            }

        }
    }
}

