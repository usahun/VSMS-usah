//
//  ProductGridTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class ProductGridTableViewCell: UITableViewCell {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    //record 1 properties
    @IBOutlet weak var img_1_Product: UIImageView!
    @IBOutlet weak var lbl_1_Productname: UILabel!
    @IBOutlet weak var lbl_1_Productprice: UILabel!
    @IBOutlet weak var lbl_1_discount: UILabel!
    @IBOutlet weak var lbl_1_duration: UILabel!
    
    //record 2 properties
    @IBOutlet weak var img_2_Productimage: UIImageView!
    @IBOutlet weak var lbl_2_Productname: UILabel!
    @IBOutlet weak var lbl_2_productprice: UILabel!
    @IBOutlet weak var lbl_2_duration: UILabel!
    @IBOutlet weak var lbl_2_discount: UILabel!
    
    var data1: HomePageModel?
    var data2: HomePageModel?
    var cellID: Int?
    weak var delegate: CellClickProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick1)))
        
        self.secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick2)))
    }
    
    @objc
    func handerCellClick1(){
        self.delegate?.cellXibClick(ID: data1!.product)
    }
    
    @objc
    func handerCellClick2(){
        self.delegate?.cellXibClick(ID: data2!.product)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if data1 != nil {
            lbl_1_Productname.text = data1?.title
            img_1_Product.image = data1?.imagefront.base64ToImage()
            lbl_1_Productname.text = data1?.title
            lbl_1_Productprice.text = data1?.cost.toCurrency()
            lbl_1_discount.attributedText = data1?.discount.toCurrency().strikeThrough()
        }
        
        if data2 != nil {
            lbl_2_Productname.text = data2?.title
            img_2_Productimage.image = data2?.imagefront.base64ToImage()
            lbl_2_Productname.text = data2?.title
            lbl_2_productprice.text = data2?.cost.toCurrency()
            lbl_2_discount.attributedText = data2?.discount.toCurrency().strikeThrough()
        }
    }
    
}
