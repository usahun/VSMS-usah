//
//  LoginPasswordController.swift
//  VSMS
//
//  Created by Vuthy Tep on 6/28/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class LoginPasswordController: UIViewController {
    
    @IBOutlet weak var textphonenumber: UITextField!
    
    @IBOutlet weak var textpassword: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func LoginbuttonTapped(_ sender: Any) {
        
        if textphonenumber.text == "012345678" && textpassword.text == "123456" {
            
             let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let loginpasswd = mainStoryboard.instantiateViewController(withIdentifier: "NewHomepageViewController") as? NewHomepageViewController else {
                print("can't fine Viewcontoller")
                return
            }
            
            navigationController?.pushViewController(loginpasswd, animated: true)
            navigationController?.navigationBar.tintColor = UIColor.white
        }else{
            let AlertMessage = UIAlertController(title: "Warning", message: "Incorrect Phone number and Password.", preferredStyle: .alert)
            AlertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(AlertMessage, animated: true, completion: nil)
        }
        
    }
    

}
