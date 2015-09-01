//
//  ViewController.swift
//  TextFieldsChallenge
//
//  Created by Mykola Aleshchanov on 8/31/15.
//  Copyright (c) 2015 Mykola Aleshchanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textSwitch: UISwitch!
    
    let zipDelegate = ZipTextFieldDelegate()
    let cashDelegate = CashTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField1.delegate = zipDelegate
        self.textField2.delegate = cashDelegate
        self.textField3.delegate = self
        textSwitch.on = false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textSwitch.on{
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textSwitch.on{
            textField.text = "The switch is set to On"
            return textSwitch.on
        } else {
            textField.text = "The switch is set to Off"
            return textSwitch.on
        }
    }
    
}
