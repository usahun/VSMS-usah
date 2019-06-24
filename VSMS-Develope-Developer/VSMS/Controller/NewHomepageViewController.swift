//
//  NewHomepageViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/28/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import CoreLocation
import SideMenuSwift

class NewHomepageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItem()
        tableView.delegate = self
        tableView.dataSource = self
        
        let cellnib = UINib(nibName: "HomePageTableViewCell", bundle: nil)
        tableView?.register(cellnib, forCellReuseIdentifier: "ImageSlide")
        
         let searchbar = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView?.register(searchbar, forCellReuseIdentifier: "Searchbar")
        
        let discount = UINib(nibName: "DiscountTableViewCell", bundle: nil)
        tableView.register(discount, forCellReuseIdentifier: "discount")
        
        let newly = UINib(nibName: "NewlyTableViewCell", bundle: nil)
        tableView.register(newly, forCellReuseIdentifier: "newly")
        
        
        
        
        
       // sideMenuController?.delegate = self as! SideMenuControllerDelegate
        let menuBarButton = UIBarButtonItem(image: UIImage(named: "HamburgarIcon"), style: .done, target: self, action: #selector(menutap))
//        let menubutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menutap))
        self.navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc func menutap() {
        sideMenuController?.revealMenu()
        print("Your tap")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       let row = indexPath.row
        switch row {
        case 0:
            return 150
        case 1:
            return 114
        case 2:
            return 180
        case 3:
            return 200
        default:
            return 1
        }

    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageSlide", for: indexPath) as! HomePageTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Searchbar", for: indexPath) as! SearchTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier:"discount", for: indexPath) as! DiscountTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "newly", for: indexPath) as! NewlyTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "")
            return cell ?? UITableViewCell()
       	
        }
        
        
    }
    
   
}



