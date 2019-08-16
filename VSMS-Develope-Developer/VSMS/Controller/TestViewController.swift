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
    
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnLoan: UIButton!
    
    
    
    var ProfileHandleRequest = UserProfileRequestHandle()
    var post = ["Posts","Likes"]
    var imgprofile = ImageProfileModel()
    let picker = UIImagePickerController()
    
    var postArr: [ProfileModel] = []
    var likeArr: [LikebyUserModel] = []
    var loanArr: [String] = []
    var pickPhotoCheck = ""
    var isPostActiveOrHistory = true
    var isLoadActiveOrHistory = true
    var isLoading = true
    var isHistoryLoading = true
    var isLikeLoading = true
    var isLoanActive = true
    var isLoanHistory = true
    
    var index = 0
    var productDetail: DetailViewModel?
    //var ProductDetail = ProfileModel()
    var dpatch = DispatchGroup()
    
    lazy var refresher: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor.gray
        refresh.center = self.view.center
        refresh.addTarget(self, action: #selector(Refresher), for: .valueChanged)
        
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
        tableView.reloadData()
    }

    override func viewDidLoad() {
        //Check User is Log in
        super.viewDidLoad()
      
        
        if !User.IsUserAuthorized() {
            PresentController.LogInandRegister()
        }

        
        profileImage.CirleWithWhiteBorder(thickness: 3)
        CoverView.addBorder(toSide: .Bottom, withColor: UIColor.white.cgColor, andThickness: 3)
        CoverView.bringSubviewToFront(profileImage)
        
        btnCoverChange.addTarget(self, action: #selector(btnCoverHandler), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileClickHandle))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        tableView.refreshControl = refresher

        tableView.delegate = self
        tableView.dataSource = self
        picker.delegate = self
       
        profileImage.layer.cornerRadius = profileImage.frame.width * 0.5
        profileImage.clipsToBounds = true
        
        /////// Calling Functions
        XibRegister()
        LabelName.text = User.getUsername()
        
        performOn(.Main) {
            self.LoadUserProfileInfo()
            
            self.ProfileHandleRequest.LoadAllPostByUser {
                self.isLoading = false
                self.tableView.reloadData()
            }
            
            self.ProfileHandleRequest.LoadAllPostHistoryByUser {
                self.isHistoryLoading = false
                self.tableView.reloadData()
            }
            
            self.ProfileHandleRequest.LoadAllPostLikeByUser(completion: {
                self.isLikeLoading = false
                self.tableView.reloadData()
            })
            
            self.ProfileHandleRequest.LoadLoanActiveByUser {
                self.isLoanActive = false
                self.tableView.reloadData()
            }
            
            self.ProfileHandleRequest.LoadLoanHistoryByUser {
                self.isLoanHistory = false
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    ///functions and Selectors
    func XibRegister(){
        let posts = UINib(nibName: "PostsTableViewCell", bundle: nil)
        tableView.register(posts, forCellReuseIdentifier: "Postcell")
        
        let likes = UINib(nibName: "LikesTableViewCell", bundle: nil)
        tableView.register(likes, forCellReuseIdentifier: "likesCell")
        
        tableView.register(UINib(nibName: "ActiveDeactiveTableViewCell", bundle: nil), forCellReuseIdentifier: "activedeactiveCell")
        
        tableView.register(UINib(nibName: "LoanTableViewCell", bundle: nil), forCellReuseIdentifier: "LoanTableViewCell")
        
        tableView.register(UINib(nibName: "LoanHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "LoanHistoryTableViewCell")
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
        
        LabelName.text = User.getUsername()
    }
    
    func LoadUserProfileInfo(){
        Alamofire.request(PROJECT_API.USER,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON
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
    func Refresher(){
        switch index
        {
        case 0:
            if isPostActiveOrHistory{
                ProfileHandleRequest.LoadAllPostByUser {
                    self.refresher.endRefreshing()
                    self.tableView.reloadData()
                }
            }
            else{
                ProfileHandleRequest.LoadAllPostHistoryByUser {
                    self.refresher.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        case 1:
            ProfileHandleRequest.LoadAllPostLikeByUser {
                self.refresher.endRefreshing()
                self.tableView.reloadData()
            }
        case 2:
            if isLoadActiveOrHistory
            {
                ProfileHandleRequest.LoadLoanActiveByUser {
                    self.refresher.endRefreshing()
                    self.tableView.reloadData()
                }
            }
            else{
                ProfileHandleRequest.LoadLoanHistoryByUser {
                    self.refresher.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        default:
            break
        }
    }
    
    @IBAction func swicthChange(_ sender: UISegmentedControl) {
        index = mysegmentControl.selectedSegmentIndex
        self.tableView.reloadData()
    }
    
    @IBAction func btnPostHandler(_ sender: UIButton) {
        tabActive(buttonActive: sender)
    }
    @IBAction func btnLikeHandler(_ sender: UIButton) {
        tabActive(buttonActive: sender)
    }
    @IBAction func btnLoanHandler(_ sender: UIButton) {
        tabActive(buttonActive: sender)
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == 0
        {
            if isPostActiveOrHistory {
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
        }
        else if index == 1
        {
            if ProfileHandleRequest.PostLike.count == 0
            {
                return 1
            }
            return ProfileHandleRequest.PostLike.count
        }
        else
        {
            if isLoadActiveOrHistory
            {
                if ProfileHandleRequest.PostLoanActive.count == 0
                {
                    return 2
                }
                else{
                    return ProfileHandleRequest.PostLoanActive.count + 1
                }
            }
            else{
                if ProfileHandleRequest.PostLoanHistory.count == 0
                {
                    return 2
                }
                else{
                    return ProfileHandleRequest.PostLoanHistory.count + 1
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if index == 0 {
            if indexPath.row == 0 {
                return 50
            }
             return 170
        }
        else if index == 1 {
            return 140
        }
        else {
            if indexPath.row == 0 {
                return 50
            }
            if isLoadActiveOrHistory{
                return 170
            }
            return 140
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if index == 0
        {
            if indexPath.row == 0 {
                let activeCell = tableView.dequeueReusableCell(withIdentifier: "activedeactiveCell", for: indexPath) as! ActiveDeactiveTableViewCell
                
                activeCell.sagement.selectedSegmentIndex = isPostActiveOrHistory ? 0 : 1
                activeCell.sagementclick = { check in
                    self.isPostActiveOrHistory = check
                    self.tableView.reloadData()
                }
                return activeCell
            }
            if isPostActiveOrHistory
            {
                if isLoading {
                    return tableView.loadingCell(Indexpath: indexPath)
                }
                
                if ProfileHandleRequest.PostActive.count == 0 {
                    return tableView.noRecordCell(Indexpath: indexPath)
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostsTableViewCell
                cell.Data = ProfileHandleRequest.PostActive[indexPath.row - 1]
                cell.reload()
                cell.delelgate = self
                return cell
            }
            else{
                if isHistoryLoading {
                    return tableView.loadingCell(Indexpath: indexPath)
                }
                
                if ProfileHandleRequest.PostHistory.count == 0 {
                    return tableView.noRecordCell(Indexpath: indexPath)
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath) as! PostsTableViewCell
                cell.Data = ProfileHandleRequest.PostHistory[indexPath.row - 1]
                cell.delelgate = self
                cell.reload()
                return cell
            }
        }
        else if index == 1
        {
            if ProfileHandleRequest.PostLike.count == 0
            {
                if isLikeLoading {
                    return tableView.loadingCell(Indexpath: indexPath)
                }
                
                return tableView.noRecordCell(Indexpath: indexPath)
            }
                let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell", for: indexPath) as! LikesTableViewCell
                cell.ProductData = ProfileHandleRequest.PostLike[indexPath.row]
                cell.delegate = self
                cell.reload()
                return cell
        }
        else
        {
            if indexPath.row == 0 {
                let activeCell = tableView.dequeueReusableCell(withIdentifier: "activedeactiveCell", for: indexPath) as! ActiveDeactiveTableViewCell
                
                activeCell.sagement.selectedSegmentIndex = isLoadActiveOrHistory ? 0 : 1
                activeCell.sagementclick = { check in
                    self.isLoadActiveOrHistory = check
                    self.tableView.reloadData()
                }
                return activeCell
            }
            
            if isLoadActiveOrHistory
            {
                if isLoanActive {
                    return tableView.loadingCell(Indexpath: indexPath)
                }
                
                if ProfileHandleRequest.PostLoanActive.count == 0
                {
                    return tableView.noRecordCell(Indexpath: indexPath)
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "LoanTableViewCell", for: indexPath) as! LoanTableViewCell
                let data = ProfileHandleRequest.PostLoanActive[indexPath.row - 1] 
                cell.LoanID = data.id
                cell.ProductID = data.post
                cell.ReloadXib()
                
                cell.DeleteHandle = { loanID in
                    self.DeleteLoanHandler(LoanID: loanID)
                }
                
                cell.DetailHandle = { loanID in
                    self.DetailLoanHandler(LoanID: loanID)
                }
                
                cell.EditHandle = { loanID in
                    self.EditLoanHandler(LoanID: loanID)
                }
                
                return cell
            }
            else{
                if isLoanHistory {
                    return tableView.loadingCell(Indexpath: indexPath)
                }
                
                if ProfileHandleRequest.PostLoanHistory.count == 0
                {
                    return tableView.noRecordCell(Indexpath: indexPath)
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "LoanHistoryTableViewCell", for: indexPath) as! LoanHistoryTableViewCell
                let data = ProfileHandleRequest.PostLoanHistory[indexPath.row - 1]
                cell.LoanID = data.id
                cell.ProductID = data.post
                cell.reloadXib()
                return cell
            }
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

extension TestViewController {
    func DeleteLoanHandler(LoanID: Int)
    {
        let alertMessage = UIAlertController(title: nil, message: "Deleting Loan...", preferredStyle: .alert)
        alertMessage.addActivityIndicator()
        self.present(alertMessage, animated: true, completion: nil)
        
        LoanViewModel.Detail(loanID: LoanID) { (val) in
            val.Delete(completion: { (result) in
                alertMessage.dismissActivityIndicator()
                self.ProfileHandleRequest.LoadLoanActiveByUser {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func DetailLoanHandler(LoanID: Int)
    {
        let loanVC:LoanViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoanViewController") as! LoanViewController
        loanVC.Loan.id = LoanID
        loanVC.is_Detail = true
        self.navigationController?.pushViewController(loanVC, animated: true)
    }
    
    func EditLoanHandler(LoanID: Int)
    {
        let loanVC:LoanViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoanViewController") as! LoanViewController
        loanVC.Loan.id = LoanID
        loanVC.is_Edit = true
        self.navigationController?.pushViewController(loanVC, animated: true)
    }
    
    func tabActive(buttonActive: UIButton)
    {
        switch buttonActive
        {
        case btnPost:
            index = 0
            self.tableView.reloadData()
            btnPost.ActiveButton()
            btnLike.DeactiveButton()
            btnLoan.DeactiveButton()
        case btnLike:
            index = 1
            self.tableView.reloadData()
            btnPost.DeactiveButton()
            btnLike.ActiveButton()
            btnLoan.DeactiveButton()
        case btnLoan:
            index = 2
            self.tableView.reloadData()
            btnPost.DeactiveButton()
            btnLike.DeactiveButton()
            btnLoan.ActiveButton()
        default:
            break
        }
    }
}

extension TestViewController: ProfileCellClickProtocol {
    func cellClickToDelete(ID: Int) {
        print(ID)
    }
    
    func cellClickToDetail(ID: Int) {
        PushToDetailProductViewController(productID: ID)
    }
    
    func cellClickToEdit(ID: Int) {
       PresentController.PushToEditPostViewController(postID: ID, from: self)
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


private extension UIButton
{
    func ActiveButton()
    {
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.254701972, green: 0.5019594431, blue: 1, alpha: 1)
    }
    
    func DeactiveButton()
    {
        self.setTitleColor(#colorLiteral(red: 0.254701972, green: 0.5019594431, blue: 1, alpha: 1), for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
}
