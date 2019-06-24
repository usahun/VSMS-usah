//
//  GreditImageCollectionViewCell.swift
//  VSMS
//
//  Created by usah on 6/18/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class GreditImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var greditimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       greditimage.clipsToBounds = true
    }

    
    
}

//extension NewlyTableViewCell: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var collectionViewSize = collectionView.frame.size
//        collectionViewSize.width = collectionViewSize.width/2.0
////        collectionViewSize.height = collectionViewSize.height/4.0
//        return collectionViewSize
//    }
//
//}
