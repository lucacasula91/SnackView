//
//  SnackViewDataSource.swift
//  SnackViewExample
//
//  Created by Kevin Morton on 1/6/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import Foundation
import SnackView

struct SnackViewDataSource: SnackViewProtocol {
    
    enum SVType {
        case password
        case custom
        case mixed
    }
    
    var itemType: SVType = .password
    
    var title: String {
        switch itemType {
        case .password:
            return "Create Password"
        case .custom:
            return "Custom item"
        case .mixed:
            return "Mixed SVItems"
        }
    }
    
    var items: [SVItem] {
        switch itemType {
        case .password:
            return passwordItems
        case .custom:
            return [SVCustomItem(with: .green)]
        case .mixed:
            return mixedItems
        }
    }
    
    func show() {}
    func close() {}
}

extension SnackViewDataSource {
    
    var passwordItems: [SVItem] {
        let newPassword = SVTextFieldItem(withPlaceholder: "New Password", isSecureField: true)
        let repeatPassword = SVTextFieldItem(withPlaceholder: "Repeat Password", isSecureField: true)
        let continueButton = SVButtonItem(withTitle: "Continue") {
            print("Continue button tapped")
        }
        
        return [newPassword, repeatPassword, continueButton]
    }
    
    var mixedItems: [SVItem] {
        return [SVLoaderItem(withSize: .large, andText: "Lorem ipsum dolor sit amet..."),
                SVSwitchItem(withTitle: "Push Notifications", andDescription: "Activate to stay up to date...") { _ in
                    print("switch toggled") },
                SVApplicationItem(withIcon: #imageLiteral(resourceName: "Icon"),
                                  withTitle: "Ipsum lorem",
                                  andDescription: "Lorem ipsum dolor sit amet..."),
                SVButtonItem(withTitle: "Continue") { print("Button tapped") }]
    }
}
