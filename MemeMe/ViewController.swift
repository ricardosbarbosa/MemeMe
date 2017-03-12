//
//  ViewController.swift
//  MemeMe
//
//  Created by Ricardo Barbosa on 11/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

protocol MemeViewControllerProtocol {
  func added(controller: ViewController, meme: Meme)
}

extension ViewController : UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.text == "TOP" || textField.text == "BOTTOM" {
      textField.text = ""
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    dismiss(animated: true, completion: nil)
    if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      imagView.image = image
      self.shareButtonItem.isEnabled = true
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}

class ViewController: UIViewController {

  @IBAction func cancelAction(_ sender: Any) {
    resetView()
    dismiss(animated: true, completion: nil)
  }
  @IBOutlet weak var navBar: UINavigationBar!
  @IBOutlet weak var tobar: UIToolbar!
  
  @IBOutlet weak var topTextView: UITextField!
  @IBOutlet weak var bottomTextView: UITextField!
  @IBOutlet weak var cancelButtomItem: UIBarButtonItem!
  @IBOutlet weak var shareButtonItem: UIBarButtonItem!
  @IBOutlet weak var camButtomItem: UIBarButtonItem!
  @IBOutlet weak var albumButtomItem: UIBarButtonItem!
  @IBOutlet weak var imagView: UIImageView!
  
  var memeViewControllerProtocol : MemeViewControllerProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resetView()
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }

  func resetView() {
    
    imagView.image = nil
    shareButtonItem.isEnabled = false
    
    let memeTextAttributes = [
      NSStrokeColorAttributeName: UIColor.black,
      NSForegroundColorAttributeName: UIColor.white,
      NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
      NSStrokeWidthAttributeName: -3.0
    ] as [String : Any]
    
    setupTextField(textField: topTextView, defaultText: "TOP", memeTextAttributes: memeTextAttributes)
    setupTextField(textField: bottomTextView, defaultText: "BOTTOM", memeTextAttributes: memeTextAttributes)
    
  }
  
  func setupTextField(textField: UITextField, defaultText: String, memeTextAttributes: [String : Any]) {
    textField.delegate = self
    textField.text = defaultText
    textField.defaultTextAttributes = memeTextAttributes
    textField.textAlignment = .center
    textField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    camButtomItem.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    unsubscribeFromKeyboardNotifications()
  }
  
  func keyboardWillShow(_ notification:Notification) {
    if bottomTextView.isFirstResponder {
      view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
  }
  
  func getKeyboardHeight(_ notification:Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.cgRectValue.height
  }
  
  func keyboardWillHide(_ notification:Notification) {
    if bottomTextView.isFirstResponder {
      view.frame.origin.y = 0
    }
  }
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  func presentImagePicker(chosenSource: UIImagePickerControllerSourceType) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = chosenSource
    self.present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func camAction(_ sender: UIBarButtonItem) {
    presentImagePicker(chosenSource: .camera)
  }
  
  @IBAction func albumAction(_ sender: UIBarButtonItem) {
    presentImagePicker(chosenSource: .photoLibrary)
  }

  func save(memedImage: UIImage) {
    // Create the meme
    let memedImage = generateMemedImage()
    let meme = Meme(topText: topTextView.text!, bottomText: bottomTextView.text!, originalImage: imagView.image!, memedImage: memedImage)
    memeViewControllerProtocol?.added(controller: self, meme: meme)
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func shareAction(_ sender: Any) {
    let memedImage = generateMemedImage()
    let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    activity.completionWithItemsHandler = { (_, success, _, _) in
      if success {
        self.save(memedImage: memedImage)
      }
    }
    
    self.present(activity, animated: true, completion: nil)
  }
  
  func generateMemedImage() -> UIImage {
    navBar.isHidden = true
    tobar.isHidden = true
    
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
    let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    navBar.isHidden = false
    tobar.isHidden = false
    return memedImage
  }
}

