![SnackView logo](http://www.lucacasula.it/SnackViewLogo.svg)

# SnackView
***An easy way to present customizable bottom-half alert.***
![SnackView logo](http://www.lucacasula.it/Preview.gif)

![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SnackView.svg)
![Platform](https://img.shields.io/cocoapods/p/SnackView.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/SnackView.svg?style=flat)
[![Downloads](https://img.shields.io/cocoapods/dt/SnackView.svg)](https://cocoapods.org/pods/SnackView)
[![Twitter](https://img.shields.io/badge/twitter-@lucacasula91-green.svg?style=flat)](http://twitter.com/lucacasula91)


## Installation with CocoaPods

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


## Create your custom SnackView alert
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

![SnackView alert](http://www.lucacasula.it/AlertExample.jpg)

***

## SVItems included
SnackView provides some SVItems ready to use, here below the list of SVItems available:

**SVApplicationItem**

```swift
SVApplicationItem(withIcon: UIImage(named: "AppIcon"),
                 withTitle: "Ipsum lorem", 
            andDescription: "Lorem ipsum dolor sit amet...")
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVApplicationItem.png)

***

**SVDescriptionItem**

```swift
SVDescriptionItem(withDescription: "Lorem ipsum dolor sit amet...")
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVDescriptionItem.png)

***

**SVTextFieldItem**

```swift
SVTextFieldItem(withPlaceholder: "Create Password", 
                  fisSecureField: true)
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVTextFieldItem.png)

***

**SVDetailTextItem**

```swift
SVDetailTextItem(withTitle: "Elit amet", 
                andContent: "Lorem ipsum dolor sit amet...")
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVDetailTextItem.png)

***

**SVButtonItem**

```swift
SVButtonItem(withTitle: "Continue") { /* Button action here */ }
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVButtonItem.png)

***

**SVSwitchItem**

```swift
SVSwitchItem(withTitle: "Push Notifications", 
            andContent: "Activate to stay up to date...") { (isOn) in  /* Switch action here */ }
```

![SnackView alert](http://www.lucacasula.it/SVItems/SVSwitchItem.jpg)

***


## Contributing
If you want to contribute to make SnackView a better framework, **submit a pull request**.

Please consider to **open an issue** for the following reasons:
* If you have questions or if you need help using SnackView
* If you found a bug
* If you have some feature request


