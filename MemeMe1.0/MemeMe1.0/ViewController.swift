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

    var memeImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = memeTextDelegate
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        topTextField.text = "TOP"
        
        bottomTextField.delegate = memeTextDelegate
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        bottomTextField.text = "BOTTOM"
    }
    
    override func viewDidAppear(animated: Bool) {
        // Disable camera button on cameraless devices
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotification()
        
        // Disable sharing until meme is ready
        if(self.imageView.image == nil) {
            self.shareMemeButton.enabled = false
        } else {
            self.shareMemeButton.enabled = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotification()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!

    
    @IBAction func shareMeme(sender: AnyObject) {
        let memeImage:UIImage = generateMemeImage()
        let controller = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
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
    
    // When the user picks an image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // When the user cancels
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func getKeyboardHight(notification:NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
        
    }
    
    func keyboardWillShow(notification:NSNotification){
        self.view.frame.origin.y -= getKeyboardHight(notification)
    }
    
    func keyboardWillHide(notification:NSNotification){
        self.view.frame.origin.y += getKeyboardHight(notification)
    }
    
    func generateMemeImage() ->UIImage{
        // Hide toolbars
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        
        // Render meme image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Unhide toolbars
        topToolbar.hidden = false
        bottomToolbar.hidden = false
        return memeImage
    }
    
    // Activity view controller
    func save(){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memeImage: memeImage!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}