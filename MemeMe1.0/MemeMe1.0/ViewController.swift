//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 9/15/15.
//  Copyright (c) 2015 Mykola Aleshchanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    let memeTextDelegate = MemeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topTextField.delegate = memeTextDelegate
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.topTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        self.topTextField.text = "TOP"
        
        self.bottomTextField.delegate = memeTextDelegate
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        self.bottomTextField.text = "BOTTOM"
    }
    
    override func viewDidAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}