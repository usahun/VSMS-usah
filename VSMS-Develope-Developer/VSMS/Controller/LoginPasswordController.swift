//
//  LoginPasswordController.swift
//  VSMS
//
//  Created by Vuthy Tep on 6/28/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase

class LoginPasswordController: UIViewController {
    
    @IBOutlet weak var textphonenumber: UITextField!
    
    @IBOutlet weak var textpassword: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    
    
    let defaultValues = UserDefaults.standard
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginbutton.reloadInputViews()
        navigationController?.navigationBar.isHidden = true
        //navigationController?.navigationBar.barTintColor = UIColor.blue

        //if user is already logged in switching to profile screen
        self.ShowDefaultNavigation()
        self.HasNavNoTab()
        
        textphonenumber.returnKeyType = .next
        textphonenumber.delegate = self
        
        textpassword.returnKeyType = .done
        textpassword.addDoneButtonOnKeyboard()
        textpassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        textpassword.text = ""
        textphonenumber.text = ""
    }
    

    @IBAction func LoginbuttonTapped(_ sender: Any) {

        if IsNilorEmpty(value: textphonenumber.text) {
            textphonenumber.becomeFirstResponder()
            return
        }
        
        if IsNilorEmpty(value: textpassword.text) {
            textpassword.becomeFirstResponder()
            return
        }
        
        let phonenumber = textphonenumber.text!
        let password = textpassword.text!
    
        PhoneAuthProvider.provider().verifyPhoneNumber(phonenumber.ISOTelephone(), uiDelegate: nil)
        { (verificationID, error) in
            if let error = error {
                print(error)
                Message.AlertMessage(message: "\(error)", header: "Error", View: self, callback: {
                    self.textphonenumber.text = ""
                    self.textpassword.text = ""
                })
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            PresentController.PushToVerifyViewController(telelphone: phonenumber, password: password, from: self, isLogin: true)
        }
        
    }

}

extension LoginPasswordController
{
    func checkTextField()
    {
        if textphonenumber.text == "" {
            textphonenumber.becomeFirstResponder()
        }
        else if textpassword.text == "" {
            textpassword.becomeFirstResponder()
        }
    }
}

extension LoginPasswordController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textphonenumber
        {
            textField.resignFirstResponder()
            textpassword.becomeFirstResponder()
        }
        else if textField == textpassword
        {
            textField.resignFirstResponder()
        }
        return true
    }
}
