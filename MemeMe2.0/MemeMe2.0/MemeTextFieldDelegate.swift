//
//  MemeTextFieldDelegate.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 9/17/15.
//  Copyright © 2015 Mykola Aleshchanov. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate:NSObject, UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}