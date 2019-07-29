//
//  ProductImageTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class ProductImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblPostType: UILabel!
    
    var ProductID: Int?
    var data = HomePageModel()
    weak var delegate: CellClickProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        imgProduct.image = data.imagefront.base64ToImage()
        lblProductName.text = data.title
        lblProductPrice.text = data.cost.toCurrency()
        lblDiscount.text = data.discount.toCurrency()
        lblDuration.text = "5 minutes ago"
        lblPostType.text = data.postType.capitalizingFirstLetter()
    }
    
    @objc
    func handerCellClick(){
        self.delegate?.cellXibClick(ID: data.product)
    }
}