//
//  ContectViewController.swift
//  VSMS
//
//  Created by Rathana on 7/21/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ContectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageprofile: UIImageView!
    @IBOutlet weak var btnpost: UIButton!
    @IBOutlet weak var btncontact: UIButton!
    
    @IBOutlet weak var labelName: UILabel!
    var listtype = true
    var index = 0
    var tel = ImageSubClass()
    var imgprofile = ImageProfileModel()
    var postArr: [HomePageModel] = []
    var UserPostID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource =  self
        imageprofile.layer.cornerRadius = imageprofile.frame.width * 0.5
        imageprofile.clipsToBounds = true
        
        imageprofile.CirleWithWhiteBorder(thickness: 3)
        self.btnpost.backgroundColor = UIColor.lightGray
        self.btncontact.backgroundColor = UIColor.lightGray
        tableView.reloadData()
        
        XibRegister()
        LoadUserProfileInfo()
        LoadAllPostByUser()
    }
    
    func XibRegister(){
        
        let post = UINib(nibName: "ProductListTableViewCell", bundle: nil)
        tableView.register(post, forCellReuseIdentifier: "ProductListCell")
        
    }
    
    func LoadUserProfileInfo(){
        Alamofire.request(PROJECT_API.USER, method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.imgprofile = ImageProfileModel(json: json)
                    self.imageprofile.image = self.imgprofile.profile.base64_profile_image.base64ToImage()
                    self.labelName.text = self.imgprofile.name
                    
                    self.tel = ImageSubClass(json: json["profile"])
                case .failure:
                    print("error")
                }
        }
    }
    
    @objc
    func LoadAllPostByUser(){
        Alamofire.request(PROJECT_API.LOADPRODUCTOFUSER(ProID: UserPostID!), method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.postArr = (json["results"].array?.map{
                        HomePageModel(json: $0)
                        } ?? [])
                        print(json)
                    performOn(.Main, closure: {
                        self.tableView.reloadData()
                    })
                    
                case .failure:
                    print("error")
                }
        }
    }
    
    
    @IBAction func buttonpostTap(_ sender: Any) {

      listtype = true
      tableView.reloadData()
    }
    
    
    @IBAction func buttonContactTap(_ sender: Any) {
        
        listtype = false
         tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listtype == true {
            return postArr.count
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listtype == true {
            return 125
        }
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if listtype == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListTableViewCell
          cell.ProductData = postArr[indexPath.row]
            
           return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "contectCell")
            if indexPath.row == 0 {
                cell?.textLabel?.text = "Phone"
                cell?.detailTextLabel?.text = tel.telephone
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = "Email"
                cell?.detailTextLabel?.text = imgprofile.email
            } else {
                cell?.textLabel?.text = "Address"
                cell?.detailTextLabel?.text = tel.address
            }
            return cell ?? UITableViewCell()
//            return cell ?? UITableViewCell()
        }
         //UITableViewCell()
    }

}


