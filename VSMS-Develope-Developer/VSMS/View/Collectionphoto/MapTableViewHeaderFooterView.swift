//
//  MapTableViewHeaderFooterView.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/18/19.
//  Copyright © 

import UIKit


class MapTableViewHeaderFooterView: UITableViewHeaderFooterView {

    weak var delegate: CellTableClick?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func submitClick(_ sender: Any) {
        self.delegate?.SubmitClick()
    }
    
}
