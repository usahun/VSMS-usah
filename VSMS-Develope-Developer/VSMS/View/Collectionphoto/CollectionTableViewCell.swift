//
//  CollectionTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, refreshCollectionProtocol {

    @IBOutlet weak var postImagecollectionview: UICollectionView!

    func refreshCollection() {
        postImagecollectionview.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
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
