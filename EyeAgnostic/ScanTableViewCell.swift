//
//  ScanTableViewCell.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-21.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class ScanTableViewCell: UITableViewCell {

    @IBOutlet weak var scanDate: UILabel!
    @IBOutlet weak var scanResult: UILabel!
    @IBOutlet weak var scanImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
