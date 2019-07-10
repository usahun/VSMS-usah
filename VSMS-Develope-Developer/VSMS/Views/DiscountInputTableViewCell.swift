//
//  DiscountInputTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/9/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import DropDown

class DiscountInputTableViewCell: UITableViewCell, getDropdowntypeProtocol {

    @IBOutlet weak var btnDiscountType: UIButton!
    @IBOutlet weak var lblDiscount: UILabel!
    
    weak var delegate: CellTableClick?
    var passingData = CellClickViewModel()
    var Dropdown = DropDown()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDiscountTypeDropDown()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnDiscountTypeClick(_ sender: Any) {
        Dropdown.show()
    }
    
    func getDropDownTypeData(type: String) {
        lblDiscount.text = "Discount \(type)"
    }
   
    @IBAction func txtDiscountChange(_ sender: UITextField) {
        passingData.ID = sender.text?.lowercased() ?? ""
        passingData.Value = sender.text ?? ""
        self.delegate?.ClickCell(currentCell: passingData)
    }
    
    func setupDiscountTypeDropDown(){
        Dropdown.anchorView = self.btnDiscountType
        Dropdown.dataSource = Functions.getDiscountTypeList()
        // Action triggered on selection
        Dropdown.selectionAction = { [weak self] (index, item) in
            self?.passingData.ID = item.lowercased()
            self?.passingData.Value = item
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.btnDiscountType.setTitle(item, for: .normal)
            self!.Dropdown.hide()
        }
    }
    
}
