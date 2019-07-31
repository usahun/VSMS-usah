//
//  DetailViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/12/19.
//  Copyright © 2019 121. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {
    
    //Internal Properties
    var ProductID:Int = -1
    var ProductDetail = DetailViewModel()
    var timer = Timer()
    var counter = 0
    var relateArr: [HomePageModel] = []
    var userdetail: Profile?
    
    
    //Master Propertise
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var CollectView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnLike: BottomDetail!
    
    
    //IBOutlet Propeties
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblCondition: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var lblUserPhoneNumber: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    
    
    @IBOutlet weak var txtTerm: UITextField!
    @IBOutlet weak var txtdeposit: UITextField!
    @IBOutlet weak var txtinterestRate: UITextField!
    @IBOutlet weak var txtprice: UITextField!
    
    @IBOutlet weak var lblmonthlypayment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imgProfilePic.addGestureRecognizer(tap)
        imgProfilePic.isUserInteractionEnabled = true
        txtinterestRate.text = "1.5"
        txtTerm.text = "1"
        
        txtTerm.bordercolor()
        txtinterestRate.bordercolor()
        txtdeposit.bordercolor()
        txtprice.bordercolor()
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.width * 0.5
        // Do any additional setup after loading the view.
        config()
        ImageSlideConfig()
        InitailDetail()
        LoadUserDetail()
        XibRegister()
        tblView.delegate = self
        tblView.dataSource = self
        
        performOn(.Main) {
            RequestHandle.LoadRelated(postType: self.ProductDetail.post_type,
                                      category: self.ProductDetail.category.toString(),
                                      modeling: self.ProductDetail.modeling.toString(),
                                      completion: { (val) in
                                        self.relateArr = val
                                        self.tblView.reloadData()
            })
        }
        
        txtprice.addTarget(self, action: #selector(CalculatorLoan), for: UIControl.Event.editingChanged)
        txtinterestRate.addTarget(self, action: #selector(CalculatorLoan), for: UIControl.Event.editingChanged)
        txtTerm.addTarget(self, action: #selector(CalculatorLoan), for: UIControl.Event.editingChanged)
    }
    
    
    

   
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContectViewController") as! ContectViewController
        vc.UserPostID = ProductDetail.created_by
        vc.userdetail = self.userdetail
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //Events Handler
    @IBAction func clickCall(_ sender: Any) {
        
    }
    
    @IBAction func clickSms(_ sender: Any) {
        Message.AlertMessage(message: "", header: "SMS", View: self) {
            
        }
    }
    
    @IBAction func clickLike(_ sender: Any) {
        Message.AlertMessage(message: "You have been like this product.", header: "LIKE", View: self) {
            
        }
    }
    
    @IBAction func clickLoan(_ sender: Any) {
        Message.AlertMessage(message: "", header: "LOAN", View: self) {
            
        }
    }
    
    
    //Function and Selector
    
    @objc
    func CalculatorLoan(){
        let Year = txtTerm.text?.toDouble() ?? 1
        let SalePrice = txtprice.text?.toDouble() ?? 0
        let rate = txtinterestRate.text?.toDouble() ?? 0
  
        let MonthCount = Year
        let interate = rate / 100
        let PowValue = pow((1 + interate), -(MonthCount))
        let UnderValue = (1 - PowValue) / interate
        let result = SalePrice / UnderValue
        
        if (txtprice.text == "") && (txtTerm.text == "") {
            lblmonthlypayment.text = " $0.00"
        }else{
         lblmonthlypayment.text = "\(result)".toCurrency()
        }
    }
    
   
    func config(){
        self.navigationItem.title = "Detail"
    }
    
    func InitailDetail(){
        lblProductName.text = ProductDetail.title
        lblProductPrice.text = ProductDetail.cost.toCurrency()
        lblOldPrice.text = ProductDetail.cost.toCurrency()
        lblBrand.text = ProductDetail.getBrand
        lblYear.text = ProductDetail.getYear
        lblCondition.text = ProductDetail.condition
        lblColor.text = ProductDetail.color
        lblDescription.text = ProductDetail.description
        lblPrice.text = ProductDetail.cost.toCurrency()
    }
    
    func LoadUserDetail(){
        User.getUserInfo(id: ProductDetail.created_by) { (Profile) in
            self.userdetail = Profile
            self.imgProfilePic.image = Profile.Profile
            self.lblProfileName.text = Profile.Name
            self.lblUserPhoneNumber.text = "Tel: \(Profile.PhoneNumber)"
            self.lblUserEmail.text = "Email: \(Profile.email)"
        }
    }
    
    func ImageSlideConfig(){
        CollectView.dataSource = self
        CollectView.delegate = self
        
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    func XibRegister(){
        tblView.register(UINib(nibName: "ProductGridTableViewCell",bundle: nil), forCellReuseIdentifier: "ProductGridCell")
    }
    
    func imageTapped(){
        
    }
    
    @objc func changeImage() {
        if counter < 4 {
            let index = IndexPath.init(item: counter, section: 0)
            self.CollectView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.CollectView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relateArr.count / 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "ProductGridCell", for: indexPath) as! ProductGridTableViewCell
        let index = indexPath.row * 2
        cell.data1 = relateArr[index]
        cell.data2 = relateArr[index + 1]
       // cell.delegate = self
        return cell
        //return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = self.ProductDetail.arrImage[indexPath.row]
        }
        return cell
    }

}


