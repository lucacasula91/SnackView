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
    public func show() {
        self.modalPresentationStyle = .overFullScreen
        
        let presenter = self.getPresenterViewController()
        presenter.present(self, animated: false, completion: nil)
    }

    /// Dismiss SnackView with custom animation.
    public func close() {
        self.closeActionSelector()
    }

    /// Reload the content of SnackView in case of update.
    public func reloadData() {
        if let _items = self.dataSource?.itemsFor(snackView: self) {
            let checkedItems = checkIfItemArrayIsEmpty(_items)
            self.items = checkedItems
            self.skeletonView.reload(with: checkedItems)
        }

    }


}
