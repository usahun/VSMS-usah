//
//  DiscountTableViewCell.swift
//  VSMS
//
//  Created by usah on 6/13/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DiscountTableViewCell: UITableViewCell,UICollectionViewDelegate
,UICollectionViewDataSource{
    
    var discount: [HomePageModel] = []
    
    @IBOutlet weak var Imagediscount: UICollectionView!
//    let imgArr = [UIImage(named: "HondaClick2019"),
//                  UIImage(named: "HondaScoopy2019"),
//                  UIImage(named: "HondaDream2019"),
//                  UIImage(named: "Kawasaki2019")]
//
//    var name = ["HondaClick2019","HondaScoopy2019","HondaDream2019","Kawasaki2019"]
//    var oldprice = ["3000","300","2500","3000","2400","2500"]
//    var discountprice = ["2000","1700","2000","1800","2200"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout()
       layout.itemSize = CGSize(width: 90, height: 90)
        layout.scrollDirection = .horizontal
        Imagediscount.collectionViewLayout = layout
        self.Imagediscount.delegate = self
        self.Imagediscount.dataSource = self
        
        API()
        
        let cellimge = UINib(nibName: "DiscountCollectionViewCell", bundle: nil)
        Imagediscount.register(cellimge, forCellWithReuseIdentifier: "imgediscount")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func API() {
        
        Alamofire.request(PROJECT_API.BESTDEAL, method: .get,encoding: JSONEncoding.default).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.discount = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["front_image_base64"].stringValue,discount: $0["discount"].stringValue)
                        })!
                   // self.recordCount = json.count
                    print(self.discount)
                    self.Imagediscount.reloadData()
                case .failure(let error):
                    print("error")
                }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.discount.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = Imagediscount.dequeueReusableCell(withReuseIdentifier: "imgediscount", for: indexPath) as! DiscountCollectionViewCell
        cell.image.image = self.discount[indexPath.row].imagefront.base64ToImage()
        cell.MotoName.text = discount[indexPath.row].title
        cell.MotoPrice.text = "$ \(discount[indexPath.row].cost)"
        cell.MotoDiscount.text = "$\(discount[indexPath.row].discount)"
        return cell
    }
    
}


