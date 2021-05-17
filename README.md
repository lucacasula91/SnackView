![SnackView logo](http://www.lucacasula.it/SVItems/SnackViewTitle.svg)

# SnackView
***An easy way to present customizable bottom-half alert.***
![SnackView logo](http://www.lucacasula.it/SVItems/NewSnackViewPreview.jpg)


[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SnackView.svg)](https://img.shields.io/cocoapods/v/SnackView.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/SnackView.svg?style=flat)](https://github.com/lucacasula91/SnackView/wiki)
![License](https://img.shields.io/cocoapods/l/SnackView.svg?style=flat)
[![Twitter](https://img.shields.io/badge/twitter-@lucacasula91-green.svg?style=flat)](http://twitter.com/lucacasula91)

[![Maintainability](https://api.codeclimate.com/v1/badges/9aeb1378d61a9f9a3fe4/maintainability)](https://codeclimate.com/github/lucacasula91/SnackView/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9aeb1378d61a9f9a3fe4/test_coverage)](https://codeclimate.com/github/lucacasula91/SnackView/test_coverage)

- [Roadmap](#roadmap)
- [What's new](#whats-new)
  - [What's new in 1.1.0](#whats-new-in-110)
	- [What's new in 1.0.9](#whats-new-in-101)
- [Installation](#installation)
	- [CocoaPods](#cocoapods)
	- [Carthage](#carthage)
	- [Manual installation](#manual-installation)
- [Usage](#usage)
	- [Create your custom SnackView alert](#create-your-custom-snackview-alert)
- [SVItems included](#svitems-included)
- [Create custom SVItems](#create-custom-svitems)
- [Contributing](#contributing)

## Roadmap
![SnackView RoadMap](http://www.lucacasula.it/SVItems/SnackView_RoadMap.svg)

## What's new

### What's new in 1.1.0
- Added support for Dark mode.
- Added item SVSliderItem.
- Removed deprecated methods and files. 


### What's new in 1.0.9
- New SnackViewDataSource protocol with which create your SnackView.
- New SVImageViewItem class with which display images.
- Compatible with the new UIWindowSceneDelegate system. 


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SnackView in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.0.1+ is required to build SnackView 1+ (along with Swift 3 and Xcode 9).

#### Podfile

- **Swift 3.x**: >= 1.0.1 [Download here](https://github.com/lucacasula91/SnackView/releases/tag/1.0.2).
To integrate SnackView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!
pod 'SnackView', '~> 1.1.0'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate SnackView into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "lucacasula91/SnackView"
```


### Manual installation

If you want to install SnackView manually, just drag **SnackView Library** folder into your project.

## Usage

### Create your custom SnackView alert
SnackView includes some default UI elements as Button, Label and other complex UI.
The first step is to create an array of SVItem. SVItem is the class of every element that SnackView can include within it.

Here an example of simple SnackView alert:

```swift
class MyCustomClass: UIViewController {

    override func viewDidLoad() {  }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Present the SnackView
        let dataSource = self
        SnackView(with: dataSource).show()
    }
}

// MARK: - SnackViewDataSource Section
extension MyCustomClass: SnackViewDataSource {

    func titleFor(snackView: SnackView) -> String {
        return "What's New"
    }

    func cancelTitleFor(snackView: SnackView) -> String? {
        return "Dismiss"
    }

    func itemsFor(snackView: SnackView) -> [SVItem] {
        let descriptionItem = SVDescriptionItem(withDescription: "In this last release of SnackView we...")
        let imageItem = SVImageViewItem(withImage: UIImage(named: "hat_is_new")!,
                                        andContentMode: .scaleAspectFill)

        return [descriptionItem, imageItem]
    }
}

```



------

## Deprecated methods

With SnackView 1.0.9 the current method are now deprecated:



- init(withTitleOptions: andItems:)
- init(withTitle: andCloseButtonTitle: andItems:)

**SnackViewDataSource** contains all you need to handle title, cancel button title and items to display. For more info please see the SnackViewDataSource protocol documentation code.



- func insert(item: atIndex:)
- func remove(item:)
- func removeItemAt(index:)
- func updateWith(items:)

Please start using the new **SnackViewDataSource** instead, all the above operations can be performed simply by changing the return content in the `func itemsFor(snackView:)` method of SnackViewDataSource and call the `reloadData()` function to perform an update.

***

## SVItems included
SnackView provides some SVItems ready to use, here below the list of SVItems available:

**SVApplicationItem**

```swift
SVApplicationItem(withIcon: UIImage(named: "AppIcon"),
                 withTitle: "Ipsum lorem", 
            andDescription: "Lorem ipsum dolor sit amet...")
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVApplicationItem.svg)

***

**SVDescriptionItem**

```swift
SVDescriptionItem(withDescription: "Lorem ipsum dolor sit amet...")
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVDescriptionItem.svg)

***

**SVTextFieldItem**

```swift
SVTextFieldItem(withPlaceholder: "Create Password", 
                  isSecureField: true)
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVTextFieldItem.svg)

***

**SVDetailTextItem**

```swift
SVDetailTextItem(withTitle: "Elit amet", 
                andContent: "Lorem ipsum dolor sit amet...")
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVDetailTextItem.svg)

***

**SVButtonItem**

```swift
SVButtonItem(withTitle: "Continue") { /* Button action here */ }
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVButtonItem.svg)

***

**SVSwitchItem**

```swift
SVSwitchItem(withTitle: "Push Notifications", 
            andContent: "Activate to stay up to date...") { (isOn) in  /* Switch action here */ }
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVSwitchItem.svg)

***

**SVLoaderItem**

```swift
SVLoadingItem(withSize: .large, 
               andText: "Lorem ipsum dolor sit amet...")
```

![SnackView alert Item](http://www.lucacasula.it/SVItems/SVLoaderDescriptionItem.svg)

***

**SVImaveViewItem**

```swift
SVImageViewItem(with: UIImage(named: "hat_is_new")!,
                              andContentMode: .scaleAspectFill)
```

![SnackView alert Item](http://www.lucacasula.it/SVItems/SVImageViewItem.svg)

***


# Create custom SVItems
#### You can create custom items subclassing SVItem class. 
Here below an example. 
```swift
import UIKit
import SnackView

//Create a subclass of SVItem
class SVCustomItem: SVItem {
    
    //Pass all parameters in init method to customize your SVItem
    init(withColor color: UIColor) {
        super.init()
        
        //Add an UIView
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = color
        self.addSubview(customView)
       
        //Add UIView contraints
         let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[customView(70)]-|", options: [], metrics: nil, views: ["customView":customView])
        
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[customView]-|", options: [], metrics: nil, views: ["customView": customView])
        
        self.addConstraints(vConstraints + hConstraints)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
}
```

![Custom SVItem](http://www.lucacasula.it/SVItems/SnackViewCustomSVItem.jpg)

***

## Contributing
If you want to contribute to make SnackView a better framework, **submit a pull request**.

Please consider to **open an issue** for the following reasons:
* If you have questions or if you need help using SnackView
* If you found a bug
* If you have some feature request


