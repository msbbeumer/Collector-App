//
//  SelectedTextField.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/15/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class SelectedTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        borderStyle = .line
    
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        borderStyle = .roundedRect
        
        return true
    }
}
