//
//  ViewController.swift
//  SnackViewExample
//
//  Created by Kevin Morton on 1/6/19.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import SnackView
import UIKit

class ViewController: UIViewController {

    var snackView: SnackView?
    var dataSource = SnackViewDataSourceManager()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDataSource()
    }

    fileprivate func configureDataSource() {
        snackView = SnackView(with: dataSource)
    }

    // MARK: Actions

    @IBAction func showCustomItem(_ sender: Any) {
        updateItems(type: .custom)
    }

    @IBAction func showMixedItems(_ sender: Any) {
        updateItems(type: .mixed)
    }

    @IBAction func showSnackView(_ sender: Any) {
        updateItems(type: .password)
    }

    fileprivate func updateItems(type: SnackViewDataSourceManager.ExampleType) {
        dataSource.currentType = type

        snackView?.show()
    }
}

