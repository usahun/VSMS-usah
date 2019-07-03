//
//  PassDataTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/4/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import DropDown

class PassDataTableViewCell: UITableViewCell {

    @IBOutlet weak var mytextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var buttonTapped: UIButton!
    let Dropdown = DropDown()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupChooseArticleDropDown()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func eventclick(_ sender: Any) {
        Dropdown.show()
    }
    func setupChooseArticleDropDown() {
        Dropdown.anchorView = buttonTapped
        
        // Will set a custom with instead of anchor view width
        //        dropDown.width = 100
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        Dropdown.bottomOffset = CGPoint(x: 0, y: buttonTapped.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        Dropdown.dataSource = [
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition"
        ]
        
        // Action triggered on selection
        Dropdown.selectionAction = { [weak self] (index, item) in
            self?.buttonTapped.setTitle(item, for: .normal)
        }
        
        Dropdown.multiSelectionAction = { [weak self] (indices, items) in
            print("Muti selection action called with: \(items)")
            if items.isEmpty {
                self?.buttonTapped.setTitle("", for: .normal)
            }
        }
        
        // Action triggered on dropdown cancelation (hide)
        //        dropDown.cancelAction = { [unowned self] in
        //            // You could for example deselect the selected item
        //            self.dropDown.deselectRowAtIndexPath(self.dropDown.indexForSelectedRow)
        //            self.actionButton.setTitle("Canceled", forState: .Normal)
        //        }
        
        // You can manually select a row if needed
        //        dropDown.selectRowAtIndex(3)
    }
    
}
