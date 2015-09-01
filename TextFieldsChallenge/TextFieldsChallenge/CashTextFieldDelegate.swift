//
//  CashTextFieldDelegate.swift
//  TextFieldsChallenge
//
//  Created by Mykola Aleshchanov on 9/1/15.
//  Copyright (c) 2015 Mykola Aleshchanov. All rights reserved.
//

import Foundation
import UIKit

class CashTextFieldDelegate:NSObject, UITextFieldDelegate {
    
    let dollarSign = "\u{24}"
    var hundredsDigits = 0
    let digitPattern = "\\d"
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text
        var unformatedText: String
        let digitRegex = NSRegularExpression(pattern: digitPattern, options: nil, error: nil)
        let digitRange = NSRange(location:0, length: count(string))
        let digitMatch = digitRegex?.rangeOfFirstMatchInString(string, options: nil, range: digitRange)
        
        // If new character is a digit, then add to the string. 
        // If empty string, then it must be a backspace and the last digit
        // needs to be deleted.
        if digitMatch?.location != NSNotFound {
            
            // Get character string without formating characters
            unformatedText = unformatCashText(newText)
            
            // Append the new character to the text string
            if hundredsDigits < 3 {
                hundredsDigits = hundredsDigits + 1
                var index = unformatedText.startIndex
                unformatedText.removeAtIndex(index)
                newText = unformatedText + string
            } else {
                newText = unformatedText + string
            }
            
            // Add formating characters to the new text string
            textField.text = formatCashText(newText)
            
        } else if count(string) == 0 {
            
            // Get character string without formating characters
            unformatedText = unformatCashText(newText)
            if count(unformatedText) > 3 {
                unformatedText.removeAtIndex(unformatedText.endIndex.predecessor())
            } else {
                unformatedText = "0" + unformatedText
                unformatedText.removeAtIndex(unformatedText.endIndex.predecessor())
                hundredsDigits = hundredsDigits - 1
            }
            
            // Add formating characters to the new text string
            textField.text = formatCashText(unformatedText)
        }
        return false
    }
    
    func unformatCashText(string: String) -> String {
        var searchPattern = "(\\$|\\.)"
        var replaceWith = ""
        var cashRegex = NSRegularExpression(pattern: searchPattern, options: nil, error: nil)
        var cashRange = NSRange(location: 0, length: count(string))
        var newString = cashRegex?.stringByReplacingMatchesInString(string, options: nil, range: cashRange, withTemplate: replaceWith)
        return newString!
    }
    
    func formatCashText(string:String) -> String {
        var newString = dollarSign + string
        newString.splice(".", atIndex: newString.endIndex.predecessor().predecessor())
        return newString
    }
}
