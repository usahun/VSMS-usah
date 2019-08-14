//
//  ProductListTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {


    @IBOutlet weak var imgProductImage: CustomImage!
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
    
    func reload()
    {
        imgProductImage.LoadFromURL(url: ProductData.imagefront)
        lblProductname.text = ProductData.title.capitalizingFirstLetter()
        lblProductPrice.text = ProductData.cost.toCurrency()
        lblDuration.text = ProductData.create_at?.getDuration()
        lblPostType.SetPostType(postType: ProductData.postType)
        
        RequestHandle.CountView(postID: self.ProductData.product) { (count) in
            performOn(.Main, closure: {
                self.lblView.text = count.toString()+" Views"
            })
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    @objc
    func handerCellClick(){
        self.delegate?.cellXibClick(ID: ProductData.product)
    }
    
}
