//
//  PresentController.swift
//  VSMS
//
//  Created by Vuthy Tep on 8/15/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation

class PresentController
{
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
    
    static func PushToEditPostViewController(postID: Int, from: UIViewController)
    {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostViewController") as? PostViewController
        {
            from.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
