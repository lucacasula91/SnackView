//
//  ViewController.swift
//  SnackViewExample_UIWindowScene
//
//  Created by Luca Casula on 07/10/2019.
//  Copyright © 2019 LucaCasula. All rights reserved.
//

import UIKit
import SnackView

class ViewController: UIViewController {

    // MARK: - Properties

    var snackView: SnackView?
    var dataSource = SnackViewDataSourceManager()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDataSource()
    }

    // MARK: - Fileprivate methods

    fileprivate func configureDataSource() {
        snackView = SnackView(with: dataSource)
    }

    fileprivate func updateItems(type: SnackViewDataSourceManager.ExampleType) {
        dataSource.currentType = type
        snackView?.show()
    }

    // MARK: - Actions

    @IBAction func showCustomItem(_ sender: Any) {
        updateItems(type: .custom)
    }

    @IBAction func showMixedItems(_ sender: Any) {
        updateItems(type: .mixed)
    }

    @IBAction func showSnackView(_ sender: Any) {
        updateItems(type: .password)
    }

}


