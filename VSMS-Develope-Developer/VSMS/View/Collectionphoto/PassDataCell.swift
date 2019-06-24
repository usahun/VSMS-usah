//
//  PassDataTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/4/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class PassDataTableViewCell: UITableViewCell {

    @IBOutlet weak var mytextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
