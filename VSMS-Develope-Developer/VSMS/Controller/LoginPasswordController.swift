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
    }
    
    

    @IBAction func LoginbuttonTapped(_ sender: Any) {
        
        let parameters: Parameters=[
            "username":textphonenumber.text!,
            "password":textpassword.text!
        ]
        
        let headers = [
            "Cookie": ""
        ]
        
        Alamofire.request(PROJECT_API.LOGIN, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON
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
                        
//                        //switching the screen
//                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                        guard let Profile = mainStoryboard.instantiateViewController(withIdentifier: "TestViewController") as? TestViewController else {
//                            print("can't fine Viewcontroller")
//                            return
//                        }
//                        
//                        self.navigationController?.pushViewController(Profile, animated: true)
//                        self.dismiss(animated: false, completion: nil)
                        
                        self.navigationController?.popToRootViewController(animated: true)
                    }else{
                        //error message in case of invalid credential
                        let AlertMessage = UIAlertController(title: "Warning", message: "Invalid username or password", preferredStyle: .alert)
                        let OKbutton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        AlertMessage.addAction(OKbutton)
                        self.present(AlertMessage, animated: true, completion: nil)
                    }
            
           }
        
    }
    

    }

}
