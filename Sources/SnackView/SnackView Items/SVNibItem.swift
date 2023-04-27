//
//  SVNibItem.swift
//  
//
//  Created by Luca Casula on 25/04/23.
//

import UIKit

protocol SVNameableItem {
    var nibName: String { get }
}

public class SVNibItem: SVItem {
    
    // MARK: - Private Outlets
    @IBOutlet private var view: UIView!

    // MARK: - Initialization Methods
    override init() {
        super.init()
        self.commonInit()
    }
    
    init(frame: CGRect) {
        super.init()
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init()
        self.commonInit()
    }
    
    
    // MARK: - Private Methods
    private func commonInit() {
        var name = NSStringFromClass(type(of: self))
        if let _namebleString = self as? SVNameableItem {
            name = _namebleString.nibName
        }
        print("NibName: \(name)")
        
        Bundle.main.loadNibNamed(name, owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }

}


