//
//  LikesTableViewCell.swift
//  VSMS
//
//  Created by Rathana on 7/5/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class LikesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LikesImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    //Internal Properties
    var ProID: Int = -1
    weak var delegate: CellClickProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func handerCellClick(){
        self.delegate?.cellXibClick(ID: ProID)
    }
    
}
