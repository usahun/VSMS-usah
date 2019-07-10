//
//  PhotoListCollectionViewCell.swift
//  VSMS
//
//  Created by usah on 3/8/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class PhotoListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView?
    @IBOutlet weak var btnRemove: UIButton!
    var removeImage:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func btnRemoveClick(_ sender: UIButton) {
        self.removeImage!()
    }
    
}
