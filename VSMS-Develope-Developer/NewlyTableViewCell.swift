//
//  NewlyTableViewCell.swift
//  VSMS
//
//  Created by usah on 6/18/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class NewlyTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
  
    
    @IBOutlet weak var NewlyPost: UICollectionView!
    let ImgArr = [
                 UIImage(named: "HondaClick2019"),
                 UIImage(named: "HondaScoopy2019"),
                 UIImage(named: "HondaDream2019"),
                 UIImage(named: "Kawasaki2019"),
                 UIImage(named: "HondaClick2019"),
                 UIImage(named: "HondaScoopy2019"),
                 UIImage(named: "HondaDream2019"),
                 UIImage(named: "Kawasaki2019"),
                 UIImage(named: "HondaClick2019"),
                 UIImage(named: "HondaScoopy2019"),
                 UIImage(named: "HondaDream2019"),
                 UIImage(named: "Kawasaki2019")]
    
//    var name = ["HondaClick2019","HondaScoopy2019","HondaDream2019","Kawasaki2019"]
//    var price = ["2000"]
//
    
   
    
    var collectionViewFlolayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 90, height: 90)
       // layout.scrollDirection = .horizontal
        NewlyPost.collectionViewLayout = layout
        self.NewlyPost.delegate = self
        self.NewlyPost.dataSource = self
        
        
        let cellimage = UINib(nibName: "GreditImageCollectionViewCell", bundle: nil)
        NewlyPost.register(cellimage, forCellWithReuseIdentifier: "greditImage")
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ImgArr.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = NewlyPost.dequeueReusableCell(withReuseIdentifier: "greditImage", for: indexPath) as!
            GreditImageCollectionViewCell
         cell.greditimage.image = self.ImgArr[indexPath.row]
        return cell
    }
    
}

extension NewlyTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let collectionWidth = collectionView.bounds.width
       return CGSize(width: collectionWidth/2 - 8, height: collectionWidth/2 - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
