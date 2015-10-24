//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Mykola Aleshchanov on 9/15/15.
//  Copyright (c) 2015 Mykola Aleshchanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    let memeTextDelegate = MemeTextFieldDelegate()

    var memeImage: UIImage!
    
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
        subscribeToKeyboardNotification()
        
        // Disable sharing until meme is ready
        if(imageView.image == nil){
            shareMemeButton.enabled = false
        } else {
            shareMemeButton.enabled = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotification()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!

    
    @IBAction func shareMeme(sender: AnyObject) {
        memeImage = generateMemeImage()
        let controller = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        controller.completionWithItemsHandler = saveMemeAfterSharing
        presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // When the user picks an image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // When the user cancels
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func getKeyboardHight(notification:NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        var keyboardHight: CGFloat
        
        // Slide meme image with the keyboard only for the bottom text field
        if(bottomTextField.isFirstResponder()){
            let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
            keyboardHight = keyboardSize.CGRectValue().height
        } else {
            keyboardHight = 0
        }
        return keyboardHight
        
    }
    
    func keyboardWillShow(notification:NSNotification) {
        view.frame.origin.y -= getKeyboardHight(notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        view.frame.origin.y += getKeyboardHight(notification)
    }
    
    func generateMemeImage() -> UIImage {
        // Hide toolbars
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        
        // Render meme image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Unhide toolbars
        topToolbar.hidden = false
        bottomToolbar.hidden = false
        return memeImage
    }
    
    // Found help on how to add completion handler on the forum 
    /*https://discussions.udacity.com/t/im-not-understanding-the-uiactivityviewcontroller-completionwithitemshandler/14271 */
    func saveMemeAfterSharing(activity: String?, completed: Bool, items: [AnyObject]?, error: NSError?) {
        if(completed){
            saveMeme()
            dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    // Activity view controller
    func saveMeme() {
        //Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memeImage: memeImage!)
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        if let navigationController = self.navigationController {
            navigationController.popToRootViewControllerAnimated(true)
        }
    }
}