//
//  AppDelegate.swift
//  VSMS
//
//  Created by Vuthy Tep on 2/22/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SideMenuSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,CLLocationManagerDelegate,LocationServiceDelegate {
   
    
    var locationservice = LocationService.sharedInstance
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyChN5VYq3X6RKvoFeIRfz0WNmC31FrZ0wg")
        GMSPlacesClient.provideAPIKey("AIzaSyChN5VYq3X6RKvoFeIRfz0WNmC31FrZ0wg")
        // Override point for customization after application launch.
//        window?.rootViewController = NewViewController()
//        window?.makeKeyAndVisible()
        
       // LocationService.sharedInstance.delegate = self
        
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenu")
        
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leftMenu")
        
        let sideMenuController = SideMenuController(
            contentViewController: contentViewController,
            menuViewController: menuViewController)
       
        
//
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
//
        self.window?.rootViewController = sideMenuController
        self.window?.makeKeyAndVisible()
        
        configureSideMenu()
        locationservice.delegate = self
        print(locationservice.lastLocation as Any)
        return true
    }
    
    private func configureSideMenu() {
        SideMenuController.preferences.basic.menuWidth = 240
        SideMenuController.preferences.basic.defaultCacheKey = "0"
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func tracingLocation(currentLocation: CLLocation) {
        locationservice.lastLocation = currentLocation
    }
    
    func tracingLocationDidFailWithError(error: Error) {
        
    }


}

