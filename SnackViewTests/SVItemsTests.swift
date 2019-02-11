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

        describe("SVApplicationItem") {
            let icon = UIImage()
            let title = "My title"
            let descriptionText = "My description text"
            let applicationItem = SVApplicationItem(withIcon: icon, withTitle: title, andDescription: descriptionText)

            it("has an icon") {
                expect(applicationItem.icon).to(equal(icon))
            }

            it("has a title") {
                expect(applicationItem.title).to(equal(title))
            }

            it("has a description text") {
                expect(applicationItem.descriptionText).to(equal(descriptionText))
            }

            context("when init via coder") {
                it("return nil") {
                    let archivier = self.getArchivier()
                    let newApplicationItem = SVApplicationItem(coder: archivier)
                    expect(newApplicationItem).to(beNil())
                }
            }
        }

        describe("SVImageViewItem") {
            let icon = UIImage()
            let contentMode = UIView.ContentMode.scaleToFill
            let height: CGFloat = 124.0

            let imageView = SVImageViewItem(withImage: icon, andContentMode: contentMode, andHeight: height)

            it("has an icon") {
                expect(imageView.image).to(equal(icon))
            }
            it("has a contentMode") {
                expect(imageView.currentContentMode).to(equal(contentMode))
            }

            it("has a height") {
                expect(imageView.currentHeight).to(equal(height))
            }

            context("when init via coder") {
                it("return nil") {
                    let archivier = self.getArchivier()
                    let newImageView = SVImageViewItem(coder: archivier)
                    expect(newImageView).to(beNil())
                }
            }
        }

        describe("SVDetailTextItem") {
            let title = "Details"
            let descriptionText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."

            let detailedTextItem = SVDetailTextItem(withTitle: title, andDescription: descriptionText)

            it("has a title") {
                expect(detailedTextItem.title).to(equal(title))
            }

            it("has a description") {
                expect(detailedTextItem.descriptionText).to(equal(descriptionText))
            }

            context("when init via coder") {
                it("return nil") {
                    let archivier = self.getArchivier()
                    let newDetailTextItem = SVDetailTextItem(coder: archivier)
                    expect(newDetailTextItem).to(beNil())
                }
            }

        }

        describe("SVSwitchItem") {
            var invokedSwitchAction = false
            let title = "Toggle"
            let descriptionText = "My description"

            let switchItem = SVSwitchItem(withTitle: title, andDescription: descriptionText, withState: false, withSwitchAction: { _ in
                invokedSwitchAction = true
            })

            it("has a title") {
                expect(switchItem.title).to(equal(title))
            }

            it("has a description") {
                expect(switchItem.descriptionText).to(equal(descriptionText))
            }

            it("invokedSwitchAction is false") {
                expect(invokedSwitchAction).to(beFalse())
            }

            context("when switch is toggled") {
                it("invokedSwitchAction is true") {
                    switchItem.switchSelector(switchItem: UISwitch())
                    expect(invokedSwitchAction).to(beTrue())
                }
            }

            context("when init via coder") {
                it("it must be return nil") {
                    let archivier = self.getArchivier()
                    let newSwitchItem = SVSwitchItem(coder: archivier)
                    expect(newSwitchItem).to(beNil())
                }
            }
        }

        describe("SVItem") {

            context("when init via coder") {
                it("it must be return nil") {
                    let archivier = self.getArchivier()
                    let newItem = SVItem(coder: archivier)
                    expect(newItem).to(beNil())
                }
            }

            it("it must have minimum height active by default") {
                let item = SVItem()
                item.setMinimumHeightActive(active: true)
                expect(item.heightConstraint).toNot(beNil())
                expect(item.heightConstraint?.constant).to(equal(50))
            }

            it("it can have minimum height deactivated") {
                let item = SVItem()
                item.setMinimumHeightActive(active: false)
                expect(item.heightConstraint).to(beNil())
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

            context("when initialized with text") {
                let text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."

                it("has a height greater than or equal to 70") {
                    let largerLoaderItem = SVLoaderItem(withSize: .large, andText: text)

                    expect(largerLoaderItem.text).to(equal(text))
                }
            }

            context("when init via coder") {
                it("it must be return nil") {
                    let archivier = self.getArchivier()
                    let newItem = SVLoaderItem(coder: archivier)
                    expect(newItem).to(beNil())
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

        describe("SVTitleOptions") {
            let title = "My title"
            let visible = true
            let closeButtonTitle = "Close"

            it("it has been initialized correctly") {
                let titleOptions = SVTitleOptions(withTitle: title, setCloseButtonVisible: visible, setCloseButtonTitle: closeButtonTitle)

                expect(titleOptions.title).to(equal(title))
                expect(titleOptions.closeButtonVisible).to(equal(visible))
                expect(titleOptions.closeButtonTitle).to(equal(closeButtonTitle))
            }

            it("it has close button hidden") {
                let titleOptions = SVTitleOptions(withTitle: title, setCloseButtonVisible: false, setCloseButtonTitle: nil)
                expect(titleOptions.title).to(equal(title))
                expect(titleOptions.closeButtonVisible).to(equal(false))
                expect(titleOptions.closeButtonTitle).to(equal(""))
            }
        }

        describe("SVDescriptionItem") {
            let descriptionText = "My description text"

            it("it has been initialized correctly") {
                let descriptionItem = SVDescriptionItem(withDescription: descriptionText)
                expect(descriptionItem.descriptionText).to(equal(descriptionText))
            }

            context("when init via coder") {
                it("it must be return nil") {
                    let archivier = self.getArchivier()
                    let newItem = SVDescriptionItem(coder: archivier)
                    expect(newItem).to(beNil())
                }
            }
        }

        describe("SVButtonItem") {

            it("it has been initialized correctly") {
                let title = "Button title"
                let color = UIColor.green
                var buttonHasTapped = false

                let buttonItem = SVButtonItem(withTitle: title, tintColor: color, withButtonAction: {
                    buttonHasTapped = true
                })
                expect(buttonItem.title).to(equal(title))
                expect(buttonItem.tint).to(equal(color))

                buttonItem.buttonSelector()
                expect(buttonHasTapped).to(equal(true))
            }

            context("when init via coder") {
                it("it must be return nil") {
                    let archivier = self.getArchivier()
                    let newItem = SVButtonItem(coder: archivier)
                    expect(newItem).to(beNil())
                }
            }
        }

        describe("SVTextFieldItem,") {
            let placeholder = "My placeholder"
            let isSecure = true

            it("it has been initialized correctly") {
                let textFieldItem = SVTextFieldItem(withPlaceholder: placeholder, isSecureField: isSecure)
                expect(textFieldItem.placeholder).to(equal(placeholder))
                expect(textFieldItem.isSecure).to(equal(isSecure))
            }

            it("it can be edited") {
                let text = "Text typed"
                let textFieldItem = SVTextFieldItem(withPlaceholder: placeholder, isSecureField: isSecure)

                textFieldItem.text = text
                expect(textFieldItem.text).to(equal(text))
            }


            context("when init via coder") {
                it("it must be return nil") {
                    let archivier = self.getArchivier()
                    let newItem = SVTextFieldItem(coder: archivier)
                    expect(newItem).to(beNil())
                }
            }
        }

    }

    private func getArchivier() -> NSKeyedArchiver {
        let archiverData = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: archiverData)
        return archiver
    }
}

