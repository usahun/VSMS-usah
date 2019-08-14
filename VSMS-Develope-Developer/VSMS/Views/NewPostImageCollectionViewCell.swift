//
//  NewPostImageCollectionViewCell.swift
//  VSMS
//
//  Created by Rathana on 6/28/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class NewPostImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var LblName: UILabel!
    
    //Internal Properties
    var proID: Int = -1
    weak var delgate: InitailViewControllerProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick)))
    }
    
    @objc func handerCellClick(){
        self.delgate?.pushNewViewController(ID: self.proID)
    }
}
