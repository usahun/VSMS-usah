//
//  NewlyTableViewCell.swift
//  VSMS
//
//  Created by usah on 6/18/19.
//  Copyright © 2019 121. All rights reserved.
//
import CollectionViewGridLayout
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
    var cellHeightCount: CGFloat = 0
    
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
        
        let NewPostListCell = UINib(nibName: "NewPostListCollectionViewCell", bundle: nil)
        NewlyPost.register(NewPostListCell, forCellWithReuseIdentifier: "NewPostCollectionCell_ID")
    
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
        
        let cell = NewlyPost.dequeueReusableCell(withReuseIdentifier: "NewPostCollectionCell_ID", for: indexPath) as!
            NewPostListCollectionViewCell
        cell.Img.image = ImgArr[indexPath.row]
        cell.lblProductName.text = "Honda Dream 2019"
        cell.lblProductPrice.text = "2000"
        cell.lblOldPrice.text = "2500"
        cellHeightCount = cellHeightCount + cell.layer.frame.height + 16
        print(cellHeightCount)
        return cell
    }
    
}


extension NewlyTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let collectionWidth = collectionView.bounds.width
       let collectionHeight = collectionView.bounds.height
       return CGSize(width: collectionWidth, height: collectionHeight/6	 - 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
