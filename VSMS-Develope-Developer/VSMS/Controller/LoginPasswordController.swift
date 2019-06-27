//
//  LoginPasswordController.swift
//  VSMS
//
//  Created by Vuthy Tep on 6/26/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class LoginPasswordController: UIViewController {
    
    @IBOutlet weak var txtnameorphone: UITextField!
    
    @IBOutlet weak var txtpassword: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
    

    @IBAction func btnlogin(_ sender: Any) {
        
//       let phonenumber = txtnameorphone.text
//       let password = txtpassword.text
//
//        if (phonenumber!.isEmpty) || (password!.isEmpty) {
//            print("Phone number \(String(describing: phonenumber)) or password \(String(describing: password)) is empty")
//            return
//        }
        
//        let jsonUrlstring = "http://192.168.1.239:8000/api/v1/rest-auth/login/"
//        guard let url = URL(string: jsonUrlstring) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, errr) in
//            print("Url ok")
//        }.resume()
        
        
        if txtnameorphone.text == "012345678" && txtpassword.text == "123456"{
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

                    guard let loginpasswd = mainStoryboard.instantiateViewController(withIdentifier: "NewHomepageViewController") as? NewHomepageViewController else {
                        print("can't fine Viewcontoller")
                        return
                    }

                    navigationController?.pushViewController(loginpasswd, animated: true)
                    navigationController?.navigationBar.tintColor = UIColor.white
        }
        else{
            let AlertMessage = UIAlertController(title: "Warning", message: "Incorrect Phone number and Password.", preferredStyle: .alert)
            AlertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(AlertMessage, animated: true, completion: nil)
        }
       
        
        
    }
    
    
    
}
