//
//  LikesTableViewCell.swift
//  VSMS
//
//  Created by Rathana on 7/5/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class LikesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LikesImage: CustomImage!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPostType: UILabel!
    @IBOutlet weak var lblViewCount: UILabel!
    
    //Internal Properties
    var ProID: Int = -1
    weak var delegate: ProfileCellClickProtocol?
    var ProductData = LikeViewModel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func reload()
    {
        RequestHandle.LoadListProductByPostID(postID: ProductData.post) { (val) in
            performOn(.Main, closure: {
                self.LikesImage.LoadFromURL(url: val.imagefront)
                self.lblName.text = val.title.capitalizingFirstLetter()
                self.lblPrice.text = val.cost.toCurrency()
                self.lblDuration.text = val.create_at?.getDuration()
                self.lblPostType.SetPostType(postType: val.postType)
            })
        }
        RequestHandle.CountView(postID: self.ProductData.post) { (count) in
            performOn(.Main, closure: {
                self.lblViewCount.text = count.toString()+" Views"
            })
        }
    }
    
    @objc func handerCellClick(){
        self.delegate?.cellClickToDetail(ID: ProductData.post)
    }
    
}
