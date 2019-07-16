//
//  HomeUICollectionView.swift
//  VSMS
//
//  Created by Rathana on 7/15/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class HomeUICollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate{
   
    
  
    let imgArr = [UIImage(named:"Dream191"),
                  UIImage(named: "Dream192"),
                  UIImage(named: "Dream193"),
                  UIImage(named: "Dream193"),
                  UIImage(named: "Dream193")]
    var counter = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
         setTimer()
    }
    
    
    func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self, selector: #selector(changeImage),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
    @objc func changeImage() {
        
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            counter = 1
        }
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = self.imgArr[indexPath.row]
        }
        return cell
    }

}
