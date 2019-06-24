//
//  AddmoreNumberPhoneTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/11/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit


class AddmoreNumberPhoneTableViewCell: UITableViewCell {
    var addingTapComplietion: (() -> Void)?
    
    @IBOutlet weak var phonenumbertextfield: UITextField?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var addingbutton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addingPhoneDidTap(_ sender: Any) {
        self.addingTapComplietion!()
    }
    
}
