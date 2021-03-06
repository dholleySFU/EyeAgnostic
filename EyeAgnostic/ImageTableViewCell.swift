//
//  ImageTableViewCell.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-09.
//  Copyright (c) 2015 Skeye Technologies. All rights reserved.
//  Group 01

import UIKit

class ImageTableViewCell: UITableViewCell {
    //Class of Case Cells in the View+Edit Table
    
    // MARK: Propeties
    @IBOutlet weak var caseImageView: UIImageView!
    @IBOutlet weak var dateLabel: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
