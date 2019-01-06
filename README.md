![SnackView logo](http://www.lucacasula.it/SVItems/SnackViewTitle.svg)

# SnackView
***An easy way to present customizable bottom-half alert.***
![SnackView logo](http://www.lucacasula.it/SVItems/SnackViewPreview.jpg)

<div align = "center">

  <!--Replace kevnm67 with lucacasula91-->

  <a href="https://travis-ci.com/kevnm67/SnackView">
    <img src="https://travis-ci.com/kevnm67/SnackView.svg?branch=master" />
  </a>

  <a href="https://codeclimate.com/github/kevnm67/SnackView/maintainability">
    <img src="https://api.codeclimate.com/v1/badges/a137e060dec2e19171fe/maintainability" />
  </a>
  <a href="https://codeclimate.com/github/kevnm67/SnackView/test_coverage">
    <img src="https://api.codeclimate.com/v1/badges/a137e060dec2e19171fe/test_coverage" />
  </a>
  <a href="https://github.com/lucacasula91/SnackView">
    <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" />
  </a>

  <a href="https://github.com/lucacasula91/SnackView">
    <img src="https://img.shields.io/badge/compatible-swift4.2-orange.svg" />
  </a>

</div>

<div align = "center">

  <a href="https://img.shields.io/cocoapods/v/SnackView.svg">
    <img src="https://img.shields.io/cocoapods/v/SnackView.svg" />
  </a>

  <a href="https://github.com/lucacasula91/SnackView/wiki">
    <img src="https://img.shields.io/cocoapods/p/SnackView.svg?style=flat" />
  </a>

  <a href="https://cocoapods.org/pods/SnackView">
    <img src="https://img.shields.io/cocoapods/dt/SnackView.svg" />
  </a>

  <a href="http://twitter.com/lucacasula91">
    <img src="https://img.shields.io/badge/twitter-@lucacasula91-green.svg?style=flat" />
  </a>

  <a href="http://twitter.com/lucacasula91">
    <img src="https://img.shields.io/cocoapods/l/SnackView.svg?style=flat" />
  </a>

</div>


- [What's new](#whats-new)
  - [What's new in 1.0.8](#whats-new-in-108)
	- [What's new in 1.0.7](#whats-new-in-107)
- [Installation](#installation)
	- [CocoaPods](#cocoapods)
	- [Carthage](#carthage)
	- [Manual installation](#manual-installation)
- [Usage](#usage)
	- [Create your custom SnackView alert](#create-your-custom-snackview-alert)
- [SVItems included](#svitems-included)
- [Create custom SVItems](#create-custom-svitems)
- [Contributing](#contributing)

## What's new
### What's new in 1.0.8
- Fixed crash that occurs when SnackView was init with an empty SVItem array.

### What's new in 1.0.7
- Fixed an issue with constraints when keyboard did appear
- Fixed an issue with constraints with device rotation
- Added documentation for some methods

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
pod 'SnackView', '~> 1.0.2'
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
//SVItem array
let items: Array<SVItem>!

//Define all the view you want to display
let newPassword = SVTextFieldItem(withPlaceholder: "New Password", isSecureField: true)

let repeatPassword = SVTextFieldItem(withPlaceholder: "Repeat Password", isSecureField: true)

let continueButton = SVButtonItem(withTitle: "Continue") {
    /* Handle action here */
}

//Populate the SVItem array
items = [newPassword, repeatPassword, continueButton]

//Present the alert on screen.
SnackView(withTitle: "Create password", andCloseButtonTitle: "Cancel", andItems: items).show()
```

The result will be:

![SnackView alert](http://www.lucacasula.it/SVItems/SnackViewAlertPreview.jpg)

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
