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
import DropDown

class MyNavigation: UINavigationController, leftMenuClick {
    
    weak var menuDelegate: navigationToHomepage?
    
    func cellClick(list: String) {
        menuDelegate?.menuClick(list: list)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rootVC:HomePageController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageController") as! HomePageController
        
        self.menuDelegate = rootVC
        self.viewControllers = [rootVC]
    }
}


class HomePageController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SliderCollection: UICollectionView!
    @IBOutlet weak var DiscountCollection: UICollectionView!
    @IBOutlet weak var btnImag: UIButton!
    @IBOutlet weak var btnGrid: UIButton!
    @IBOutlet weak var btnList: UIButton!
    
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var btnRent: UIButton!
    @IBOutlet weak var btnSell: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnBrand: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    
    
    var imgArr = [  UIImage(named:"Dream191"),
                    UIImage(named:"Dream192"),
                    UIImage(named:"Dream193")]
    
    var timer = Timer()
    var counter = 0
    var CellIdentifier = 3
    var IndexProduct = -1
    var ProductDetail = DetailViewModel()
    var searchFilter = SearchFilter()
    
    var bestDealArr: [HomePageModel] = []
    var allPostArr: [HomePageModel] = []
    
    var dd_category = DropDown()
    var categories: [String] = []
    var categoryRawData: [dropdownData] = []
    var dd_brand = DropDown()
    var brands: [String] = []
    var brandRawData: [dropdownData] = []
    var brandSubRawData: [dropdownData] = []
    var dd_year = DropDown()
    var years: [String] = []
    var yearRawData: [dropdownData] = []
    var modelsArr: [dropdownData] = []
    
    let now = Date()
    let pastDate = Date(timeIntervalSinceNow: -60 * 62)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
        setupNavigationBarItem()
        RegisterXib()
        SlidingPhoto()
        //txtSearch.disable()
        ConfigDrowDown()
        
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
        
        performOn(.Background) {
            Functions.getDropDownList(key: 5, completion: { (val) in
                self.modelsArr = val
            })
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.sideMenuController?.delegate = self
        self.tabBarController?.tabBar.isHidden = false
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
    
    
    
    ///////////////////functions & Selectors
    func configuration(){
        SliderCollection.delegate = self
        SliderCollection.dataSource = self
        
        DiscountCollection.delegate = self
        DiscountCollection.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        txtSearch.delegate = self
        
        btnBuy.addTarget(self, action: #selector(btnPostTypeHandler(_:)), for: .touchUpInside)
        btnRent.addTarget(self, action: #selector(btnPostTypeHandler(_:)), for: .touchUpInside)
        btnSell.addTarget(self, action: #selector(btnPostTypeHandler(_:)), for: .touchUpInside)
        
        btnCategory.addTarget(self, action: #selector(btnSearchHandler(_:)), for: .touchUpInside)
        btnBrand.addTarget(self, action: #selector(btnSearchHandler(_:)), for: .touchUpInside)
        btnYear.addTarget(self, action: #selector(btnSearchHandler(_:)), for: .touchUpInside)
        
        //config best deal flow layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (self.DiscountCollection.frame.width / 2) - 20, height: self.DiscountCollection.frame.height)
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        DiscountCollection.collectionViewLayout = layout
        
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
    
    @objc
    func btnPostTypeHandler(_ sender: UIButton){
        switch sender {
        case btnBuy:
            let buyVC = ListAllPostByTypeViewController()
            buyVC.parameter.type = "buy"
            self.navigationController?.pushViewController(buyVC, animated: true)
        case btnRent:
            let buyVC = ListAllPostByTypeViewController()
            buyVC.parameter.type = "rent"
            self.navigationController?.pushViewController(buyVC, animated: true)
        case btnSell:
            let buyVC = ListAllPostByTypeViewController()
            buyVC.parameter.type = "sell"
            self.navigationController?.pushViewController(buyVC, animated: true)
        default:
            print("default")
        }
    }
    
    @objc
    func btnSearchHandler(_ sender: UIButton){
        switch sender {
        case btnCategory:
            dd_category.show()
        case btnBrand:
            dd_brand.show()
        case btnYear:
            dd_year.show()
        default:
            print("")
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
    
    
    
    func ConfigDrowDown(){
        Functions.getDropDownList(key: 2) { (val) in
            self.categoryRawData = val
            self.categories = val.map{ $0.Text }
            self.dd_category.anchorView = self.btnCategory
            self.dd_category.dataSource = self.categories
            // Action triggered on selection
            self.dd_category.selectionAction = { [weak self] (index, item) in
                self?.btnCategory.setTitle(item, for: .normal)
                self!.dd_category.hide()
                
                self?.btnBrand.setTitle("Brand", for: .normal)
                self?.searchFilter.brand = ""
                self?.searchFilter.category = (self?.categoryRawData[index].ID)!
                self?.brandSubRawData = (self?.brandRawData.filter({$0.FKKey == self?.searchFilter.category}))!
                self?.brands = (self?.brandSubRawData.map{ $0.Text })!
                self?.dd_brand.dataSource = self!.brands
            }
        }
        
        Functions.getDropDownList(key: 4) { (val) in
            self.brandRawData = val
            self.brandSubRawData = val
            self.brands = val.map{$0.Text}
            self.dd_brand.anchorView = self.btnBrand
            self.dd_brand.dataSource = self.brands
            // Action triggered on selection
            self.dd_brand.selectionAction = { [weak self] (index, item) in
                self?.btnBrand.setTitle(item, for: .normal)
                self!.dd_brand.hide()
                
                self?.searchFilter.brand = (self?.brandSubRawData[index].ID)!
                self?.searchFilter.modelings = (self?.modelsArr.filter{ $0.FKKey == self?.searchFilter.brand }
                                                               .map{ $0.ID })!
            }
        }
        
        Functions.getDropDownList(key: 6) { (val) in
            self.yearRawData = val
            self.years = val.map{ $0.Text }
            self.dd_year.anchorView = self.btnYear
            self.dd_year.dataSource = self.years
            // Action triggered on selection
            self.dd_year.selectionAction = { [weak self] (index, item) in
                self?.btnYear.setTitle(item, for: .normal)
                self!.dd_year.hide()
                
                self?.searchFilter.year = self!.yearRawData[index].ID
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DetailVC = segue.destination as? DetailViewController {
            DetailVC.ProductDetail = self.ProductDetail
        }
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
            cell.ProductID = bestDealArr[indexPath.row].product
            cell.delegate = self
            return cell
        }
    }
}

extension HomePageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CellIdentifier == 2 {
            IndexProduct = -1
            print(allPostArr.count / 2)
            return allPostArr.count / 2
        }
        return allPostArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if CellIdentifier == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductImageCell", for: indexPath) as! ProductImageTableViewCell
            
            cell.data = allPostArr[indexPath.row]
            cell.delegate = self
            return cell
        }
        else if CellIdentifier == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductGridCell", for: indexPath) as! ProductGridTableViewCell
            
            let index = indexPath.row * 2
            cell.data1 = allPostArr[index]
            cell.data2 = allPostArr[index + 1]
            cell.delegate = self
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListTableViewCell
            
            cell.ProductData = allPostArr[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if CellIdentifier == 1 {
            return 350
        }
        else if CellIdentifier == 2 {
            return 180
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

extension HomePageController : CellClickProtocol {
    func cellXibClick(ID: Int) {
        DetailViewModel.LoadProductByID(ProID: ID) { (val) in
            self.ProductDetail = val
            self.performSegue(withIdentifier: "HomePageDetailSW", sender: self)
        }
    }
}

extension HomePageController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.txtSearch.endEditing(false)
        
        self.searchFilter.search = searchBar.text ?? ""
        let searchVC = SearchViewController()
        searchVC.parameter = self.searchFilter
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension HomePageController: navigationToHomepage {
    func menuClick(list: String) {
        
        if list == "profile" {
            let profileVC:TestViewController = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
            self.present(profileVC, animated: true, completion: nil)
        }
        else{
            sideMenuController?.hideMenu()
            let listVC = ListFromNavigationViewController()
            self.navigationController?.pushViewController(listVC, animated: true)
        }
    }
}


        
    



