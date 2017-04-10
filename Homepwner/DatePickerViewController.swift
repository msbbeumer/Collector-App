//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/15/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
  
  //MARK: - Outlets and Properties
  @IBOutlet var datePicker: UIDatePicker!
  
  @IBAction func valueChanged(_ sender: UIDatePicker, forEvent event: UIEvent) {
    item.dateCreated = datePicker.date
  }
  
  var item: Item!
  
  // MARK: - View Cycle
  // Pre-load the date that the item was created
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.title = "Date Created"
    
    datePicker.maximumDate = Date()
    datePicker.date = item.dateCreated
    
  }
}
