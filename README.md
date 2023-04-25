![SnackView logo](http://www.lucacasula.it/SVItems/snackview_header.png)

***Create customizable bottom-half sheets.***
![SnackView logo](http://www.lucacasula.it/SVItems/NewSnackViewPreview.jpg)

[![Test Coverage](https://api.codeclimate.com/v1/badges/9aeb1378d61a9f9a3fe4/test_coverage)](https://codeclimate.com/github/lucacasula91/SnackView/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/9aeb1378d61a9f9a3fe4/maintainability)](https://codeclimate.com/github/lucacasula91/SnackView/maintainability)


- [Roadmap](#roadmap)
- [What's new](#whats-new)
  - [What's new in 1.2.0](#whats-new-in-120)
- [Installation](#installation)
 	- [Swift Package Manager](#swift-package-manager)
	- ~~[CocoaPods](#cocoapods)~~ Not available yet for 1.2.0
	- ~~[Carthage](#carthage)~~ Not available yet for 1.2.0
	- [Manual installation](#manual-installation)
- [Usage](#usage)
	- [Create your custom SnackView alert](#create-your-custom-snackview-alert)
- [SVItems included](#svitems-included)
- [Create custom SVItems](#create-custom-svitems)
- [Contributing](#contributing)

## Roadmap
- Create DocC documentation
- Allow UIFont override
- Add support for Xib hosted SVItems
- Add new SVItems


## What's new

### What's new in 1.2.0
- **Dynamic type support**
- **SVSegmentedControlItem**
- **SVStepperItem**
- **SVSpacerItem**

## Installation

### Swift Package Manager
To install SnackView library using Swift Package Manager from Xcode select **File** > **Add Package** and enter:
```
https://github.com/lucacasula91/SnackView
```

### Manual installation

If you want to install SnackView manually, just drag **Sources** folder into your project.

## Usage

### Create your custom SnackView sheet
To create a custom SnackView your UIViewController or you NSObject class should conform to to **SnackViewDataSource** protocol.
SnackViewDataSource allows you to specify title bar elements and UI elements that sheet should present.

The first step is to specify the title of you SnackView sheet:
```swift
func titleFor(snackView: SnackView) -> String {
    return "My Title"
} 
```

Then you can specify the dismission button title. This method can return an Optional string value to hide the dismission button.
- Note: If you pass nil it is up to you to handle manually the SnackView dismission logic.
```swift
func cancelTitleFor(snackView: SnackView) -> String? {
    return "Cancel"
} 
```

The last part required is the method with which specify the items to show.
```swift
func itemsFor(snackView: SnackView) -> [SVItem] {
    let descriptionItem = SVDescriptionItem(withDescription: "In this last release of SnackView we...")
    let imageItem = SVImageViewItem(withImage: UIImage(named: "what_is_new")!,
                                    andContentMode: .scaleAspectFill)

    return [descriptionItem, imageItem]
} 
```

Once conformed to SnackViewDataSource you are ready to present you SnackView sheet:
```swift
let snackView = SnackView(with: dataSource)
snackView.show()
```

## Example
Here below an example of SnackView implementation:

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
        let imageItem = SVImageViewItem(withImage: UIImage(named: "what_is_new")!,
                                        andContentMode: .scaleAspectFill)

        return [descriptionItem, imageItem]
    }
}

```



------

## SVItems included
SnackView provides some SVItems ready to use, here below the list of some SVItems available:
- **SVStepperItem**
- **SVSliderItem**
- **SVSegmentedControllerItem**
- **SVSpacerItem**

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


