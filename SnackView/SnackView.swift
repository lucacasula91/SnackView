//
//  BottomAlertViewController.swift
//  SnackView
//
//  Created by Luca Casula on 08/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

public class SnackView: UIViewController {
    
    //MARK: - Outlets and Variables
    private var titleAlert:String!
    private var closeButtonTitle:String!
    private var cancelButtonVisible:Bool = true
    private var items:[SVItem] = []
    private var scrollView:UIScrollView! = UIScrollView()
    private var contentView:UIView! = UIView()
    private var safeAreaView:UIView! = UIView()
    private var scrollContentView:UIView! = UIView()
    private var widthScrollContentView:CGFloat = 0
    private var heightScrollViewConstant:NSLayoutConstraint = NSLayoutConstraint()
    private var bottomContentViewConstant:NSLayoutConstraint = NSLayoutConstraint()
    private var customInputAccessoryView:UIView! = UIView()
    private var mustPlayTapticFeedback:Bool = true
    
    override public var inputAccessoryView: UIView? {
        let customInput = CustomInputAccessoryView()
        customInput.frame.size.height = 0.1
        return customInput
    }
    
    
    
    //MARK: - Initialization methods
    public init(withTitleOptions titleOptions:SVTitleOptions, andItems items: [SVItem]) {
        super.init(nibName: nil, bundle: nil)
        
        customInputAccessoryView.frame.size.height = 44
        customInputAccessoryView.backgroundColor = UIColor.red
        
        
        //Set the title
        self.titleAlert = titleOptions.title
        self.closeButtonTitle = titleOptions.closeButtonTitle
        self.cancelButtonVisible = titleOptions.closeButtonVisible
        self.items = items
        
        //Set the presentation style as over current context
        self.modalPresentationStyle = .overCurrentContext
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameDidChange(notification:)), name: NSNotification.Name(rawValue:"KeyboardFrameDidChange"), object: nil)
    }
    
    public init(withTitle title:String, andCloseButtonTitle closeTitle:String, andItems items: [SVItem]) {
        super.init(nibName: nil, bundle: nil)
        
        customInputAccessoryView.frame.size.height = 44
        customInputAccessoryView.backgroundColor = UIColor.red
        
        
        //Set the title
        self.titleAlert = title
        self.closeButtonTitle = closeTitle
        self.items = items
        
        //Set the presentation style as over current context
        self.modalPresentationStyle = .overCurrentContext
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameDidChange(notification:)), name: NSNotification.Name(rawValue:"KeyboardFrameDidChange"), object: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    //MARK: - System Methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        widthScrollContentView = self.view.frame.width
        
        //Create title bar
        layoutSnackView()
        
        //Set SnackView hidden
        self.contentView.isHidden = true
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var height:CGFloat = 0
        for view in scrollContentView.subviews {
            view.layoutIfNeeded()
            height += view.frame.size.height
        }
        
        //Set ScrollView max height value
        let maxScrollViewHeight = self.view.frame.height - 68
        if height < maxScrollViewHeight {
            heightScrollViewConstant.constant = height
        } else {
            heightScrollViewConstant.constant = maxScrollViewHeight
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
    
    public func removeItemAtIndex(index:Int) {
        self.items.remove(at: index)
        self.addItemsToContentScrollView()
    }
    
    
    //MARK: - Private Methods
    private func getTitleBar() -> SVTitleItem {
        let titleTab = SVTitleItem(withTitle: self.titleAlert, andCancelButton: self.closeButtonTitle)
        titleTab.translatesAutoresizingMaskIntoConstraints = false
        titleTab.cancelButton.addTarget(self, action: #selector(closeActionSelector), for: UIControlEvents.touchUpInside)
        
        //Check if close button must be visible or hidden
        titleTab.cancelButton.isHidden = self.cancelButtonVisible ? false : true
        return titleTab
    }
    
    /** This method creates a view that contains all the SnackView items */
    private func layoutSnackView() {
        self.view.subviews.forEach{ $0.removeFromSuperview() }
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        self.view.addSubview(contentView)
        
        
        if #available(iOS 11.0, *) {
            contentView.topAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        } else {
            contentView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 0).isActive = true
        }
        contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        bottomContentViewConstant = NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(bottomContentViewConstant)
        
        
        //Add Visual Effect
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = contentView.bounds
        visualEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addSubview(visualEffectView)
        
        
        //Title Bar View
        let title = getTitleBar()
        contentView.addSubview(title)
        
        //Scroll Content View
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = false
        scrollView.backgroundColor = UIColor.clear
        contentView.addSubview(scrollView)
        
        //Safe Area View
        safeAreaView = UIView()
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.backgroundColor = UIColor.clear
        contentView.addSubview(safeAreaView)
        
        
        //Add vertical constraints
        let verticalContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[title(44)][scrollView]-|", options: [], metrics: nil, views: ["title":title, "scrollView":scrollView])
        contentView.addConstraints(verticalContraints)
        
        safeAreaView.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        safeAreaView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        //Add horizontal constraints
        let items = [title, scrollView, safeAreaView] as [Any]
        for item in items {
            let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: [], metrics: nil, views: ["item":item])
            contentView.addConstraints(horizontalConstraint)
        }
        
        //Add ScrollView content view
        scrollContentView = UIView()
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scrollContentView)
        
        //Add ScrollView Constraints
        let contentViewHConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView(==scrollView)]|", options: [], metrics: nil, views: ["contentView":scrollContentView, "scrollView":scrollView])
        scrollView.addConstraints(contentViewHConstraint)
        
        let contentViewVConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: ["contentView":scrollContentView])
        scrollView.addConstraints(contentViewVConstraint)
        
        self.addItemsToContentScrollView()
    }
    
    private func addItemsToContentScrollView() {
        scrollContentView.subviews.forEach{ $0.removeFromSuperview() }
        
        //Add BottomAlertItems to ScrollView
        for item in self.items {
            item.translatesAutoresizingMaskIntoConstraints = false
            scrollContentView.addSubview(item)
        }
        
        //Add BottomAlertItems Vertical Constraints
        var verticalConstraintString = "V:|"
        var verticalConstraintDictionary:[String:UIView] = [:]
        
        for (index, item) in scrollContentView.subviews.enumerated() {
            verticalConstraintString += "[item_\(index)]"
            verticalConstraintDictionary["item_\(index)"] = item
        }
        
        
        verticalConstraintString += "|"
        
        let scrollViewVerticalContraints = NSLayoutConstraint.constraints(withVisualFormat: verticalConstraintString, options: [], metrics: nil, views: verticalConstraintDictionary)
        scrollContentView.addConstraints(scrollViewVerticalContraints)
        
        //Add BottomAlertItems Horizontal Constraints
        var heightValue:CGFloat = 0
        for item in scrollContentView.subviews {
            item.translatesAutoresizingMaskIntoConstraints = false
            
            let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[item]|", options: [], metrics: nil, views: ["item":item])
            scrollContentView.addConstraints(horizontalConstraint)
            
            //Set layout to calculate item height size
            item.layoutIfNeeded()
            heightValue += item.frame.size.height
        }
        
        //Set ScrollView content size
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: heightValue)
        
        
        //Set ScrollView height constraint
        scrollView.removeConstraint(heightScrollViewConstant)
        heightScrollViewConstant = NSLayoutConstraint(item: scrollView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: heightValue)
        scrollView.addConstraint(heightScrollViewConstant)
        self.contentView.layoutIfNeeded()
    }
    
   
    //MARK: - Keyboard stuff
    @objc func keyboardWillShow(notification:Notification) {
        scrollView.alwaysBounceVertical = true

        let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        bottomContentViewConstant.constant = -keyboardSize.height
        UIView.animate(withDuration: notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification:Notification) {
        scrollView.alwaysBounceVertical = false

        bottomContentViewConstant.constant = 0
        UIView.animate(withDuration: notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardFrameDidChange(notification:Notification) {
        if let constant = notification.userInfo?["constant"] as? CGFloat{
            bottomContentViewConstant.constant = -constant
            print(scrollView.contentOffset.y)
            scrollView.contentOffset = CGPoint.zero
        }
    }

    
    //MARK: - Custom Actions
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
