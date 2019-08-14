//
//  NewPostListCollectionViewCell.swift
//  VSMS
//
//  Created by Rathana on 6/26/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class NewPostListCollectionViewCell: UICollectionViewCell {
    
    //Properties
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    
    //Internal Properties
    var proID: Int = -1
    weak var delgate: InitailViewControllerProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick)))
    }

    @objc func handerCellClick(){
        print(self.proID)
        //switching the screen
        self.delgate?.pushNewViewController(ID: self.proID)
    }
}
