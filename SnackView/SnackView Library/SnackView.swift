//
//  SnackView.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

public class SnackView: UIViewController {
    
    //MARK: - Outlets and Variables
    private var titleOptions: SVTitleOptions!
    private var items: [SVItem] = []
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var safeAreaView: UIView = UIView()
    private var scrollContentView: UIView = UIView()
    private var widthScrollContentView: CGFloat = 0
    private var heightScrollViewConstant: NSLayoutConstraint = NSLayoutConstraint()
    private var bottomContentViewConstant: NSLayoutConstraint = NSLayoutConstraint()
    private var customInputAccessoryView: UIView = UIView()
    private var keyboardHeight: CGFloat = 0
    override public var inputAccessoryView: UIView? {
        let customInput = CustomInputAccessoryView()
        customInput.frame.size.height = 0.1
        return customInput
    }
    
    
    
    //MARK: - Initialization methods
    public init(withTitleOptions titleOptions:SVTitleOptions, andItems items: [SVItem]) {
    super.init(nibName: nil, bundle: nil)
    
    //Set the title
    self.titleOptions = titleOptions
    self.items = items
    }
    
    public init(withTitle title:String, andCloseButtonTitle closeTitle:String, andItems items: [SVItem]) {
        super.init(nibName: nil, bundle: nil)
        
        //Set the title
        self.titleOptions = SVTitleOptions(withTitle: title, setCloseButtonVisible: true, setCloseButtonTitle: closeTitle)
        self.items = items
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - System Methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //Add custom input accessory view to handle keyboard dismiss interactively
        self.customInputAccessoryView.frame.size.height = 44
        self.customInputAccessoryView.backgroundColor = UIColor.red
        
        //Set the presentation style as over current context
        self.modalPresentationStyle = .overCurrentContext
        
        //Handle rotation screen notification
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        //Create the SnackView skeleton view
        self.layoutSnackViewSkeleton()
        
        //Register SnackView for keyboard and rotation notifications
        self.addNotificationsObserver()
        
        //Set SnackView hidden
        self.contentView.isHidden = true
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set background color to clear color
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.clear
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            //Hide the SnackView out the screen bounds and set visible
            let contentViewHeight = self.contentView.frame.size.height + self.safeAreaView.frame.height
            self.contentView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)
            self.contentView.isHidden = false
            
