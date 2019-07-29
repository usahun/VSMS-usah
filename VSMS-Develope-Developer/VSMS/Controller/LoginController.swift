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
    
    @IBAction func LoginbuttonTapped(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let loginpasswd = mainStoryboard.instantiateViewController(withIdentifier: "LoginPasswordController") as? LoginPasswordController else {
            print("can't fine Viewcontroller")
            return
        }
        
        navigationController?.pushViewController(loginpasswd, animated: true)
    }
    
    
    @IBAction func RegisterbuttonTapped(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let register = mainStoryboard.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController else {
            print("can't fine Viewcontroller")
            return
        }
        
        navigationController?.pushViewController(register, animated: true)
    }
    
}
