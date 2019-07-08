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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonTransterTapped(_ sender: Any) {
    }
    
    @IBAction func buttonEditTepped(_ sender: Any) {
    }
    
    @IBAction func buttonDeleteTepped(_ sender: Any) {
    }
    
    @IBAction func buttonShareTepped(_ sender: Any) {
    }
}
