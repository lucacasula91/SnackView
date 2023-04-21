![SnackView logo](http://www.lucacasula.it/SVItems/SnackViewTitle.svg)

# SnackView
***An easy way to present customizable bottom-half alert.***
![SnackView logo](http://www.lucacasula.it/SVItems/NewSnackViewPreview.jpg)


[![Platform](https://img.shields.io/cocoapods/p/SnackView.svg?style=flat)](https://github.com/lucacasula91/SnackView/wiki)
[![Twitter](https://img.shields.io/badge/twitter-@lucacasula91-green.svg?style=flat)](http://twitter.com/lucacasula91)

[![Maintainability](https://api.codeclimate.com/v1/badges/9aeb1378d61a9f9a3fe4/maintainability)](https://codeclimate.com/github/lucacasula91/SnackView/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9aeb1378d61a9f9a3fe4/test_coverage)](https://codeclimate.com/github/lucacasula91/SnackView/test_coverage)

- [Roadmap](#roadmap)
- [What's new](#whats-new)
  - [What's new in 1.2.0](#whats-new-in-120)
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
![SnackView RoadMap](http://www.lucacasula.it/SVItems/NewSnackView_RoadMap.svg)

## What's new

### What's new in 1.2.0


## Installation

### SwiftPackageManager


### Manual installation

If you want to install SnackView manually, just drag **Sources** folder into your project.

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


