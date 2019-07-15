//
//  HomeController.swift
//  VSMS
//
//  Created by Rathana on 3/13/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SideMenuSwift

class HomePageController: UIViewController{
   
 
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var SliderCollection: UICollectionView!
    
    @IBOutlet weak var DiscountCollection: UICollectionView!
    
    var imgArr = [  UIImage(named:"Dream191"),
                    UIImage(named:"Dream192"),
                    UIImage(named:"Dream193")]
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        SliderCollection.delegate = self
        SliderCollection.dataSource = self
        
        DiscountCollection.delegate = self
        DiscountCollection.dataSource = self
        setupNavigationBarItem()
      
     
        
        RegisterXib()
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        
        let menuBarButton = UIBarButtonItem(image: UIImage(named: "HamburgarIcon"), style: .done, target: self, action: #selector(menutap))
         self.navigationItem.leftBarButtonItem = menuBarButton
    }
    
    func RegisterXib(){
        let imagehomepage = UINib(nibName: "DiscountCollectionViewCell", bundle: nil)
        DiscountCollection.register(imagehomepage, forCellWithReuseIdentifier: "imgediscount")

    }
    override func viewWillAppear(_ animated: Bool) {
        self.sideMenuController?.delegate = self
    }
    
    @objc func menutap() {
        sideMenuController?.revealMenu()
       
    }
    
    @objc func changeImage() {
        
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.SliderCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.SliderCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
           
            counter = 1
        }
        
    }
    
    private func setupNavigationBarItem() {
        
        let logo = UIImage(named: "HamburgarIcon")
        let menu = UIButton(type: .system)
        menu.setImage(logo, for: .normal)
        
        // navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menu)
        menu.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        menu.tintColor = UIColor.lightGray
        
        //logo
        let menubutton = UIBarButtonItem(customView: menu)
        let logoImage = UIImage.init(named: "121logo")
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x:0, y: 0, width: 0, height: 0)
        logoImageView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        //   (-40, 0, 150, 25)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -25
        navigationItem.leftBarButtonItems = [menubutton, imageItem]
        let button = UIButton(type: .custom)
        
        //set image for button
        button.setImage(UIImage(named: "flatenglish"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive =  true
        let barButton = UIBarButtonItem(customView: button)
        
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    
}

    
extension HomePageController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == SliderCollection {
            return imgArr.count
        }
        else {
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == SliderCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath)
            if let vc = cell.viewWithTag(111) as? UIImageView {
                vc.image = imgArr[indexPath.row]
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgediscount", for: indexPath) as! DiscountCollectionViewCell
            return cell
        }
    }
    
    
}

extension HomePageController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        view.frame = UIScreen.main.bounds
    }
    
    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        view.frame = UIScreen.main.bounds
    }
    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        view.frame = UIScreen.main.bounds
    }
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        view.frame = UIScreen.main.bounds
    }
    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        view.frame = UIScreen.main.bounds
    }
}
