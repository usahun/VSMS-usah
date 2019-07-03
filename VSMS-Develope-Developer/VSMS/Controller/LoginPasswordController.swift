//
//  LoginPasswordController.swift
//  VSMS
//
//  Created by Vuthy Tep on 6/28/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire

class LoginPasswordController: UIViewController {
    
    @IBOutlet weak var textphonenumber: UITextField!
    
    @IBOutlet weak var textpassword: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    
    let URL_USER_LOGIN = "http://103.205.26.103:8000/api/v1/rest-auth/login/"
    let defaultValues = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //if user is already logged in switching to profile screen
     // self.defaultValues.set(nil, forKey: "username")
        if defaultValues.string(forKey: "username") != nil{
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyBoard.instantiateViewController(withIdentifier: "StockTranfer")
//            self.present(controller, animated: true, completion: nil)
//            
//            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StockTranfer") as? StockTranfer {
//                present(vc, animated: true, completion: nil)
//            }
            
//
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "StockTranfer") as! StockTranfer
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
                //printing response
                print(response)
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary

                    //if there is no error
                    //if(!(jsonData.value(forKey: "error") as! Bool)){
                      if(jsonData.count >= 2){
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "pk") as! Int
                        let userName = user.value(forKey: "username") as! String
//                        let userEmail = user.value(forKey: "email") as! String
//                        let userPhone = user.value(forKey: "phone") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
//                        self.defaultValues.set(userEmail, forKey: "useremail")
//                        self.defaultValues.set(userPhone, forKey: "userphone")
                        
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
        
//
//        if  textphonenumber.text == "012345678" && textpassword.text == "4444" {
//
//             let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            guard let loginpasswd = mainStoryboard.instantiateViewController(withIdentifier: "StockTranfer") as? StockTranfer else {
//                print("can't fine Viewcontoller")
//                return
//            }
//
//            navigationController?.pushViewController(loginpasswd, animated: true)
//            navigationController?.navigationBar.tintColor = UIColor.blue
//        }else{
//            let AlertMessage = UIAlertController(title: "Warning", message: "Incorrect Phone number and Password.", preferredStyle: .alert)
//            AlertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(AlertMessage, animated: true, completion: nil)
//        }
        
    }
    

    }
}