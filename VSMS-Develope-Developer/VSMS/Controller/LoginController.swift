//
//  LoginController.swift
//  VSMS
//
//  Created by usah on 3/20/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import SCLAlertView
import SwiftyJSON


class LoginController: UIViewController {
    
    @IBOutlet weak var logo121: UIImageView!
    @IBOutlet weak var Loginbutton: UIButton!
    @IBOutlet weak var Registerbutton: UIButton!
    @IBOutlet weak var fbView: UIView!
    @IBOutlet weak var fbButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ShowDefaultNavigation()
        fbButton.addTarget(self, action: #selector(LogInFacebook), for: UIControl.Event.touchUpInside)
        
        
    }

    
    @IBAction func backClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func LogInFacebook()
    {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [Permission.publicProfile, Permission.email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                self.view.makeToast(error as? String)
            case .cancelled:
                self.view.makeToast("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.fetchUserFacebook()
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func fetchUserFacebook()
    {
        Message.Loading(from: self)
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"id,email,name,picture.height(961)"])) { (httpResponse, result, error) in
            if error == nil {
                performOn(.Main, closure: {
                    Message.DismissLoading()
                    
                    if result != nil {
                        let data = JSON(result!)
                        
                        AccountViewModel.IsUserExist(userName: "", fbKey: data["id"].stringValue, completion: { (result) in
                            if result {
                                self.view.makeToast("User existing")
                            }
                            else {
                                //UserDefaults.standard.set(profileImage, forKey: "profileImageURL")
                                let user = AccountViewModel()
                                user.lastname = data["id"].stringValue
                                user.firstname = data["name"].stringValue
                                user.email = data["email"].stringValue
                                PresentController.PushToSetNumberViewController(user: user, from: self)
                            }
                        })
                    }
                    
                })
            }
        }
        connection.start()
    }
}


