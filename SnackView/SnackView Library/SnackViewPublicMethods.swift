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
        self.addItemsInsideStackView()
    }

    // MARK: - SVItem management methods

    /// Insert a new SVItem to SnackView view controller. You can specify the index in which to insert SVItem, if it is passed **nil** SVItem is added with endIndex value.
    ///
    /// - Parameters:
    ///   - item: The SVItem to add to SnackView
    ///   - index: The index in which insert the new SVItem
    @available(*, deprecated, message: "This method will be removed later.")
    open func insert(item: SVItem, atIndex index: Int?) {
        if let unwrappedIndex = index {
            self.items?.insert(item , at: unwrappedIndex)
        } else {
            self.items?.append(item)
        }

        item.isHidden = true

        let itemIndex = index ?? stackView.arrangedSubviews.endIndex
        self.stackView.insertArrangedSubview(item, at: itemIndex)

        UIView.animate(withDuration: self.animationSpeed, animations: {
            item.isHidden = false
        }) { (_) in
            self.scrollView.scrollRectToVisible(item.frame, animated: true)
        }
        
        self.checkSnackViewContainsItemsOrAddDescriptionItem()
    }

    /// Remove a SVItem from SnackView view controller.
    ///
    /// - Parameter item: The SVItem to remove from SnackView
    @available(*, deprecated, message: "This method will be removed later.")
    open func remove(item: SVItem) {
        UIView.animate(withDuration: self.animationSpeed, animations: {
            item.isHidden = true
        }) { (_) in
            self.stackView.removeArrangedSubview(item)

            if let items = self.stackView.arrangedSubviews as? [SVItem] {
                self.items = items
            }

            self.checkSnackViewContainsItemsOrAddDescriptionItem()
        }
    }

    /// Remove a SVItem from SnackView view controller according a specific index.
    ///
    /// - Parameter index: The row index where remove SVItem
    @available(*, deprecated, message: "This method will be removed later.")
    open func removeItemAt(index: Int) {
        guard index < self.stackView.arrangedSubviews.count else {
            NSLog("SnackView: Cannot remove item at index \(index). Index out of range.")
            return
        }
        if let item = self.stackView.arrangedSubviews[index] as? SVItem {
            self.remove(item: item)
        }
    }

    /// Replace all the content present in SnackView with a new one SVItem array
    ///
    /// - Parameter items: Array of SVItem with which to replace items already present in SnackView
    @available(*, deprecated, message: "This method will be removed later.")
    open func updateWith(items: [SVItem]) {
        let oldItems = self.stackView.arrangedSubviews

        let newItems = items
        newItems.forEach { $0.isHidden = true}
        newItems.forEach { self.stackView.addArrangedSubview($0)}
        
        UIView.animate(withDuration: self.animationSpeed, animations: {
            newItems.forEach {$0.isHidden = false}
            oldItems.forEach {$0.isHidden = true}
        }) { (_) in
            self.items = items

            self.checkSnackViewContainsItemsOrAddDescriptionItem()
        }
    }

}
