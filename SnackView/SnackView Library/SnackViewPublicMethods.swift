//
//  SnackViewPublicMethods.swift
//  SnackView
//
//  Created by Luca Casula on 28/12/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//

extension SnackView {

    // MARK: - Presentation and Dismission methods

    /// Present SnackView with custom animation.
    open func show() {
        
        self.modalPresentationStyle = .overFullScreen
        
        let presenter = self.getPresenterViewController()
        presenter.present(self, animated: false, completion: nil)
    }

    /// Dismiss SnackView with custom animation.
    open func close() {
        self.closeActionSelector()
    }

    /// Reload the content of SnackView in case of update.
    open func reloadData() {
        if let items = self.dataSource?.itemsFor(snackView: self) {
            self.items = items
            self.skeletonView.reload(with: items)
        }
    }

}
