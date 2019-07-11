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
    
    let URL_USER_LOGIN = "http://103.205.26.103:8000/api/v1/rest-auth/login/"
    let defaultValues = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //if user is already logged in switching to profile screen

        self.defaultValues.set(nil, forKey: "username")
        if defaultValues.string(forKey: "username") != nil{
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
        
    }
    

    @IBAction func LoginbuttonTapped(_ sender: Any) {
        
        let parameters: Parameters=[
            "username":textphonenumber.text!,
            "password":textpassword.text!
        ]
        
        let headers = [
            "Cookie": ""
        ]
        
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON
            { response in

                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                      if(jsonData.count >= 2){
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary

                        //getting user values
                        let userId = user.value(forKey: "pk") as! Int
                        let userName = user.value(forKey: "username") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(self.textpassword.text, forKey: "password")
                        
                        //switching the screen
                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "StockTranfer") as! StockTranfer
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        let AlertMessage = UIAlertController(title: "Warning", message: "Invalid username or password", preferredStyle: .alert)
                        self.present(AlertMessage, animated: true, completion: nil)
                    }
            
           }
        
    }
    

    }

}
