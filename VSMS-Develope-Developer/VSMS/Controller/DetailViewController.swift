//
//  DetailViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 7/12/19.
//  Copyright © 2019 121. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController {
    
    //Internal Properties
    var ProductID:Int = -1
    var ProductDetail = DetailViewModel()
    var timer = Timer()
    var counter = 0
    
    //Master Propertise
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var CollectView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.width * 0.5
        // Do any additional setup after loading the view.
        ImageSlideConfig()
        InitailDetail()
        LoadUserDetail()
    }
    
    //Function and Selector
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
            self.imgProfilePic.image = Profile.Profile
            self.lblProfileName.text = Profile.Name
            self.lblUserPhoneNumber.text = "Tel: \(Profile.PhoneNumber)"
            self.lblUserEmail.text = "Email: \(Profile.Email)"
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
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
