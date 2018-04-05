![SnackView logo](http://www.lucacasula.it/SnackViewLogo.svg)

# SnackView
***An easy way to present customizable bottom-half alert.***
![SnackView logo](http://www.lucacasula.it/Preview.gif)

![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SnackView.svg)
![Platform](https://img.shields.io/cocoapods/p/SnackView.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/SnackView.svg?style=flat)
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
![SnackView alert](http://www.lucacasula.it/SnackViewAlert@2x.jpg)


