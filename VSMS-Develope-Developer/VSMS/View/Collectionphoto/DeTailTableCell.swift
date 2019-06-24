//
//  DeTailTablelCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/2/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class DeTailTableCell: UITableViewCell {

    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var textField: UITextInput!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
