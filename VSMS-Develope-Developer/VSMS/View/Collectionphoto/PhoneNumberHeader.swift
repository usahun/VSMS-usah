//
//  PhoneNumberHeader.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/5/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit


class PhoneNumberHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var addingButton: UIButton?

    var addingTapComplietion: (() -> Void)?
    @IBOutlet weak var phonenumbertextfield: UITextField?
    @IBOutlet weak var titleLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addingPhoneDidTap(_ sender: Any) {
        self.addingTapComplietion!()
    }
    
}
