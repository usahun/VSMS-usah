//
//  ChangePasswordController.swift
//  VSMS
//
//  Created by Rathana on 8/16/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit

class ChangePasswordController: UIViewController {
  
    @IBOutlet weak var txtOldPassword: HideShowPasswordTextField!
    
    @IBOutlet weak var txtComfirmPassword: HideShowPasswordTextField!
    @IBOutlet weak var txtNewPassword: HideShowPasswordTextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPasswordTextField()
        // Do any additional setup after loading the view.
    }
    

}
extension ChangePasswordController: HideShowPasswordTextFieldDelegate {
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 7
    }
}

extension ChangePasswordController {
    private func setupPasswordTextField() {
        txtOldPassword.passwordDelegate = self
//        txtOldPassword.borderStyle = .none
//        txtOldPassword.clearButtonMode = .whileEditing
//        txtOldPassword.layer.borderWidth = 0.5
//        txtOldPassword.borderStyle = UITextField.BorderStyle.none
//        txtOldPassword.clipsToBounds = true
//        txtOldPassword.layer.cornerRadius = 0
//        
//        txtOldPassword.rightView?.tintColor = UIColor(red: 0.204, green: 0.624, blue: 0.847, alpha: 1)
    }
}
