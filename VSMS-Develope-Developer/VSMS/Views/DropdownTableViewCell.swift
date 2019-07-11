//
//  DropdownTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/3/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON

protocol CellTableClick: class {
    func ClickCell(currentCell: CellClickViewModel)
    func SubmitClick()
}

class DropdownTableViewCell: UITableViewCell, refreshDropdownInXib {
 
    
   
    weak var delegate: CellTableClick?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttondropdown: UIButton!

    

    var isNotDropDownList: Bool = false {
        didSet {
            buttondropdown.isUserInteractionEnabled = !self.isNotDropDownList
        }
    }
    
    let Dropdown = DropDown()
    var passingData = CellClickViewModel()
    private var drowdownData: [String] = []
    private var rawData: [dropdownData] = []
    var index: Int = 0
    var title: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func refreshXib(FKKey: Int) {
        Functions.getDropDownList(key: passingData.IndexPathKey!.row, completion: { (val) in
            self.rawData = val
            self.drowdownData.removeAll()
            for i in val{
                if i.FKKey?.toInt() == FKKey {
                    self.drowdownData.append(i.Text)
                }
            }
            print(self.drowdownData)
            self.setupChooseArticleDropDown()
        })
    }
    
    func getDiscountTypeValue(disType: String) {
        print("ss")
    }

    
    @IBAction func buttonTappeddropdown(_ sender: Any) {
        LoadDropDownData(key: passingData)
    }
    
    func setupChooseArticleDropDown() {
        Dropdown.anchorView = buttondropdown
        Dropdown.bottomOffset = CGPoint(x: 0, y: buttondropdown.bounds.height)
        Dropdown.dataSource = self.drowdownData
        
        // Action triggered on selection
        Dropdown.selectionAction = { [weak self] (index, item) in
            self!.passingData.ID = self?.rawData[index].ID ?? ""
            self!.passingData.Value = item
            self?.delegate?.ClickCell(currentCell: self!.passingData)
            self?.buttondropdown.setTitle(item, for: .normal)
            self!.Dropdown.hide()
        }
    }
    
    // Action triggered on selection
    
    
    func LoadDropDownData(key: CellClickViewModel){
        if drowdownData.count > 0 {
            self.Dropdown.show()
            return
        }
        
        Functions.getDropDownList(key: passingData.IndexPathKey!.row, completion: { (val) in
            self.rawData = val
            self.drowdownData.removeAll()
            for i in val{
               self.drowdownData.append(i.Text)
            }
            self.setupChooseArticleDropDown()
            self.Dropdown.show()
        })
    }
    
}