            //Background Color Animation
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                
            }) { (completed) in
                //Show SnackView Animation
                UIView.animate(withDuration: 0.2, animations: {
                    self.contentView.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    
    //MARK: - Public Methods
    public func show() {
        
        let containerViewController = UIViewController()
        containerViewController.view.backgroundColor = UIColor.clear
        containerViewController.view.isUserInteractionEnabled = true
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = containerViewController
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindowLevelAlert+1
        window.makeKeyAndVisible()
        window.resignFirstResponder()
        
        containerViewController.present(self, animated: false, completion: nil)
    }
    
    public func close() {
        self.closeActionSelector()
    }
    
    public func insertItem(item:SVItem, atIndex index:Int?) {
        if let aIndex = index {
            self.items.insert(item, at: aIndex)
        } else {
            self.items.append(item)
        }
        self.addItemsToContentScrollView()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) { [weak self] in
            guard let width = self?.scrollView.frame.width, let height = self?.scrollView.frame.height else { return }
            
            self?.scrollView.scrollRectToVisible(CGRect(x: 0, y: height, width: width, height: height), animated: true)
        }
    }
    
    public func removeItem(item:SVItem) {
        for (index, tmpItem) in self.items.enumerated() {
            if tmpItem == item {
                self.removeItemAtIndex(index: index)
                break
            }
        }
    }
    
    public func removeItemAtIndex(index:Int)  {
        self.items.remove(at: index)
        self.addItemsToContentScrollView()
    }
    
    public func update(withItems items: [SVItem]) {
        self.items = items
        self.addItemsToContentScrollView()
    }
    
    
    //MARK: - Private Methods
    
    /** This method add notification observer for keyboard and rotation events */
    private func addNotificationsObserver() {
        
        //Keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameDidChange(notification:)), name: NSNotification.Name(rawValue:"KeyboardFrameDidChange"), object: nil)
        
        //Rotation notification
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidRotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    /** This method creates a view that contains all the SnackView items */
    private func layoutSnackViewSkeleton() {
        self.view.subviews.forEach{ $0.removeFromSuperview() }
        
        self.contentView = UIView()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        self.view.addSubview(contentView)
        
        //Use safe area layout guide if possible
        if #available(iOS 11.0, *) {
            self.contentView.topAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        } else {
            self.contentView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 0).isActive = true
        }
        self.contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.bottomContentViewConstant = self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.view.addConstraint(bottomContentViewConstant)
        
        
        //Add Visual Effect
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = contentView.bounds
        visualEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.contentView.addSubview(visualEffectView)
        
        
        //Title Bar View
        let title = SVTitleItem(withTitle: self.titleOptions.title, andCancelButton: self.titleOptions.closeButtonTitle)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.cancelButton.addTarget(self, action: #selector(closeActionSelector), for: UIControlEvents.touchUpInside)
        
        //Check if close button must be visible or hidden
        title.cancelButton.isHidden = self.titleOptions.closeButtonVisible ? false : true
        self.contentView.addSubview(title)
        
        //Scroll Content View
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.keyboardDismissMode = .interactive
        self.scrollView.bounces = true
        self.scrollView.alwaysBounceVertical = false
        self.scrollView.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.scrollView)
        
        //Safe Area View
        self.safeAreaView = UIView()
        self.safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        self.safeAreaView.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.safeAreaView)
        
        
        //Add vertical constraints
        let verticalContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[title(44)][scrollView]-|", options: [], metrics: nil, views: ["title":title, "scrollView":scrollView])
        self.contentView.addConstraints(verticalContraints)
        
        self.safeAreaView.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        self.safeAreaView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        //Add horizontal constraints
        let items = [title, self.scrollView, self.safeAreaView] as [Any]
        for item in items {
            let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: [], metrics: nil, views: ["item":item])
            self.contentView.addConstraints(horizontalConstraint)
        }
        
        //Add ScrollView content view
        self.scrollContentView = UIView()
        self.scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.scrollContentView)
        
        //Add ScrollView Constraints
        let contentViewHConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView(==scrollView)]|", options: [], metrics: nil, views: ["contentView":self.scrollContentView, "scrollView":self.scrollView])
        scrollView.addConstraints(contentViewHConstraint)
        
        let contentViewVConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: ["contentView":self.scrollContentView, "scrollView":self.scrollView])
        scrollView.addConstraints(contentViewVConstraint)
        
        self.addItemsToContentScrollView()
    }
    
    /** This method add all SVItems to scrollView content view */
    private func addItemsToContentScrollView() {
        self.scrollContentView.subviews.forEach{ $0.removeFromSuperview() }
        
        //Make sure self.items is not empty
        if self.items.isEmpty {
            let info = SVDescriptionItem(withDescription: "SnackView needs a non empty SVItem array to work properly.")
            self.items = [info]
        }
        
        //Add BottomAlertItems to ScrollView
        for item in self.items {
            item.translatesAutoresizingMaskIntoConstraints = false
            self.scrollContentView.addSubview(item)
        }
        
        //Add BottomAlertItems Vertical Constraints
        var verticalConstraintString = "V:|"
        var verticalConstraintDictionary:[String:UIView] = [:]
        
        for (index, item) in self.scrollContentView.subviews.enumerated() {
            verticalConstraintString += "[item_\(index)]"
            verticalConstraintDictionary["item_\(index)"] = item
        }
        
        verticalConstraintString += "|"
        
        let scrollViewVerticalContraints = NSLayoutConstraint.constraints(withVisualFormat: verticalConstraintString, options: [], metrics: nil, views: verticalConstraintDictionary)
        self.scrollContentView.addConstraints(scrollViewVerticalContraints)
        
        //Add BottomAlertItems Horizontal Constraints
        var heightValue:CGFloat = 0
        for item in self.scrollContentView.subviews {
            item.translatesAutoresizingMaskIntoConstraints = false
            
            let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: [], metrics: nil, views: ["item":item])
            self.scrollContentView.addConstraints(horizontalConstraint)
            
            //Set layout to calculate item height size
            item.layoutIfNeeded()
            heightValue += item.frame.size.height
        }
        
        //Set ScrollView content size
        self.scrollView.contentSize = CGSize(width: scrollView.frame.width, height: heightValue)
        
        //Set ScrollView height constraint
        self.scrollView.removeConstraint(self.heightScrollViewConstant)
        
        let maxHeight = self.getScrollViewMaxHeight()
        
        self.heightScrollViewConstant = self.scrollView.heightAnchor.constraint(equalToConstant: heightValue > maxHeight ? maxHeight : heightValue)
        self.scrollView.addConstraint(heightScrollViewConstant)
        self.heightScrollViewConstant.isActive = true
        
        self.contentView.layoutIfNeeded()
    }
    
    /** This method return the max height of UIScrollView  */
    private func getScrollViewMaxHeight() -> CGFloat {
        let statusBarHeight = SafeAreaHelper().getTopSafeAreaHeight()
        let titleBarHeight: CGFloat = 44
        let safeAreaBottomHeight = SafeAreaHelper().getBottomSafeAreaHeight()
        
        return UIScreen.main.bounds.height - statusBarHeight - titleBarHeight - safeAreaBottomHeight
    }
    
    /** This method calculate the height of SnackView according orientation and keyboard height */
    fileprivate func calculateScrollViewHeight(withKeyboardHeight kbHeight: CGFloat?) {
        var height:CGFloat = 0
        for view in scrollContentView.subviews {
            view.layoutIfNeeded()
            height += view.frame.size.height
        }
        
        //Set ScrollView max height value
        let maxScrollViewHeight = self.getScrollViewMaxHeight() - (kbHeight ?? 0)
        
        if height < maxScrollViewHeight {
            heightScrollViewConstant.constant = height
        } else {
            heightScrollViewConstant.constant = maxScrollViewHeight
        }
    }
    
    
    
    //MARK: - Notifications handler
    @objc func keyboardWillShow(notification:Notification) {
        scrollView.alwaysBounceVertical = true
        
        guard
            let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationSpeed = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
            else { return }
        
        self.keyboardHeight = keyboardSize.height
        self.calculateScrollViewHeight(withKeyboardHeight: self.keyboardHeight)
        bottomContentViewConstant.constant = -self.keyboardHeight
        
        UIView.animate(withDuration: animationSpeed.doubleValue) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification:Notification) {
        scrollView.alwaysBounceVertical = false
        
        guard
            let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationSpeed = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
            else { return }
        
        self.keyboardHeight = keyboardSize.height
        self.calculateScrollViewHeight(withKeyboardHeight: self.keyboardHeight)
        self.bottomContentViewConstant.constant = 0
        
        UIView.animate(withDuration: animationSpeed.doubleValue) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardFrameDidChange(notification:Notification) {
        if let constant = notification.userInfo?["constant"] as? CGFloat{
            bottomContentViewConstant.constant = -constant
        }
    }
    
    @objc func deviceDidRotate() {
        //Recalculate SnackView height
        self.calculateScrollViewHeight(withKeyboardHeight: self.keyboardHeight)
    }
    
    //MARK: - Private Custom Actions
    @objc private func closeActionSelector() {
        
        DispatchQueue.main.async {
            //Hide the SnackView out the screen bounds and set visible
            let contentViewHeight = self.contentView.frame.size.height + self.safeAreaView.frame.height
            
            //Background Color Animation
            UIView.animate(withDuration: 0.3, animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: contentViewHeight)
            }) { (completed) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.backgroundColor = UIColor.clear
                }) { (completed) in
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
}
