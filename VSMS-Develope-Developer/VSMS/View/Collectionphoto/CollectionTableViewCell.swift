//
//  CollectionTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var postImagecollectionview: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 80)
        layout.scrollDirection = .horizontal
        postImagecollectionview?.collectionViewLayout = layout
        
        //collectionView?.dataSource = self
        //collectionView?.delegate = self
        postImagecollectionview?.clipsToBounds = true
        postImagecollectionview?.showsHorizontalScrollIndicator = false
        
        let cellphoto = UINib(nibName: "PhotoListCollectionViewCell", bundle: nil)
        postImagecollectionview?.register(cellphoto, forCellWithReuseIdentifier: "photoCell")
    }
}
