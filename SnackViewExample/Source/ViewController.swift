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

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDataSource()
    }

    fileprivate func configureDataSource() {
        let dataSource = SnackViewDataSource()
        snackView = SnackView(with: dataSource)
    }

    // MARK: Actions

    @IBAction func showCustomItem(_ sender: Any) {
        var dataSource = SnackViewDataSource()
        dataSource.itemType = .custom

        SnackView(with: dataSource).show()
    }

    @IBAction func showMixedItems(_ sender: Any) {
        var dataSource = SnackViewDataSource()
        dataSource.itemType = .mixed

        SnackView(with: dataSource).show()
    }

    @IBAction func showSnackView(_ sender: Any) {
        snackView?.show()
    }
}

