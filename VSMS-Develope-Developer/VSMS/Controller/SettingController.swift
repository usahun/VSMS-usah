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
    @IBAction func backbtnpress(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    @IBAction func buttonLogoutTaptted(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "password")
       
    }
}
