//
//  TestViewController.swift
//  VSMS
//
//  Created by usah on 3/10/19.
//  Copyright © 2019 121. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class TestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mysegmentControl: UISegmentedControl!
    
    var post = ["Posts","Likes"]
    var imgprofile = ImageProfileModel()
    
    var postArr: [ProfileModel] = []
    var likeArr: [LikebyUserModel] = []
    var loanArr: [String] = []
    
    var index = 0
    var productDetail: DetailViewModel?
    //var ProductDetail = ProfileModel()
    var dpatch = DispatchGroup()
    
    lazy var postRefresher: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor.gray
        refresh.center = self.view.center
        refresh.addTarget(self, action: #selector(LoadAllPostByUser), for: .valueChanged)
        
        return refresh
    }()
    
    lazy var likeRefresher: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor.gray
        refresh.center = self.view.center
        refresh.addTarget(self, action: #selector(LoadAllPostLike), for: .valueChanged)
        
        return refresh
    }()

    
    let headers: HTTPHeaders = [
        "Cookie": "",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization" : User.getUserEncoded(),
        ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = postRefresher
        self.navigationController?.navigationBar.isHidden = false
        mysegmentControl.setTitle("POSTS(\(postArr.count))", forSegmentAt: 0)
        mysegmentControl.setTitle("LIKES(\(likeArr.count))", forSegmentAt: 1)
        mysegmentControl.setTitle("LOANS(0)", forSegmentAt: 2)
        
        //Check User is Log in
        User.IsAuthenticated(view: self) {
            return
        }
        
        tableView.delegate = self
        tableView.dataSource = self
       
        profileImage.layer.cornerRadius = profileImage.frame.width * 0.5
        profileImage.clipsToBounds = true

        //navigationController?.navigationBar.installBlurEffect()
        
        /////// Calling Functions
        XibRegister()
        
        Alamofire.request(PROJECT_API.POST_BYUSER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                let json = JSON(value)
                    self.postArr = (json["results"].array?.map{

                        ProfileModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,base64Img: $0["front_image_base64"].stringValue)
                        } ?? [])
                    print(self.postArr)

                    self.tableView.reloadData()
                case .failure:
                    print("error")
                }

        }
        performOn(.Main) {
            self.LoadUserProfileInfo()
        }
        performOn(.Background) {
            self.LoadAllPostLike()
        }
    }
    
    
    ///functions and Selectors
    func XibRegister(){
        let posts = UINib(nibName: "PostsTableViewCell", bundle: nil)
        tableView.register(posts, forCellReuseIdentifier: "Postcell")
        
        let likes = UINib(nibName: "LikesTableViewCell", bundle: nil)
        tableView.register(likes, forCellReuseIdentifier: "likesCell")
    }
    
    func profileandCover(){
        CoverImage.image = imgprofile.profile.base64_cover_image.base64ToImage()
        profileImage.image = imgprofile.profile.base64_profile_image.base64ToImage()
        LabelName.text = imgprofile.name
    }
    
    func LoadUserProfileInfo(){
        Alamofire.request(PROJECT_API.USER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.imgprofile = ImageProfileModel(json: json)
                    self.profileandCover()
                case .failure:
                    print("error")
                }
        }
    }
    
    @objc
    func LoadAllPostByUser(){
        Alamofire.request(PROJECT_API.POST_BYUSER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.postArr = (json["results"].array?.map{
                        
                        ProfileModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,base64Img: $0["front_image_base64"].stringValue)
                        } ?? [])
                    
                    self.mysegmentControl.setTitle("POSTS(\(self.postArr.count))", forSegmentAt: 0)
                    self.postRefresher.endRefreshing()

                    performOn(.Main, closure: {
                        self.tableView.reloadData()
                    })
                    
                case .failure:
                    print("error")
                }
        }
    }
    

    @objc
    func LoadAllPostLike() {
        Alamofire.request(PROJECT_API.LIKEBYUSER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON

            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.likeArr = (json["results"].array?.map{
                        LikebyUserModel(post: $0["post"].stringValue.toInt(), likeby: $0["like_by"].stringValue.toInt())
                        }) ?? []
                    
                    
                    self.mysegmentControl.setTitle("LIKES(\(self.likeArr.count))", forSegmentAt: 1)
                    self.likeRefresher.endRefreshing()
                    
                    performOn(.Main, closure: {
                        self.tableView.reloadData()
                    })
                    
                case .failure:
                    print("error")
                }
        }
    }

    
    @IBAction func swicthChange(_ sender: UISegmentedControl) {
        index = mysegmentControl.selectedSegmentIndex
        if index == 0 {
            tableView.refreshControl = postRefresher
        }
        else if index == 1 {
            tableView.refreshControl = likeRefresher
        }
        else{
            
        }
        self.tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == 0{
             return postArr.count
        }else if index == 1 {
            return likeArr.count
        }else {
            return loanArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if index == 0 {
            return 170
        }
        else if index == 1 {
            return 150
        }
        else {
            return 170
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostsTableViewCell
            cell.PostImage.image = postArr[indexPath.row].base64Img.base64ToImage()
            cell.lblName.text = postArr[indexPath.row].title
            cell.lblPrice.text = "$ \(postArr[indexPath.row].cost)"
            ////
            cell.ProID = postArr[indexPath.row].PosID
            cell.delelgate = self
            return cell
        }else {
       let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell", for: indexPath) as! LikesTableViewCell
            cell.lblName.text = likeArr[indexPath.row].pro_detail.title
            cell.lblPrice.text = likeArr[indexPath.row].pro_detail.cost.toCurrency()
            cell.LikesImage.image = likeArr[indexPath.row].pro_detail.frontImage
            ////
            cell.delegate = self
            cell.ProID = likeArr[indexPath.row].post
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DetailVC = segue.destination as? DetailViewController {
            DetailVC.ProductDetail = self.productDetail ?? DetailViewModel()
        }
    }
    
}

extension TestViewController: CellClickProtocol {
    func cellXibClick(ID: Int) {
        DetailViewModel.LoadProductByIDOfUser(ProID: ID) { (val) in
            self.productDetail = val
            self.performSegue(withIdentifier: "ProfilePostToDetailSW", sender: self)
        }
        
    }
}


