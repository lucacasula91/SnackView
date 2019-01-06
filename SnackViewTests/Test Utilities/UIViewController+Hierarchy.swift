//
//  UIViewController+Hierarchy.swift
//  SnackViewTests
//
//  Created by Kevin Morton on 1/6/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import UIKit


func topMostController() -> UIViewController? {
    var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController

    while (topController?.presentedViewController) != nil {
        topController = topController?.presentedViewController
    }

    return topController
}
