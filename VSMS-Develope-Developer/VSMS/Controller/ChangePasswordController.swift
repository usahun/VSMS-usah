//
//  ChangePasswordController.swift
//  VSMS
//
//  Created by Rathana on 8/16/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangePasswordController: UIViewController {
  
    @IBOutlet weak var txtOldPassword: HideShowPasswordTextField!
    @IBOutlet weak var txtComfirmPassword: HideShowPasswordTextField!
    @IBOutlet weak var txtNewPassword: HideShowPasswordTextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var oldPassword: String = ""
    var Newpassword: String = ""
    let headers: HTTPHeaders = [
        "Cookie": "",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization" : User.getUserEncoded(),
        ]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupPasswordTextField()
        textField()
        // Do any additional setup after loading the view.
        txtOldPassword.isSecureTextEntry.toggle()
        txtNewPassword.isSecureTextEntry.toggle()
        txtComfirmPassword.isSecureTextEntry.toggle()
    }
    
    func textField(){
        //colortextField
        txtOldPassword.attributedPlaceholder = NSAttributedString(string: "Old Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        txtNewPassword.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        txtComfirmPassword.attributedPlaceholder = NSAttributedString(string: "Comfirm Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        //cliptobounds
        btnSubmit.layer.cornerRadius = 8.0
        txtOldPassword.layer.cornerRadius = 10.0
        txtNewPassword.layer.cornerRadius = 10.0
        txtComfirmPassword.layer.cornerRadius = 10.0
        
        txtOldPassword.returnKeyType = .next
        txtNewPassword.returnKeyType = .next
        txtComfirmPassword.returnKeyType = .done
       
    }
    
    
    @IBAction func SubmitTapped(_ sender: Any) {
        
        let userphone = txtOldPassword.text!
        let password = txtNewPassword.text!
        let confirmpassword = txtComfirmPassword.text!
        
        if(userphone.isEmpty || password.isEmpty || confirmpassword.isEmpty){
            
            let myAlert = UIAlertController(title: "All field are need to quied", message: "All field are quied", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
            myAlert.addAction(okAlert)
            self.present(myAlert, animated: true, completion: nil)
        }
        if(password != confirmpassword)
        {
            let myAlert = UIAlertController(title: "Alert", message: "Passwords do not match. Please try again", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
            myAlert.addAction(okAlert)
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        var parameters: Parameters = [:]
        parameters["old_password"] = txtOldPassword.text!
        parameters["new_password"] = txtNewPassword.text!
        
        Alamofire.request(PROJECT_API.CHANGEPASSWORD,
                          method: .patch, parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: self.headers
            ).responseJSON{ response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let myAlert = UIAlertController(title: "Change Password", message: "You have successfully to the New password", preferredStyle: .alert)
                    let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                    myAlert.addAction(okAlert)
                    self.present(myAlert, animated: true, completion: nil)
                    User.setNewPassword(newPassword: password)
                    print(value)
                    print(json)
                case .failure(let error):
                    print(error)
                }
        }
    }
    

}
extension ChangePasswordController: HideShowPasswordTextFieldDelegate {
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 7
    }
}



