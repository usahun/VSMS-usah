//
//  PresentController.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/15/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import SideMenuSwift

class PresentController
{
    static func HomePage()
    {
        if let currentView = UIApplication.topViewController() {
            let SideMenuTab: SideMenuController = {
                let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenu") as! MyNavigation
                
                let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leftMenu") as! MenuViewController
                menuViewController.delegate = contentViewController
                
                let sideMenuController = SideMenuController(
                    contentViewController: contentViewController,
                    menuViewController: menuViewController)
                return sideMenuController
            }()
            currentView.present(SideMenuTab, animated: false, completion: nil)
        }
    }
    
    static func ProfileController()
    {
        if let currentView = UIApplication.topViewController() {
            let ProfileTab: UINavigationController = {
                let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
                return UINavigationController(rootViewController: profile)
            }()
            currentView.present(ProfileTab, animated: false, completion: nil)
        }
    }
    
    static func LogInandRegister()
    {
        if let currentView = UIApplication.topViewController() {
            let ProfileTab: UINavigationController = {
                let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
                return UINavigationController(rootViewController: profile)
            }()
            currentView.present(ProfileTab, animated: false, completion: nil)
        }
    }
    
    static func PushToEditPostViewController(postID: Int, from: UIViewController)
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostViewController") as? PostViewController
        {
            viewController.post_id = postID
            from.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    static func PushToEditProfileViewController(from: UIViewController)
    {
        if let editVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyAccountController") as? MyAccountController
        {
            from.navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    static func PushToVerifyViewController(telelphone: String, password: String, from: UIViewController, isLogin: Bool = false)
    {
        if let verifyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VerifyViewController") as? VerifyViewController
        {
            verifyVC.account.username = telelphone
            verifyVC.account.password = password
            verifyVC.is_login = isLogin
            from.navigationController?.pushViewController(verifyVC, animated: true)
        }
    }
}
