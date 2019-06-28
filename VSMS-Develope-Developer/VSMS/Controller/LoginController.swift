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

        
    }
    
    
    @IBAction func LoginbuttonTapped(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let loginpasswd = mainStoryboard.instantiateViewController(withIdentifier: "LoginPasswordController") as? LoginPasswordController else {
            print("can't fine Viewcontroller")
            return
        }
        
        navigationController?.pushViewController(loginpasswd, animated: true)
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    
    @IBAction func RegisterbuttonTapped(_ sender: Any) {
        
        let registerController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController
        self.present(registerController!, animated: true)
        
      
    }
    
}
