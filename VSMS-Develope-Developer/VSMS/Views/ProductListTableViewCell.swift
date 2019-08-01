//
//  ProductListTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProductImage: UIImageView!
    @IBOutlet weak var lblProductname: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblPostType: UILabel!
    @IBOutlet weak var lblView: UILabel!
    
    var ProductID: Int?
    var ProductData = HomePageModel()
    weak var delegate: CellClickProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        imgProductImage.image = ProductData.imagefront.base64ToImage()
        lblProductname.text = ProductData.title.capitalizingFirstLetter()
        lblProductPrice.text = ProductData.cost.toCurrency()
        lblDuration.text = ProductData.create_at?.getDuration()
        RequestHandle.CountView(postID: ProductData.product) { (count) in
            self.lblView.text = count.toString()+" Views"
        }

        
        lblPostType.text = ProductData.postType.capitalizingFirstLetter()
        if ProductData.postType == "sell" {
            lblPostType.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        else if ProductData.postType == "rent" {
            lblPostType.backgroundColor = #colorLiteral(red: 0.16155532, green: 0.6208058596, blue: 0.002179143718, alpha: 1)
        }
        else if ProductData.postType == "buy" {
            lblPostType.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
    
    @objc
    func handerCellClick(){
        self.delegate?.cellXibClick(ID: ProductData.product)
    }
    
}
