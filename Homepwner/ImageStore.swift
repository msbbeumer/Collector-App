//
//  ImageStore.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/16/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class ImageStore {
  // MARK: - Properties
  let cache = NSCache<NSString, UIImage>()
  
  // MARK: - ImageStore methods
  func setImage(_ image: UIImage, forKey key: String) {
    cache.setObject(image, forKey: key as NSString)
    
    // Create full URL to hold the image
    let url = imageURL(forKey: key)
    
    // Turn image into PNG data
    if let data = UIImagePNGRepresentation(image) {
      // Write it to full URL
      let _ = try? data.write(to: url, options: [.atomic])
    }
  }
  
  func image(forKey key: String) -> UIImage? {
    if let existingImage = cache.object(forKey: key as NSString) {
      return existingImage
    }
    
    let url = imageURL(forKey: key)
    guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
      return nil
    }
    
    cache.setObject(imageFromDisk, forKey: key as NSString)
    return imageFromDisk
  }
  
  func deleteImage(forKey key: String) {
    cache.removeObject(forKey: key as NSString)
    
    let url = imageURL(forKey: key)
    do {
      try FileManager.default.removeItem(at: url)
    } catch let deleteError {
      print("Error removing the image from disk: \(deleteError)")
    }
  }
  
  // MARK: FileSystem management
  func imageURL(forKey key: String) -> URL {
    let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    
    return documentDirectory.appendingPathComponent(key)
  }
  
  
}
