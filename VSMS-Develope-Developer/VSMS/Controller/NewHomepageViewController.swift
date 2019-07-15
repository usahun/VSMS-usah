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
import Alamofire
import SwiftyJSON

class NewHomepageViewController:
    UIViewController,
UITableViewDataSource,
UITableViewDelegate, RecordCountProtocol {
   
   //Properties
    @IBOutlet weak var tableView: UITableView?
    var ContentHeight: CGFloat = 1200
    var MaxHeightofContent: CGFloat = 0
    var willAppear: Bool = true
    var ProductID: Int = -1
    var productDetail: DetailViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        self.sideMenuController?.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItem()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.reloadData()
        
        let cellnib = UINib(nibName: "HomePageTableViewCell", bundle: nil)
        tableView?.register(cellnib, forCellReuseIdentifier: "ImageSlide")
        
         let searchbar = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView?.register(searchbar, forCellReuseIdentifier: "Searchbar")
        
        let discount = UINib(nibName: "DiscountTableViewCell", bundle: nil)
        tableView?.register(discount, forCellReuseIdentifier: "discount")
        
        let newly = UINib(nibName: "NewlyTableViewCell", bundle: nil)
        tableView?.register(newly, forCellReuseIdentifier: "newly")
    
       // sideMenuController?.delegate = self as! SideMenuControllerDelegate
        let menuBarButton = UIBarButtonItem(image: UIImage(named: "HamburgarIcon"), style: .done, target: self, action: #selector(menutap))
//        let menubutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menutap))
        self.navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc func menutap() {
        sideMenuController?.revealMenu()
    }
    
    
    func getHeighOfCollectionView(recordCount: CGFloat) {
        ContentHeight = CGFloat(recordCount)
        tableView?.reloadData()
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
            return 130
        case 2:
            return 200
        case 3:
            return ContentHeight
        default:
            return 60
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
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
            print(cell.cellHeightCount)
            MaxHeightofContent = view.frame.size.height
            cell.delegate = self
            cell.TableToCollectDelegate = self
            return cell
        case 4:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Loading..."
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DetailVC = segue.destination as? DetailViewController {
            DetailVC.ProductDetail = self.productDetail ?? DetailViewModel()
        }
    }
}


extension SideMenuController {
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.frame = UIScreen.main.bounds
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.frame = UIScreen.main.bounds
    }
}



extension NewHomepageViewController: SideMenuControllerDelegate {
    
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


extension NewHomepageViewController: CollectionToTableProtocol {
    func getFromCollectionCell(ProID: Int) {
        self.ProductID = ProID
        DetailViewModel.LoadProductByID(ProID: ProID) { (val) in
            self.productDetail = val
            self.performSegue(withIdentifier: "HomePageDetailSW", sender: self)
        }
        
    }
}
