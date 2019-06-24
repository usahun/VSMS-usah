//
//  MenuViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 6/24/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
   
    
    
    @IBOutlet weak var imageprofile: UIImageView!
    
    let titleArray = ["Your Profile","Your Posts","Your Like",
                     "Your Share","Setting","About Us","Term of Privancy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageprofile.layer.cornerRadius = imageprofile.frame.width * 0.5
        imageprofile.clipsToBounds = true
        
        
    }
   

}


