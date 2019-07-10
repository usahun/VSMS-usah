//
//  CustomTabBarController.swift
//  VSMS
//
//  Created by Vuthy Tep on 6/29/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import SideMenuSwift

enum VSMSTabBar: Int {
    case home, camera, profile
    
    var title: String {
        switch self {
        case .home:
         return "Home"
        case .camera:
         return "Camera"
        case .profile:
         return "Profile"
        
        }
    }
    
    var image: UIImage {
        switch self {
        case .home:
            return UIImage.init(named: "icons8-home-50")!
        case .camera:
            return UIImage.init(named: "icons8-camera-50")!
        case .profile:
            return UIImage.init(named: "icon-messages-app-27x20")!
        }
    }
}

class CustomTabBarController: UITabBarController {
    
    override var tabBar: UITabBar {
        let _tabar = super.tabBar
        _tabar.barTintColor = .white
        _tabar.isTranslucent = false
        return _tabar
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setuptabBar()
        configureSideMenu()
    }
    
    private func configureSideMenu() {
        SideMenuController.preferences.basic.menuWidth = 240
        SideMenuController.preferences.basic.defaultCacheKey = "0"
        SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
        
    }
    
    fileprivate func setuptabBar () {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenu")
        
                let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leftMenu")
        
                let sideMenuController = SideMenuController(
                    contentViewController: contentViewController,
                    menuViewController: menuViewController)
        
        let cameratap = storyBoard.instantiateViewController(withIdentifier: "PostAdViewController")
        let profiletap = storyBoard.instantiateViewController(withIdentifier: "TestViewController")
        
        
        let profile = UINavigationController(rootViewController: profiletap)
        let camera = UINavigationController(rootViewController: cameratap)
        
        //let HomePageVC = UINavigationController(rootViewController:Homepage )
        //let Profile = UINavigationController(rootViewController: LoginController())
        
        //Profile.tabBarItem.image = UIImage(named: "icon-messages-app-27x20")
        //HomePageVC.tabBarItem.image = UIImage(named: "icons8-home-50")
      
        //HomePageVC.tabBarItem.selectedImage = UIImage.
        
        viewControllers = [sideMenuController,camera, profile]
        
        for (index, bar) in self.tabBar.items!.enumerated() {
            bar.image = VSMSTabBar(rawValue: index)?.image
            bar.title = VSMSTabBar(rawValue: index)?.title
        }
        
    }

}
