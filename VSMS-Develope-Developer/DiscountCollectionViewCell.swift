//
//  DiscountCollectionViewCell.swift
//  VSMS
//
//  Created by usah on 6/13/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class DiscountCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var MotoDiscount: UILabel!
    @IBOutlet weak var MotoPrice: UILabel!
    @IBOutlet weak var MotoName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image.clipsToBounds = true
    }

}
extension DiscountTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/2.0
       // collectionViewSize.height = collectionViewSize.height/4.0
        return collectionViewSize
    }
}
