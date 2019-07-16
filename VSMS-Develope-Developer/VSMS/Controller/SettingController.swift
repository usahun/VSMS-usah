//
//  SettingController.swift
//  VSMS
//
//  Created by usah on 3/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SettingController: UIViewController {

    @IBOutlet weak var buttonactive: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.installBlurEffect()
      
    }
    
    @IBAction func activeclick(_ sender: UIButton) {
         print(buttonactive.titleLabel?.text ?? "")
        
        let text = buttonactive.titleLabel?.text!
        
        if text == String ("Active")
        {
            buttonactive.setTitle("Disactive", for: .normal)
            buttonactive.setTitleColor(.lightGray, for: .normal)
        }
        else {
           buttonactive.setTitle("Active", for: .normal)
            buttonactive.setTitleColor(.blue, for: .normal)
        }
    }
  
    

    @IBAction func btnLogoutHandler(_ sender: UIButton) {
        let user_default = UserDefaults.standard
        user_default.set(nil, forKey: "username")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let loginpasswd = mainStoryboard.instantiateViewController(withIdentifier: "LoginController") as? LoginController else {
                print("can't fine Viewcontroller")
                return
            }
            
            self.navigationController?.pushViewController(loginpasswd, animated: true)
        }

    }
}
    

