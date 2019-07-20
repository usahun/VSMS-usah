//
//  RegisterController.swift
//  VSMS
//
//  Created by usah on 3/20/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class RegisterController: UIViewController {
    
    @IBOutlet weak var textphone: UITextField!
    @IBOutlet weak var textpassword: UITextField!
    @IBOutlet weak var textconfirmPassword: UITextField!
    var defaultUser = UserDefaults.standard
    
//    func resetDefaults() {
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
//        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
//
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //resetDefaults()
    }
    
  
   
    @IBAction func submitTapped(_ sender: Any) {
        
        let data: Parameters = [
            "username": textphone.text!,
            "password": textconfirmPassword.text!,
            "groups": [1],
            "profile": [
                "telephone": textphone.text!
            ]
        ]
        let headers = [
            "Cookie": "",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        
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
        
        
        Alamofire.request(PROJECT_API.REGISTER, method: .post, parameters: data,encoding: JSONEncoding.default, headers: headers).responseJSON
            { response in
                switch response.result {
                case .success(let value) :
                    let json = JSON(value)
                    
//                    self.defaultUser.set(json["username"], forKey: "username")
//                    self.defaultUser.set(json["id"], forKey: "userid")
//                    self.defaultUser.set(self.textconfirmPassword, forKey: "password")
//                    
                    Message.SuccessMessage(message: "Your account has been register.", View: self, callback: {
                        //switching the screen
                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                    })
                    break
                case .failure(let error):
                    print(error)
                    break
                }
                
        }
        
        
    }
    
    
    

}
