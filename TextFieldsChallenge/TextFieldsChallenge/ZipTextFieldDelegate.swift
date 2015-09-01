//
//  ZipTextFieldDelegate.swift
//  TextFieldsChallenge
//
//  Created by Mykola Aleshchanov on 9/1/15.
//  Copyright (c) 2015 Mykola Aleshchanov. All rights reserved.
//

import Foundation
import UIKit

class ZipTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var makeChange:Bool = false
        var newText: NSString = textField.text
        let zipPattern = "\\d{1,5}"
        let zipRegex = NSRegularExpression(pattern: zipPattern, options: nil, error: nil)
        let zipRange = NSRange(location:0, length: count(string))
        let zipMatch = zipRegex?.rangeOfFirstMatchInString(string, options: nil, range: zipRange)
        if zipMatch?.location != NSNotFound || count(string) == 0 {
            if newText.length < 5 || count(string) == 0{
                makeChange = true
            } else {
                makeChange = false
            }
        } else {
            makeChange = false
        }
        
        if makeChange {
            return true
        } else {
            textField.text = newText as String
            return false
        }
    }
}
