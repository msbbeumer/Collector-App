//
//  ItemCell.swift
//  Homepwner
//
//  Created by Mischa Beumer on 3/14/17.
//  Copyright © 2017 msbbeumer. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
  
  // MARK: - Outlets
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var serialNumberLabel: UILabel!
  @IBOutlet var valueLabel: UILabel!
  
  // MARK: - awakeFromNib()
  override func awakeFromNib() {
    super.awakeFromNib()
    
    nameLabel.adjustsFontForContentSizeCategory = true
    serialNumberLabel.adjustsFontForContentSizeCategory = true
    valueLabel.adjustsFontForContentSizeCategory = true
  }
}
