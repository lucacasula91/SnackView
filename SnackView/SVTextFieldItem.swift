//
//  SVTextFieldItem.swift
//  BottomAllert
//
//  Created by Luca Casula on 15/11/17.
//  Copyright © 2017 Luca Casula. All rights reserved.
//

import UIKit

public class SVTextFieldItem: SVItem {

    public var textField:UITextField!
    
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
        
        let titleHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(==111)]", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleHContraints)
        
        let titleVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel(>=28)]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel])
        self.addConstraints(titleVContraints)
        
        
        //
        textField = UITextField()
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = self.removeNewLine(fromString: placeholder)
        self.addSubview(textField)
        
        let textFieldHContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[titleLabel]-[textfield]-|", options: [], metrics: nil, views: ["titleLabel":titleLabel, "textfield":textField])
        self.addConstraints(textFieldHContraints)
        
        let textFieldVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textfield]-|", options: [], metrics: nil, views: ["textfield":textField])
        self.addConstraints(textFieldVContraints)
       
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func removeNewLine(fromString string:String) -> String {
        var result = string.replacingOccurrences(of: "\r", with: " ")
        result = result.replacingOccurrences(of: "\n", with: " ")
        return result
    }

}

