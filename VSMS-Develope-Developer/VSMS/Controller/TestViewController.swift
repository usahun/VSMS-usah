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
    var index = 0

    var ProductDetail = ProfileModel()

    
    let headers: HTTPHeaders = [
        "Cookie": "",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization" : User.getUserEncoded(),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        
        User.IsAuthenticated(view: self) {
            return
        }


        
       tableView.delegate = self
       tableView.dataSource = self
       self.tableView.reloadData()
      // LabelName.text = User.getUsername()
       
        profileImage.layer.cornerRadius = profileImage.frame.width * 0.5
        profileImage.clipsToBounds = true

        
//       self.navigationController?.navigationBar.barTintColor = UIColor.white
//       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//       self.navigationController?.navigationBar.shadowImage = UIImage()
//
//        navigationController?.setNavigationBarHidden(false, animated: false)
          navigationController?.navigationBar.installBlurEffect()
        
        //ApiPosbyuser
        
        Alamofire.request(PROJECT_API.POST_BYUSER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                let json = JSON(value)
                    self.postArr = (json["results"].array?.map{

                        ProfileModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["base64_front_image"].stringValue)
                        } ?? [])
                    print(self.postArr)

                    self.tableView.reloadData()
                case .failure:
                    print("error")
                }
        }
       
        //ApiProfile
        
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
        
        APIlike()
        
        //Register table
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
    
    
    func APIlike() {
        
        Alamofire.request(PROJECT_API.LIKEBYUSER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.likeArr = (json["results"].array?.map{
                        LikebyUserModel(post: $0["post"].stringValue.toInt(), likeby: $0["like_by"].stringValue.toInt())
                        }) ?? []
                    print(self.likeArr)
                    self.tableView.reloadData()
                case .failure:
                    print("error")
                }

        }

    }
    
    func likebyuser(ID: Int,completion: @escaping (ProfileModel) -> ()){
        
        let headers: HTTPHeaders = [
            "Cookie": "",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization" : User.getUserEncoded(),
            ]
        
        Alamofire.request(PROJECT_API.LOADPRODUCT(ProLD:ID), method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let proid = ProfileModel(json: json)
                    completion(proid)
                case .failure:
                    print("error")
                }
                
        }

        
    }

    
    @IBAction func swicthChange(_ sender: UISegmentedControl) {
        index = mysegmentControl.selectedSegmentIndex
        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == 0{
             return postArr.count
        }else{
            return likeArr.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostsTableViewCell
            cell.PostImage.image = postArr[indexPath.row].base64Img.base64ToImage()
            cell.lblName.text = postArr[indexPath.row].title
            cell.lblPrice.text = "$ \(postArr[indexPath.row].cost)"
            return cell
        }else {
       let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell", for: indexPath) as! LikesTableViewCell
//           let cell = likebyuser(ID: 2) { (product) -> UITableViewCell in
//                let cellLike = tableView.dequeueReusableCell(withIdentifier: "likesCell", for: indexPath) as! LikesTableViewCell
//                cellLike.lblName.text = product.title
//                return cellLike
//            }
            DispatchQueue.global(qos: .background).async {
                self.likebyuser(ID: self.likeArr[indexPath.row].post, completion: { (val) in
                    self.ProductDetail = val
                })
                DispatchQueue.main.async {
                    cell.lblName.text = self.ProductDetail.title
                }
            }
            print(cell.lblName.text)
           return cell
        }
    }
    
    
}


