//
//  PostsTableViewCell.swift
//  VSMS
//
//  Created by Rathana on 7/5/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var lblDuration: UILabel!
    
    //Internal Properties
    var ProID: Int?
    weak var delelgate: CellClickProtocol?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handerCellClick)))
    }
    
    @objc func handerCellClick(){
        self.delelgate?.cellXibClick(ID: self.ProID ?? 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func buttonTransterTapped(_ sender: Any) {
        print("Transfer")
    }
    
    @IBAction func buttonEditTepped(_ sender: Any) {
        print("Edit")
    }
    
    @IBAction func buttonDeleteTepped(_ sender: Any) {
        print("Delete")
    }

    
}
