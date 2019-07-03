//
//  RegisterController.swift
//  VSMS
//
//  Created by usah on 3/20/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire



class RegisterController: UIViewController {
    
    @IBOutlet weak var textphone: UITextField!
    
    
    @IBOutlet weak var textpassword: UITextField!
    
    @IBOutlet weak var textconfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        
        let userphone = textphone.text!
        let password = textpassword.text!
        let confirmpassword = textconfirmPassword.text!
        
        if (userphone.isEmpty || password.isEmpty || confirmpassword.isEmpty)
        {
           let myAlert = UIAlertController(title: "Alert", message: "All fields are requested in fill", preferredStyle: .alert)
            
            let okAlert = UIAlertAction(title: "ok", style: .default, handler: nil)
            myAlert.addAction(okAlert)
          self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if(password != confirmpassword)
        {
            let myAlert = UIAlertController(title: "Alert", message: "Passwords do not match. Please try again", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "ok", style: .default, handler: nil)
            myAlert.addAction(okAlert)
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        
        
    }
    
    @IBAction func backbuttonpress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   

}
