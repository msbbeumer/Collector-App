//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/15/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!

    @IBAction func valueChanged(_ sender: UIDatePicker, forEvent event: UIEvent) {
        item.dateCreated = datePicker.date
    }
    
    var item: Item!
    
    
    // Pre-load the date that the item was created
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Date Created"
        
        datePicker.maximumDate = Date()
        
    }
}
