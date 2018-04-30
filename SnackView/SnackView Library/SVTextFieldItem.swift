//
//  SVTextFieldItem.swift
//  SnackView
//
//  Created by Luca Casula on 15/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

/** SVTextFieldItem is an SVItem with which to show a placeholder text and a UITextField.
 
 You can access to text field content using the 'text' property of SVTextFieldItem.
 */
public class SVTextFieldItem: SVItem {
    
    //MARK: - Private variables
    private var textField: UITextField!
    
    
    //MARK: - Public variables
    public var text: String? {
        get {
            return self.textField.text
        }
        
        set {
            self.textField.text = newValue
        }
    }
    
    //MARK: - Initialization Method
    /**
     Initialization method for SVTextFieldItem view. You can customize this item with a placeholder text and with a boolean value to set UITextField as secure text entry.
     - parameter placeholder: The placeholder text to show on left item and as placeholder for UITextField
     - parameter isSecureField: A boolean value to indicate if UITextField is secure text entry
     
     
     **Note that label text on the left will be rendered as uppercased text**.
     
     To force the placeholder text to be rendered in multi-line please enter **\n** where you want the text to wrap.
     
     
     **Here an example of wrapped text**:
     ```
    SVTextFieldItem(withPlaceholder: "Repeat\nPassword",
                      isSecureField: true)
     ```
     */
    public init(withPlaceholder placeholder:String, isSecureField isSecure:Bool) {
        super.init()
        
        //Add title item
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = placeholder.uppercased()
        titleLabel.textAlignment = .right
        titleLabel.textColor = grayTextColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        
        
        //Add constraints to titleLabel
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==\(self.leftContentWidth))]", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleHContraints)
        
        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleVContraints)
        
        
        //Add text field item
        textField = UITextField()
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = self.removeNewLine(fromString: placeholder)
        self.addSubview(textField)
        
        
        //Add constraints to textField
        let textFieldHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[titleLabel]-[textfield]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel, "textfield":textField])
        self.addConstraints(textFieldHContraints)
        
        let textFieldVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textfield]-|", options: [], metrics: nil, views: ["textfield":textField])
        self.addConstraints(textFieldVContraints)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    
    //MARK: - Custom stuff
    
    /** This is a private function that remove the occurence of strings **\n** and **\r** and replace it with a white space. */
    private func removeNewLine(fromString string:String) -> String {
        var result = string.replacingOccurrences(of: "\r", with: " ")
        result = result.replacingOccurrences(of: "\n", with: " ")
        return result
    }
}

