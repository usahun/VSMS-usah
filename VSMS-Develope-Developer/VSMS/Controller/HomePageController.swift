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
    @IBOutlet weak var btnImag: UIButton!
    @IBOutlet weak var btnGrid: UIButton!
    @IBOutlet weak var btnList: UIButton!
    
    
    var imgArr = [  UIImage(named:"Dream191"),
                    UIImage(named:"Dream192"),
                    UIImage(named:"Dream193")]
    
    var timer = Timer()
    var counter = 0
    var CellIdentifier = 3
    var IndexProduct = 0
    
    var bestDealArr: [HomePageModel] = []
    var allPostArr: [HomePageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SliderCollection.delegate = self
        SliderCollection.dataSource = self
        
        DiscountCollection.delegate = self
        DiscountCollection.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupNavigationBarItem()
        RegisterXib()
        SlidingPhoto()
        
        performOn(.HighPriority) {
            RequestHandle.LoadBestDeal(completion: { (val) in
                self.bestDealArr = val
                self.DiscountCollection.reloadData()
            })
        }
        
        performOn(.Main) {
            RequestHandle.LoadAllPosts(completion: { (val) in
                self.allPostArr = val
                self.tableView.reloadData()
            })
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //this is for direction
        layout.minimumInteritemSpacing = 0 // this is for spacing between cells
        layout.itemSize = CGSize(width: (self.DiscountCollection.frame.width / 2) - 20, height: self.DiscountCollection.frame.height)
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        
        DiscountCollection.collectionViewLayout = layout
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.sideMenuController?.delegate = self
    }
    
    
    @IBAction func imgClick(_ sender: Any) {
        refrestButtonFilter(type: 1)
    }
    @IBAction func gridClick(_ sender: Any) {
        refrestButtonFilter(type: 2)
    }
    @IBAction func listClick(_ sender: Any) {
        refrestButtonFilter(type: 3)
    }
    
    func refrestButtonFilter(type: Int) {
        switch type {
        case 1:
            btnImag.setImage(UIImage(named:"img_active"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail"), for: .normal)
            btnList.setImage(UIImage(named:"list"), for: .normal)
            self.CellIdentifier = type
            self.tableView.reloadData()
        case 2:
            btnImag.setImage(UIImage(named:"img"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail_active"), for: .normal)
            btnList.setImage(UIImage(named:"list"), for: .normal)
            self.CellIdentifier = type
            self.tableView.reloadData()
        case 3:
            btnImag.setImage(UIImage(named:"img"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail"), for: .normal)
            btnList.setImage(UIImage(named:"list_active"), for: .normal)
            self.CellIdentifier = type
            self.tableView.reloadData()
        default: break
        }
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
    
    
    func RegisterXib(){
        let imagehomepage = UINib(nibName: "DiscountCollectionViewCell", bundle: nil)
        DiscountCollection.register(imagehomepage, forCellWithReuseIdentifier: "imgediscount")
        tableView.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        tableView.register(UINib(nibName: "ProductImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductImageCell")
        tableView.register(UINib(nibName: "ProductGridTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductGridCell")
    }
    
    func SlidingPhoto(){
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        
        let menuBarButton = UIBarButtonItem(image: UIImage(named: "HamburgarIcon"), style: .done, target: self, action: #selector(menutap))
        self.navigationItem.leftBarButtonItem = menuBarButton
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
            return bestDealArr.count
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
            cell.MotoName.text = bestDealArr[indexPath.row].title
            cell.image.image = bestDealArr[indexPath.row].imagefront.base64ToImage()
            cell.MotoPrice.text = bestDealArr[indexPath.row].cost.toCurrency()
            cell.MotoDiscount.text = bestDealArr[indexPath.row].cost.toCurrency()
            return cell
        }
    }
}

extension HomePageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CellIdentifier == 2 {
            IndexProduct = 0
            return allPostArr.count / 2
        }
        return allPostArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if CellIdentifier == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductImageCell", for: indexPath) as! ProductImageTableViewCell
            cell.imgProduct.image = allPostArr[indexPath.row].imagefront.base64ToImage()
            cell.lblProductName.text = allPostArr[indexPath.row].title
            cell.lblProductPrice.text = allPostArr[indexPath.row].cost.toCurrency()
            cell.lblDiscount.text = allPostArr[indexPath.row].discount.toCurrency()
            cell.lblDuration.text = "1 Hours ago"
            return cell
        }
        else if CellIdentifier == 2 {
            index
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductGridCell", for: indexPath) as! ProductGridTableViewCell
            cell.img_2_Productimage.image = allPostArr[indexPath.row].imagefront.base64ToImage()
            
            cell.img_1_Product.image = allPostArr[indexPath.row + 1].imagefront.base64ToImage()
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListTableViewCell
            cell.imgProductImage.image = allPostArr[indexPath.row].imagefront.base64ToImage()
            cell.lblProductname.text = allPostArr[indexPath.row].title
            cell.lblDuration.text = "1 Hours ago"
            cell.lblProductPrice.text = allPostArr[indexPath.row].cost.toCurrency()
            cell.lblDiscountPrice.text = allPostArr[indexPath.row].discount.toCurrency()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if CellIdentifier == 1 {
            return 350
        }
        else if CellIdentifier == 2 {
            return 160
        }
        else {
            return 125
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
