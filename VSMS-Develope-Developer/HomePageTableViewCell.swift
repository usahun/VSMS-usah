//
//  HomePageTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/28/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class HomePageTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    @IBOutlet weak var SliderCollectionView: UICollectionView!
   
    
    let imgArr = [UIImage(named: "Dream191"),
                  UIImage(named: "Dream192"),
                  UIImage(named: "Dream193")]
    
    override func awakeFromNib() {
       
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 500, height: 150)
        layout.scrollDirection = .horizontal
        SliderCollectionView?.collectionViewLayout = layout
        self.SliderCollectionView.delegate = self
        self.SliderCollectionView.dataSource = self
        setTimer()
        
        let cellphoto = UINib(nibName: "ImgeSlideCollectionViewCell", bundle: nil)
        SliderCollectionView?.register(cellphoto, forCellWithReuseIdentifier: "Imagecell")
        
  
        // Initialization code
    }
    
    func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self, selector: #selector(autoSroll),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    
    var x = 1
    
    @objc func autoSroll() {
        if self.x < 2 {
            let indexPath = IndexPath(item: x, section: 0)
           self.SliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
           self.x = self.x + 1
        }else {
             self.x = 0
            self.SliderCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgArr.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = SliderCollectionView.dequeueReusableCell(withReuseIdentifier: "Imagecell", for: indexPath) as! ImgeSlideCollectionViewCell
        cell.Slideshow.image = self.imgArr[indexPath.row]
        return cell
        
    }
    
}


