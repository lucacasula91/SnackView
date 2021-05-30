//
//  NewSnackViewDataSource.swift
//  
//
//  Created by Luca Casula on 14/01/19.
//

import UIKit
import SnackView

class SnackViewDataSourceManager {

    // MARK: - Properties
    var currentType: ExampleType = .password

    enum ExampleType {
        case password
        case custom
        case mixed
    }

    // MARK: - Fileprivate methods
    fileprivate func getItems(for type: ExampleType) -> [SVItem] {
        switch type {
        case .password:     return self.getPasswordItem()
        case .custom:       return self.getCustomItem()
        case .mixed:        return self.getMixedItems()
        }
    }

    fileprivate func getPasswordItem() -> [SVItem] {
        let sliderItem = SVSliderItem(withTitle: "My Slider", minimum: 10, maximum: 60, current: 23)
        let newPasswordItem = SVTextFieldItem(withPlaceholder: "New Password", isSecureField: true)
        let repeatPasswordItem = SVTextFieldItem(withPlaceholder: "Repeat Password", isSecureField: true)
        let continueButtonItem = SVButtonItem(withTitle: "Continue") { print("Continue button tapped") }

        return [sliderItem, newPasswordItem, repeatPasswordItem, continueButtonItem]
    }

    fileprivate func getCustomItem() -> [SVItem] {
        let greenCustomItem = SVCustomItem(with: .green)
        let grayCustomItem = SVCustomItem(with: .gray)

        return [greenCustomItem, grayCustomItem]
    }

    fileprivate func getMixedItems() -> [SVItem] {
        let loaderItem = SVLoaderItem(withSize: .large, andText: "Lorem ipsum dolor sit amet.")
        let switchItem = SVSwitchItem(withTitle: "Push Notifications",
                                      andDescription: "Activate to stay up to date...",
                                      withState: false) { isOn in
                                        print("switch toggled: \(isOn)") }
        let applicationItem = SVApplicationItem(withIcon: #imageLiteral(resourceName: "Icon"),
                                                withTitle: "Ipsum lorem",
                                                andDescription: "Lorem ipsum dolor sit amet")
        let sliderItem = SVSliderItem(withTitle: "My Slider", minimum: 0, maximum: 100, current: 23)
        return [loaderItem, switchItem, applicationItem, sliderItem]
    }

}

// MARK: - SnackViewDataSource
extension SnackViewDataSourceManager: SnackViewDataSource {

    func titleFor(snackView: SnackView) -> String {
        switch currentType {
        case .password:     return "Create Password"
        case .custom:       return "Custom item"
        case .mixed:        return "Mixed items"
        }
    }

    func cancelTitleFor(snackView: SnackView) -> String? {
        return "Close"
    }

    func itemsFor(snackView: SnackView) -> [SVItem] {
        let items = self.getItems(for: currentType)
        return items
    }
}
