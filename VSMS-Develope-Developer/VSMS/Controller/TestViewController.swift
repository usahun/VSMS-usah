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
    
    var postArr: [ProfileModel] = []
    var likeArr: [ProfileModel] = []
    var index = 0
    
    let headers: HTTPHeaders = [
        "Cookie": "",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization" : User.getUserEncoded(),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelName.text = User.getUsername()
        
       tableView.delegate = self
       tableView.dataSource = self
       self.tableView.reloadData()
       
        profileImage.layer.cornerRadius = profileImage.frame.width * 0.5
        profileImage.clipsToBounds = true
        
       self.navigationController?.navigationBar.barTintColor = UIColor.white
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Api
        
        Alamofire.request(PROJECT_API.POST_BYUSER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                let json = JSON(value)
                    self.postArr = (json["results"].array?.map{
                        ProfileModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["base64_front_image"].stringValue)
                        })!
                    //print(self.postArr)
                    self.tableView.reloadData()
                case .failure:
                    print("error")
                }
                
                
        }
        
       
        
        //Register table
        let posts = UINib(nibName: "PostsTableViewCell", bundle: nil)
        tableView.register(posts, forCellReuseIdentifier: "Postcell")
        
        let likes = UINib(nibName: "LikesTableViewCell", bundle: nil)
        tableView.register(likes, forCellReuseIdentifier: "likesCell")
        
    }
    
    
    
//    func APIlike() {
//
//
//        Alamofire.request(PROJECT_API.LIKEBYUSER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
//            { (response) in
//                switch response.result{
//                case .success(let value):
//                    let json = JSON(value)
//                    self.likeArr = (json["results"].array?.map{
//                        ProfileModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["base64_front_image"].stringValue)
//                        })!
//                    //print(self.postArr)
//                    self.tableView.reloadData()
//                case .failure:
//                    print("error")
//                }
//
//
//        }
//
//    }
    
    
    @IBAction func swicthChange(_ sender: UISegmentedControl) {
      

        index = mysegmentControl.selectedSegmentIndex
        tableView.reloadData()
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return postArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostsTableViewCell
            cell.PostImage.image = postArr[indexPath.row].imagefront.base64ToImage()
            cell.lblName.text = postArr[indexPath.row].title
            cell.lblPrice.text = "$ \(postArr[indexPath.row].cost)"
            return cell
        }else {
       let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell", for: indexPath) as! LikesTableViewCell
        return cell
        }
    }
    
    
    
}
