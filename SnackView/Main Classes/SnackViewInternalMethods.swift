//
//  SnackViewExtension.swift
//  SnackView
//
//  Created by Luca Casula on 27/12/18.
//  Copyright © 2018 LucaCasula. All rights reserved.
//
import UIKit

extension SnackView {

    // MARK: - SnackView Setup

    /// Prepare SnackView for will appear state, set background color to clear and translate view off screen.
    internal func setBackgroundForWillAppear() {
        DispatchQueue.main.async {
            // Set SnackView visible
            self.skeletonView.isHidden = false
            self.view.backgroundColor = UIColor.clear

            // Hide the SnackView out the screen bounds and set visible
            let contentViewHeight = self.skeletonView.frame.size.height + self.skeletonView.getSafeAreaHeight()
            self.skeletonView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)
        }
    }

    /// Animate the SnackView presentation, set a background color with alpha 0.5 and then translate SnackView to original position.
    internal func showSnackViewWithAnimation() {

        func animateBackgroundColor() {
            let backgroundColor: UIColor = UIColor.black
            UIView.animate(withDuration: 0.25, animations: {
                self.view.backgroundColor = backgroundColor.withAlphaComponent(0.4)
            }) { (_) in
                showSnackViewAnimation()
            }
        }

        func showSnackViewAnimation() {
            UIView.animate(withDuration: 0.25, animations: {
                self.skeletonView.transform = CGAffineTransform.identity
            })
        }

        DispatchQueue.main.async { animateBackgroundColor() }
    }

    // MARK: - SnackView skeleton

    /// ContentView is a view that contains all the items of SnackView such as TitleBar, ScrollView with all the items inside and the safeArea view.
    internal func addContentViewWithConstraints() {
        self.skeletonView = SVSkeletonView()
        self.skeletonView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(skeletonView)

        /// Default top constraint anchor
        var topConstraint = self.view.topAnchor

        // Use safe area layout guide if possible
        if #available(iOS 11.0, *) {
            topConstraint = self.view.safeAreaLayoutGuide.topAnchor
        }

        self.skeletonView.topAnchor.constraint(greaterThanOrEqualTo: topConstraint, constant: 0).isActive = true
        self.skeletonView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.skeletonView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

        self.bottomContentViewConstant = self.skeletonView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.view.addConstraint(bottomContentViewConstant)
    }

    internal func getDataFromDataSource() {
        var title: String = ""
        if let _title = self.dataSource?.titleFor(snackView: self) { title = _title }
        let cancelTitle = self.dataSource?.cancelTitleFor(snackView: self)
        self.skeletonView.setTitle(title, andCancelTitle: cancelTitle)

        self.reloadData()
    }

    internal func checkIfItemArrayIsEmpty(_ items: [SVItem]) -> [SVItem] {
        if items.isEmpty {
            self.skeletonView.setTitle("Invalid configuration", andCancelTitle: "Close")

            let description = SVDescriptionItem(withDescription: "It seems thet SnackView isn't properly configured.\nHere's what could have gone wrong.")
            let firstCause = SVDetailTextItem(withTitle: "Empty items array", andDescription: "Maybe you are trying to show an empty items array.")
            let secondCause = SVDetailTextItem(withTitle: "DataSource with weak reference", andDescription: "If you have a standalone datasource class, you need to keep the reference from the UIViewController that want to present the SnackView.")

            return [description, firstCause, secondCause]
        }
        return items
    }

    // MARK: - Helper methods

    /// This method creates a UIViewController which is the root view controller of UIWindow.
    ///
    /// - Returns: UIViewController to use to present the SnackView
    internal func getPresenterViewController() -> UIViewController {
        let containerViewController = UIViewController()
        containerViewController.title = "SnackView Container"
        containerViewController.modalPresentationStyle = .overFullScreen
        containerViewController.view.backgroundColor = UIColor.clear
        containerViewController.view.isUserInteractionEnabled = true
        self.setupWindow(for: containerViewController)

        return containerViewController
    }

    internal func setupWindow(for viewController: UIViewController) {
        window = nil
        window = UIWindow(frame: UIScreen.main.bounds)

        if #available(iOS 13.0, *),
           let scene = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).first as? UIWindowScene {
            self.window = UIWindow(windowScene: scene)
        }

        window?.rootViewController = viewController
        window?.backgroundColor = UIColor.clear
        window?.windowLevel = UIWindow.Level.alert+1
        window?.makeKeyAndVisible()
        window?.resignFirstResponder()
    }
    // MARK: - Private custom selector

    /// Animate the SnackView dismiss, translate SnackView off screen and set background color to clear.
    @objc internal func closeActionSelector() {
        DispatchQueue.main.async {
            // Hide the SnackView out the screen bounds and set visible
            self.animateContentView()
        }
    }

    internal func dismissAndClean() {
        self.dismiss(animated: false) {
            self.window?.rootViewController = nil
            self.window?.resignFirstResponder()
            self.window?.removeFromSuperview()
            self.window = nil
        }
    }

    internal func animateBackgroundColor() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = UIColor.clear
        }) { (_) in self.dismissAndClean() }
    }

    internal func animateContentView() {
        let contentViewHeight = self.skeletonView.frame.size.height + self.skeletonView.getSafeAreaHeight()

        // Background Color Animation
        UIView.animate(withDuration: 0.25, animations: {
            self.skeletonView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)
        }) { (_) in self.animateBackgroundColor() }
    }
}
