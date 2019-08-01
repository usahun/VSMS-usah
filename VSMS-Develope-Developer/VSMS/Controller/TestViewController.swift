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
    
    @IBOutlet weak var CoverView: UIView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mysegmentControl: UISegmentedControl!
    @IBOutlet weak var btnCoverChange: UIButton!
    
    
    var ProfileHandleRequest = UserProfileRequestHandle()
    var post = ["Posts","Likes"]
    var imgprofile = ImageProfileModel()
    let picker = UIImagePickerController()
    
    var postArr: [ProfileModel] = []
    var likeArr: [LikebyUserModel] = []
    var loanArr: [String] = []
    var pickPhotoCheck = ""
    var isActiveOrHistory = true
    
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

        self.ShowDefaultNavigation()
        super.viewWillAppear(true)
        self.viewDidLoad()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        //Check User is Log in
        super.viewDidLoad()
      
        
        if !User.IsUserAuthorized() {
            self.PushToLogInViewController()
        }

        
        profileImage.CirleWithWhiteBorder(thickness: 3)
        CoverView.addBorder(toSide: .Bottom, withColor: UIColor.white.cgColor, andThickness: 3)
        CoverView.bringSubviewToFront(profileImage)
        
        btnCoverChange.addTarget(self, action: #selector(btnCoverHandler), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileClickHandle))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        tableView.refreshControl = postRefresher


        self.navigationController?.navigationBar.isHidden = false
        mysegmentControl.setTitle("POSTS(\(ProfileHandleRequest.AllPostActiveCount))", forSegmentAt: 0)
        mysegmentControl.setTitle("LIKES(\(likeArr.count))", forSegmentAt: 1)
        mysegmentControl.setTitle("LOANS(0)", forSegmentAt: 2)

        
        
        tableView.delegate = self
        tableView.dataSource = self
        picker.delegate = self
       
        profileImage.layer.cornerRadius = profileImage.frame.width * 0.5
        profileImage.clipsToBounds = true

        //navigationController?.navigationBar.installBlurEffect()
        
        /////// Calling Functions
        XibRegister()
    

        
        performOn(.Main) {
            self.ProfileHandleRequest.LoadAllPostByUser {
                self.mysegmentControl.setTitle("Posts(\(self.ProfileHandleRequest.AllPostActiveCount))", forSegmentAt: 0)
                self.tableView.reloadData()
            }
            
            self.ProfileHandleRequest.LoadAllPostHistoryByUser {
                self.tableView.reloadData()
            }
            print("main")
        }
        
        performOn(.HighPriority) {
            self.LoadUserProfileInfo()
            self.ProfileHandleRequest.LoadAllPostLikeByUser(completion: {
                
            })
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
        
        tableView.register(UINib(nibName: "ActiveDeactiveTableViewCell", bundle: nil), forCellReuseIdentifier: "activedeactiveCell")
    }
    
    @objc
    func ProfileClickHandle(){
        self.pickPhotoCheck = "profile"
        let alertCon = UIAlertController(title: "Edit Profile", message: nil, preferredStyle: .actionSheet)
        let uploadBtn = UIAlertAction(title: "Upload", style: .default) { (alert) in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let takeNewCover = UIAlertAction(title: "Take a Photo", style: .default) { (alert) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }
            else{
                Message.ErrorMessage(message: "Camera in your device is not avialable.", View: self)
            }
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
//        if profileImage.image != nil {
//            let removeBtn = UIAlertAction(title: "Remove", style: .destructive) { (alert) in
//                print("remove")
//            }
//            alertCon.addAction(removeBtn)
//        }
        alertCon.addAction(uploadBtn)
        alertCon.addAction(takeNewCover)
        alertCon.addAction(cancelBtn)
        present(alertCon, animated: true, completion: nil)
    }
    
    @objc
    func btnCoverHandler(){
        self.pickPhotoCheck = "cover"
        let alertCon = UIAlertController(title: "Edit Cover", message: nil, preferredStyle: .actionSheet)
        let uploadBtn = UIAlertAction(title: "Upload", style: .default) { (alert) in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let takeNewCover = UIAlertAction(title: "Take a Photo", style: .default) { (alert) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }
            else{
                Message.ErrorMessage(message: "Camera in your device is not avialable.", View: self)
            }
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
//        if CoverImage.image != nil {
//            let removeBtn = UIAlertAction(title: "Remove", style: .destructive) { (alert) in
//                print("remove")
//            }
//            alertCon.addAction(removeBtn)
//        }
        alertCon.addAction(uploadBtn)
        alertCon.addAction(takeNewCover)
        alertCon.addAction(cancelBtn)
        present(alertCon, animated: true, completion: nil)
    }
    
    func profileandCover(){
        if imgprofile.profile.base64_cover_image != "" {
            CoverImage.image = imgprofile.profile.base64_cover_image.base64ToImage()
            CoverImage.contentMode = .scaleAspectFill
        }
        if imgprofile.profile.base64_profile_image != "" {
            profileImage.image = imgprofile.profile.base64_profile_image.base64ToImage()
            
        }
        
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
        ProfileHandleRequest.LoadAllPostByUser {
            self.mysegmentControl.setTitle("Posts(\(self.ProfileHandleRequest.AllPostActiveCount))", forSegmentAt: 0)
            self.postRefresher.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc
    func LoadAllPostLike() {
        
        
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
            if isActiveOrHistory {
                if ProfileHandleRequest.PostActive.count == 0 {
                    return 2
                }
                return ProfileHandleRequest.PostActive.count + 1
            }
            else{
                if ProfileHandleRequest.PostHistory.count == 0 {
                    return 2
                }
                return ProfileHandleRequest.PostHistory.count + 1
            }
        }else if index == 1 {
            return likeArr.count
        }else {
            return loanArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if index == 0 {
            if indexPath.row == 0 {
                return 50
            }
             return 190
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
            if indexPath.row == 0 {
                let activeCell = tableView.dequeueReusableCell(withIdentifier: "activedeactiveCell", for: indexPath) as! ActiveDeactiveTableViewCell
                
                activeCell.sagement.selectedSegmentIndex = isActiveOrHistory ? 0 : 1
                activeCell.sagementclick = { check in
                    self.isActiveOrHistory = check
                    self.tableView.reloadData()
                }
                return activeCell
            }
            if isActiveOrHistory
            {
                if ProfileHandleRequest.PostActive.count == 0 {
                    return UITableViewCell()
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostsTableViewCell
                cell.Data = ProfileHandleRequest.PostActive[indexPath.row - 1]
                cell.delelgate = self
                return cell
            }
            else{
                if ProfileHandleRequest.PostHistory.count == 0 {
                    return UITableViewCell()
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostsTableViewCell
                cell.Data = ProfileHandleRequest.PostHistory[indexPath.row - 1]
                cell.delelgate = self
                return cell
            }
        }else {
       let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell", for: indexPath) as! LikesTableViewCell
            cell.lblName.text = likeArr[indexPath.row].pro_detail.title
            cell.lblPrice.text = likeArr[indexPath.row].pro_detail.cost.toCurrency()
            cell.LikesImage.image = likeArr[indexPath.row].pro_detail.frontImage
            ////
            //cell.delegate = self
            cell.ProID = likeArr[indexPath.row].post
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = ProfileHandleRequest.PostActive.count - 1
        if lastIndex == indexPath.row {
            ProfileHandleRequest.NextPostByUser {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DetailVC = segue.destination as? DetailViewController {
            DetailVC.ProductDetail = self.productDetail ?? DetailViewModel()
        }
    }
    
}

extension TestViewController: ProfileCellClickProtocol {
    func cellClickToDetail(ID: Int) {
        PushToDetailProductByUserViewController(productID: ID)
    }
    
    func cellClickToEdit(ID: Int) {
       PushToEditPostViewController(ID: ID)
    }
}

extension TestViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage: UIImage = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true) {
                if self.pickPhotoCheck == "profile" {
                    selectedImage.UpLoadProfile(completion: {
                        self.profileImage.image = selectedImage
                    })
                }
                else if self.pickPhotoCheck == "cover" {
                    selectedImage.UpLoadCover(completion: {
                        self.CoverImage.image = selectedImage
                    })
                }
            }
        }
    }
}


