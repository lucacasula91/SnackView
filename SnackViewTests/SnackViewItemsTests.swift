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
        var snackViewSpy: MockSnackViewDataSource?

        beforeEach {
            snackViewSpy = MockSnackViewDataSource()
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
            let archiver = NSKeyedArchiver(requiringSecureCoding: false)
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
            let archiver = NSKeyedArchiver(requiringSecureCoding: false)
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
            let archiver = NSKeyedArchiver(requiringSecureCoding: false)
            let textFieldItem = SVTextFieldItem(coder: archiver)

            it("had to return nil.") {
                expect(textFieldItem).to(beNil())
            }
        }

        describe("SVTitleItem") {
            let titleItem = SVTitleItem()
            titleItem.setTitle("My custom title")

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

        describe("SVTitleItem from init with coder") {
            let archiver = NSKeyedArchiver(requiringSecureCoding: false)
            let titleItem = SVTitleItem(coder: archiver)

            it("had to return nil.") {
                expect(titleItem).to(beNil())
            }
        }

        describe("SVImageView") {
            let image: UIImage = #imageLiteral(resourceName: "Icon")
            let imageView = SVImageViewItem(with: image, andContentMode: UIView.ContentMode.center, andHeight: 123.0)

            it("had to have 'image' property non nil.") {
                snackViewSpy?.set(items: [imageView])
                snackView?.reloadData()

                expect(imageView.image).toNot(beNil())
            }

            it("had to have 'height' constraint setted to 123.") {
                snackViewSpy?.set(items: [imageView])
                snackView?.reloadData()

                expect(imageView.currentHeight).to(equal(123))
            }

            describe("SVTitleItem from init with coder") {
                let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                let imageView = SVImageViewItem(coder: archiver)

                it("had to return nil.") {
                    expect(imageView).to(beNil())
                }
            }

        }

        describe("SVSwitchItem") {
            var switchValueChanged: Bool = false
            let switchItem = SVSwitchItem(withTitle: "My Title", andDescription: "My Description", withState: false, withSwitchAction: { _ in switchValueChanged = true })

            it("had to have 'title', 'description' and 'currentState' property non nil.") {
                snackViewSpy?.set(items: [switchItem])
                snackView?.reloadData()

                expect(switchItem.title).to(equal("My Title"))
                expect(switchItem.descriptionText).to(equal("My Description"))
                expect(switchItem.currentState).to(beFalse())

                switchItem.switchSelector(switchItem: UISwitch())
                expect(switchValueChanged).to(beTrue())
            }

            describe("SVSwitchItem from init with coder") {
                let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                let switchItem = SVSwitchItem(coder: archiver)

                it("had to return nil.") {
                    expect(switchItem).to(beNil())
                }
            }
        }

        describe("SVApplicationItem") {
            let applicationItem = SVApplicationItem(withIcon: #imageLiteral(resourceName: "Icon"), withTitle: "My Application", andDescription: "My Description")

            it("had to have 'title', 'description' and 'icon' property non nil.") {
                snackViewSpy?.set(items: [applicationItem])
                snackView?.reloadData()

                expect(applicationItem.title).to(equal("My Application"))
                expect(applicationItem.descriptionText).to(equal("My Description"))
                expect(applicationItem.icon).toNot(beNil())
            }

            describe("SVApplicationItem from init with coder") {
                let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                let applicationItem = SVApplicationItem(coder: archiver)

                it("had to return nil.") {
                    expect(applicationItem).to(beNil())
                }
            }
        }

        describe("SVButtonItem") {
            var buttonClicked: Bool = false
            let buttonItem = SVButtonItem(withTitle: "My Button", withButtonAction: { buttonClicked = true })

            it("had to have 'title' property non nil.") {
                snackViewSpy?.set(items: [buttonItem])
                snackView?.reloadData()

                expect(buttonItem.title).to(equal("My Button"))

                buttonItem.buttonSelector()
                expect(buttonClicked).to(beTrue())
            }

            describe("SVButton from init with coder") {
                let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                let buttonItem = SVButtonItem(coder: archiver)

                it("had to return nil.") {
                    expect(buttonItem).to(beNil())
                }
            }
        }

        describe("SVLoaderItem") {
            context("when contains text") {
                let loaderItem = SVLoaderItem(withSize: .little, andText: "Loading content")

                it("had to have 'text' property non nil.") {
                    snackViewSpy?.set(items: [loaderItem])
                    snackView?.reloadData()

                    expect(loaderItem.text).to(equal("Loading content"))
                    expect(loaderItem.size).to(equal(.little))
                }
            }

            context("when initialized without text") {
                let loaderItem = SVLoaderItem(withSize: .large, andText: nil)

                it("had to have 'text' property nil.") {
                    snackViewSpy?.set(items: [loaderItem])
                    snackView?.reloadData()

                    expect(loaderItem.size).to(equal(.large))
                }
            }

            describe("SVLoaderItem from init with coder") {
                let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                let loaderItem = SVLoaderItem(coder: archiver)

                it("had to return nil.") {
                    expect(loaderItem).to(beNil())
                }
            }
        }

        describe("SVSlider") {
            let sliderItem = SVSliderItem(withTitle: "My Slider", minimum: 10, maximum: 20, current: 13)

            it("had to have 'currentValue' property non nil.") {
                snackViewSpy?.set(items: [sliderItem])
                snackView?.reloadData()

                expect(sliderItem.currentValue).to(equal(13))
            }

            context("if currentValue is manually changed") {
                it("had to have 'currentValue' property to 18.") {
                    sliderItem.currentValue = 18
                    expect(sliderItem.currentValue).to(equal(18))
                }
            }
            
            describe("SVSliderItem from init with coder") {
                let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                let sliderItem = SVSliderItem(coder: archiver)

                it("had to return nil.") {
                    expect(sliderItem).to(beNil())
                }
            }
        }

        describe("SVSegmentedControllerItem") {
            var _selectedIndex: Int? = nil
            let segmentedItem = SVSegmentedControllerItem(withTitle: "Application theme", segments: ["Light", "Dark", "Automatic"]) { (selectedIndex) in
                _selectedIndex = selectedIndex
            }

            it("had to be titled 'Application Theme'"){

            }
            context("if no action has been made") {
                it("had to have 'selectedIndex' property ti nil.") {
                    snackViewSpy?.set(items: [segmentedItem])
                    snackView?.reloadData()

                    expect(_selectedIndex).to(beNil())
                    expect(segmentedItem.title).to(equal("Application theme"))
                }
            }


            context("if user change the selection had to change the index for selectedSegment property") {
                it("had to have 'selectedIndex' property ti nil.") {
                    snackViewSpy?.set(items: [segmentedItem])
                    snackView?.reloadData()

                    segmentedItem.selectedSegment = 2
                    expect(_selectedIndex).to(equal(2))
                    expect(segmentedItem.selectedSegment).to(equal(2))
                }
            }

            describe("SVSegmentedControllerItem from init with coder") {
                let archiver = NSKeyedArchiver(requiringSecureCoding: false)
                let segmentedItem = SVSegmentedControllerItem(coder: archiver)

                it("had to return nil.") {
                    expect(segmentedItem).to(beNil())
                }
            }
        }
    }
}

