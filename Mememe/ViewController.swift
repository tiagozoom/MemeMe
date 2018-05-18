//
//  ViewController.swift
//  Mememe
//
//  Created by tiago turibio on 17/04/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum BarButtonType: Int{
        case camera,gallery
    }
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var gallery: UIBarButtonItem!
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var memedImage: UIImage?
    
    let memeTextAttributes: Dictionary<String,Any> = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -4
    ]
    
    let memeTextDelegate = MemeTextDelegate()
    
    @IBAction func selectPhoto(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        switch BarButtonType(rawValue: sender.tag)! {
        case .camera:
            imagePicker.sourceType = .photoLibrary
        case .gallery:
            imagePicker.sourceType = .camera
        }
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            imageView.image = image
        }
        
        dismiss(animated: true){
            self.shareButton.isEnabled = true;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.delegate = memeTextDelegate
        bottomText.delegate = memeTextDelegate
        imageView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyBoardNotification()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            camera.isEnabled = true
        }
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = .center
        bottomText.textAlignment = .center
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyBoardNotification()
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        if(bottomText.isFirstResponder){
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        if(bottomText.isFirstResponder){
            view.frame.origin.y = 0
        }
    }
    
    fileprivate func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        if let userInfo = notification.userInfo{
            if let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                return keyboardSize.cgRectValue.height
            }
        }
        
        return 0
    }
    
    fileprivate func subscribeToKeyBoardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: .UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func unsubscribeToKeyBoardNotification(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        return memedImage
    }
    
    @IBAction func cancel(_ sender: Any) {
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        imageView.image = nil
        shareButton.isEnabled = false
    }
    
    fileprivate func save(){
        let meme = Meme(originalImage: imageView.image, memeImage: memedImage!, topText: topText.text!, bottomText: bottomText.text!)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = getMemeCompletionWithItemsHandler()
        present(activityViewController, animated: true, completion: nil)
    }
    
    fileprivate func getMemeCompletionWithItemsHandler() -> UIActivityViewControllerCompletionWithItemsHandler{
        return {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed{
                self.save()
            }
        }
    }
}
