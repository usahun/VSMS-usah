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
    
    

    @IBAction func LoginbuttonTapped(_ sender: Any) {
        submitLogIn()
    }
    
    private func submitLogIn()
    {
        let parameters: Parameters=[
            "username":textphonenumber.text!,
            "password":textpassword.text!
        ]
        
        let headers = [
            "Cookie": ""
        ]
        
        Alamofire.request(PROJECT_API.LOGIN, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON
            { response in
                switch response.result
                {
                case .success(let value):
                    let user = JSON(value)
                    guard user["token"].stringValue != "" else
                    {
                        Message.AlertMessage(message: "Username and Password is incorrect! Please try agian.", header: "Warning", View: self, callback: {
                            self.textpassword.text = ""
                            self.checkTextField()
                        })
                        return
                    }
                    let data = JSON(user["user"])
                    User.setupNewUserLogIn(pk: data["pk"].stringValue.toInt(),
                                           username: data["username"].stringValue,
                                           firstname: data["first_name"].stringValue,
                                           password: self.textpassword.text!)
                    PresentController.ProfileController()
                case .failure(let error):
                    print(error)
                    print("log wrong")
                }
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
            self.submitLogIn()
        }
        return true
    }
}
