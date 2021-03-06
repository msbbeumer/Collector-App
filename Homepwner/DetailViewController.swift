//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/14/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  // MARK: - Properties
  var item: Item! {
    didSet {
      navigationItem.title = item.name
    }
  }
  
  var imageStore: ImageStore!
  
  // MARK: - Formatters
  // Format numbers
  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    
    return formatter
  }()
  
  // Format dates
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
  }()
  
  // MARK: - Outlets
  @IBOutlet var nameField: UITextField!
  @IBOutlet var serialNumberField: UITextField!
  @IBOutlet var valueField: UITextField!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var deleteButton: UIBarButtonItem!
  
  // MARK: - Actions
  // Dismiss the keyboard when the background is tapped
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  // Take a picture of the item with the camera icon in the toolbar of the Detail view
  @IBAction func takePicture(_ sender: UIBarButtonItem) {
    
    let imagePicker = UIImagePickerController()
    
    // If the device has a camera, take a picture; otherwise, just pick from photo library
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      imagePicker.sourceType = .camera
    } else {
      imagePicker.sourceType = .photoLibrary
    }
    
    imagePicker.allowsEditing = true
    
    imagePicker.delegate = self
    
    // Place imagePicker on the screen
    present(imagePicker, animated: true, completion: nil)
  }
  
  // Set up the trash tool bar button to delete the picture
  @IBAction func deletePicture(_ sender: UIBarButtonItem) {
    imageStore.deleteImage(forKey: item.itemKey)
    imageView.image = nil
    deleteButton.isEnabled = false
  }
  
  // MARK: - Saving the image
  // Store the picture taken by the camera to the item detail using the imagePicker delegate
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    // Get the image from the image picker info
    let image = info[UIImagePickerControllerEditedImage] as! UIImage
    
    // Store the image in the ImageStore for the item's key
    imageStore.setImage(image, forKey: item.itemKey)
    
    // put that image on the screen in the image view
    imageView.image = image
    
    // Dismiss the image picker view from the screen (must be called)
    dismiss(animated: true, completion: nil)
    
    deleteButton.isEnabled = true
    
  }
  
  // MARK: - Manage the detail viewer view cycle
  // Update the model with any changes made in the detail view
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Clear the first responder
    view.endEditing(true)
    
    // "Save" the changes to the item
    item.name = nameField.text ?? ""
    item.serialNumber = serialNumberField.text
    
    if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
      item.valueInDollars = value.intValue
    } else {
      item.valueInDollars = 0
    }
  }
  
  // Load the item data into the detail viewer
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameField.text = item.name
    serialNumberField.text = item.serialNumber
    valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
    dateLabel.text = dateFormatter.string(from: item.dateCreated)
    
    // Get the item key
    let key = item.itemKey
    
    // If there is an associated image with the item display it on the image view
    let imageToDisplay = imageStore.image(forKey: key)
    imageView.image = imageToDisplay
    
    if imageView.image == nil {
      deleteButton.isEnabled = false
    }
    
  }
  
  // MARK: - Methods
  // Dismiss the keyboard on pressing the return key using the UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  // MARK: - Segue Management
  // Prepare segue for DatePickerViewController
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showDate"?:
      let datePickerViewController = segue.destination as! DatePickerViewController
      datePickerViewController.item = item
    default:
      preconditionFailure("Unexpected segue identifier")
      
    }
  }
}
