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
    
    var ProductID: Int?
    weak var delegate: CellClickProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick)))
    }
    
    @objc
    func handerCellClick(){
        self.delegate?.cellXibClick(ID: ProductID!)
    }

}
extension DiscountTableViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/2.0
        collectionViewSize.height = 50
       // collectionViewSize.height = collectionViewSize.height/4.0
        return collectionViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}
