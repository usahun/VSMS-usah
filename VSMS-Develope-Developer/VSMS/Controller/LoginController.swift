//
//  LoginController.swift
//  VSMS
//
//  Created by usah on 3/20/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit


class LoginController: UIViewController {
    
    @IBOutlet weak var logo121: UIImageView!
    
    @IBOutlet weak var Loginbutton: UIButton!
    
    @IBOutlet weak var Registerbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HasTabNoNav()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.HasTabNoNav()
    }

    
}
