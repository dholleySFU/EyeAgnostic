//
//  ProfCellTableViewCell.swift
//  EyeAgnostic
//
//  Created by Derek Holley on 2015-11-20.
//  Copyright © 2015 Skeye Technologies. All rights reserved.
//

import UIKit

class ProfCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
