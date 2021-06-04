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

    // MARK: - Private Properties
    private var titleLabel: UILabel
    private var textField: UITextField

    // MARK: - Public Properties
    private(set) var placeholder: String
    private(set) var isSecure: Bool


    /// The current text that is displayed by the label.
    public var text: String? {
        get { return self.textField.text }
        set { self.textField.text = newValue }
    }

    // MARK: - Initialization Method
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
    public init(withPlaceholder placeholder: String, isSecureField isSecure: Bool) {
        self.titleLabel = UILabel()
        self.textField = UITextField()

        self.placeholder = placeholder
        self.isSecure = isSecure
        super.init()

        self.addTitleLabel()
        self.addTextField()
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Private Methods
    private func addTitleLabel() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = placeholder.uppercased()
        self.titleLabel.textAlignment = .right
        self.titleLabel.textColor = secondaryTextColor
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)

        //Add constraints to titleLabel
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==\(self.leftContentWidth))]",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["titleLabel": titleLabel])
        self.addConstraints(titleHContraints)

        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|",
                                                              options: [],
                                                              metrics: nil,
                                                              views: ["titleLabel": titleLabel])
        self.addConstraints(titleVContraints)
    }

    private func addTextField() {
        self.textField.isSecureTextEntry = isSecure
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.borderStyle = .none
        self.textField.font = UIFont.preferredFont(forTextStyle: .body)
        self.textField.adjustsFontForContentSizeCategory = true
        self.textField.placeholder = self.removeNewLine(fromString: placeholder)
        self.addSubview(self.textField)

        //Add constraints to textField
        let textFieldHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[titleLabel]-[textfield]-|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: ["titleLabel": titleLabel, "textfield": textField])
        self.addConstraints(textFieldHContraints)

        let textFieldVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textfield]-|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: ["textfield": textField])
        self.addConstraints(textFieldVContraints)

    }


    // MARK: - Custom stuff

    /** This is a private function that remove the occurence of strings **\n** and **\r** and replace it with a white space. */
    private func removeNewLine(fromString string: String) -> String {
        var result = string.replacingOccurrences(of: "\r", with: " ")
        result = result.replacingOccurrences(of: "\n", with: " ")
        return result
    }
}
