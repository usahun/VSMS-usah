//
//  PassDataTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/4/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class PassDataTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textInput: UITextField!
    
    var passingData = CellClickViewModel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.resignFirstResponder()
        self.textInput.addTarget(self, action: #selector(textChange), for: .editingChanged)
    }

    @IBAction func touchUpInside(_ sender: UITextField) {
        
        print("OK")
    }
    
    @objc func textChange() {
        passingData.ID = self.textInput.text!
        passingData.Value = self.textInput.text!
     
    }
}
