//
//  ContactInputTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/10/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class ContactInputTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var passingData = CellClickViewModel()
    weak var delegate: CellTableClick?
    var IsLoadUser = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print(passingData.IndexPathKey?.row)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        InitailValueByUser()
    }
    
    
    @IBAction func txtNameChangeHandle(_ sender: UITextField) {
        passingData.ID = sender.text!
        passingData.Value = sender.text!
        delegate?.ClickCell(currentCell: passingData)
    }
    
    @IBAction func txtPhoneNumberChange(_ sender: UITextField) {
        passingData.ID = sender.text!
        passingData.Value = sender.text!
        delegate?.ClickCell(currentCell: passingData)
    }
    
    @IBAction func txtEmailChangeHandle(_ sender: UITextField) {
        passingData.ID = sender.text!
        passingData.Value = sender.text!
        delegate?.ClickCell(currentCell: passingData)
    }
    
    
    
    func InitailValueByUser(){
        guard IsLoadUser else {
            return
        }
        
        switch passingData.IndexPathKey?.row {
        case 0:
            txtName.text = User.getUsername()
        case 1:
            txtPhoneNumber.text = User.getUsername()
        default:
            print("default")
        }
        IsLoadUser = false
    }
}
