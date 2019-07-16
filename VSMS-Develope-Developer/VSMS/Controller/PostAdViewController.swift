//
//  PostAdViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 4/29/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

struct postImageModel {
    var image:  UIImage
    var Imagevalue: UIImage?
}

class Phone {
    var numbers: [String]? = []
}

enum SectionEnum {
    
    case photosProduct
    case detail
    case discount
    case contact
  //  case phone(phone: Phone)

    var description: String {
        switch self {
            
        case .photosProduct:
            return ""
        case .detail:
            return "DETAIL"
        case .discount:
            return "DISCOUNT"
        case .contact:
            return "CONTACT"
//        case .phone:
//            return "Phone 1"
      }
    }
    
    var rowCount: Int {
    
            return self.Content.count
        
    }
    
    var Content: Array<Any>
    {
        switch self
        {
        case .photosProduct:
        return[""]
            
        case .detail:
            //return ["PostTypeCell", "TitleCell", "CategoryCell", "TypeCell", "BrandCell", "ModelCell","YearCell","ConditionCell"]
           return ["PostTypeCell", "TitleCell", "CategoryCell", "TypeCell", "BrandCell", "ModelCell","YearCell","ConditionCell","ColorCell","VinCodeCell","MachineCodeCell","DescriptionCell", "PriceCell"]
        case .discount:
            return ["DiscountTypeCell","DiscountAmountCell"]
        case .contact:
            return ["NameCell", "PhoneNumberCell", "EmailCell"]
//        case .phone:
//            return ["PhoneNumberCell", "EmailCell"]
      }
    }
}

class PostAdViewController: UIViewController, UITableViewDataSource, UITabBarDelegate,UITextFieldDelegate , UITableViewDelegate, CellTableClick {
    
    @IBOutlet weak var tableview: UITableView!
//    @IBOutlet private weak var collectionView: UICollectionView?
    
    var phone: Phone = Phone()
    var postImages: [postImageModel] = []
    let picker = UIImagePickerController()
    
    var tempImage: UIImage?
    var currentIndex: Int = 0
    var allTypes: [SectionEnum] = []
    var isHideButtonOfSection = false
    
    var JsonData = PostViewModel()
    var SalePostData = SalePost()
    var RentPostData = RentPost()
    var BuyPostData = BuyPost()
    
    weak var refreshXibDelegate: refreshDropdownInXib?
    weak var getDropDownTypeDelegate: getDropdowntypeProtocol?
    weak var refreshCollectionDelegate: refreshCollectionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allTypes = [SectionEnum.photosProduct,
                         SectionEnum.detail,
                         SectionEnum.discount,
                         SectionEnum.contact
                         ]

        tableview.delegate = self
        tableview.dataSource = self
        RegisterXib()
    }
    
    
    //Configuration
    func RegisterXib(){
        
        let cellNib = UINib(nibName: "DeTailTableCell", bundle: nil)
        tableview?.register(cellNib, forCellReuseIdentifier: "detailCell")
        tableview.keyboardDismissMode = .onDrag
        
        let cellcollection = UINib(nibName: "CollectionTableViewCell", bundle: nil)
        tableview?.register(cellcollection, forCellReuseIdentifier: "photocollection")
        
        let dropdownlist = UINib(nibName: "DropdownTableViewCell", bundle: nil)
        tableview.register(dropdownlist, forCellReuseIdentifier: "dropdownlist")
        
        let cellData = UINib(nibName: "PassDataCell", bundle: nil)
        tableview?.register(cellData, forCellReuseIdentifier: "dataCell")
        
        let cellphone = UINib(nibName: "PhoneNumberHeader", bundle: nil)
        tableview?.register(cellphone, forHeaderFooterViewReuseIdentifier: "headerView")
        
        let celladdnewnumber = UINib(nibName: "AddmoreNumberPhoneTableViewCell", bundle: nil)
        tableview?.register(celladdnewnumber, forCellReuseIdentifier: "AddmoreNumberPhoneTableViewCell")
        
        let cellFooter = UINib(nibName: "MapTableViewHeaderFooterView", bundle: nil)
        tableview?.register(cellFooter, forHeaderFooterViewReuseIdentifier: "MapTableViewHeaderFooterView")
        
        let PhoneHeader = UINib(nibName: "PhoneNumberInputHeaderTableViewCell", bundle: nil)
        tableview?.register(PhoneHeader, forHeaderFooterViewReuseIdentifier: "PhoneNumberHeaderCell")
        
        setupView()
        
        for _ in 0...5 {
            self.postImages.append(postImageModel(image: UIImage(named: "icons8-plus-math-50 (5)")!, Imagevalue: nil))
        }
    }
    
    //DelegateMethod
    func SubmitClick() {

        if postImages[0].Imagevalue != nil {
            JsonData.front_image_path = postImages[0].Imagevalue!.toBase64()
            JsonData.front_image_base64 = JsonData.front_image_path ?? ""
        }
        if postImages[1].Imagevalue != nil {
            JsonData.left_image_path = postImages[1].Imagevalue!.toBase64()
            JsonData.left_image_base64 = JsonData.left_image_path ?? ""
        }
        if postImages[2].Imagevalue != nil {
            JsonData.right_image_path = postImages[2].Imagevalue!.toBase64()
            JsonData.right_image_base64 = JsonData.right_image_path ?? ""
        }
        if postImages[3].Imagevalue != nil {
            JsonData.back_image_path = postImages[3].Imagevalue!.toBase64()
            JsonData.back_image_base64 = JsonData.back_image_path ?? ""
        }
        
        if JsonData.post_type == "sell" {
            JsonData.sale_post = [SalePostData.asDictionary]
            JsonData.buy_post = []
            JsonData.rent_post = []
        }
        else if JsonData.post_type == "buy" {
            JsonData.buy_post = [BuyPostData.asDictionary]
            JsonData.sale_post = []
            JsonData.rent_post = []
        }
        else if JsonData.post_type == "rent" {
            JsonData.rent_post = [RentPostData.asDictionary]
            JsonData.sale_post = []
            JsonData.buy_post = []
        }
        
        
        let headers: HTTPHeaders = [
            "Cookie": "",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization" : User.getUserEncoded(),
        ]

        Alamofire.request(PROJECT_API.POST_SELL,
                          method: .post,
                          parameters: JsonData.asDictionary,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON { response in
                        switch response.result{
                        case .success (let value):
                            Message.SuccessMessage(message: "Post created successfully.", View: self, callback: {
                                print(value)
                            })
                        case .failure(let error):

                            print(error)
                        }
                    }
    }
    
    func ClickCell(currentCell: CellClickViewModel) {
       
        if currentCell.IndexPathKey == NSIndexPath(row: 0, section: 2){
            self.getDropDownTypeDelegate?.getDropDownTypeData(type: currentCell.Value)
        }
        
        if currentCell.IndexPathKey?.row == 4 {
            self.refreshXibDelegate?.refreshXib(FKKey: currentCell.ID.toInt())
        }
        PassingValueFromXib(passedData: currentCell)
    }
    
    //fucntion
    func PassingValueFromXib(passedData: CellClickViewModel){
        switch passedData.IndexPathKey?.section {
        case 1:
            switch passedData.IndexPathKey?.row {
            case 0: JsonData.post_type = passedData.ID
            case 1: JsonData.title = passedData.ID
            case 2: JsonData.category = passedData.ID.toInt()
            case 3: JsonData.type = passedData.ID.toInt()
            case 4: JsonData.brand = passedData.ID.toInt()
            case 5: JsonData.modeling = passedData.ID.toInt()
            case 6: JsonData.year = passedData.ID.toInt()
            case 7: JsonData.condition = passedData.ID
            case 8: JsonData.color = passedData.ID
            case 9: JsonData.vin_code = passedData.ID
            case 10: JsonData.machine_code = passedData.ID
            case 11: JsonData.description = passedData.ID
            case 12:
                JsonData.cost = passedData.ID
                SalePostData.price = passedData.ID
                SalePostData.total_price = passedData.ID
                
                RentPostData.price = passedData.ID
                RentPostData.total_price = passedData.ID
                
                BuyPostData.total_price = passedData.ID
                
            default:
                print("default")
            }
        case 2:
            switch passedData.IndexPathKey?.row {
            case 0: JsonData.discount_type = passedData.ID
            case 1: JsonData.discount = passedData.ID
            default:
                print("")
            }
        case 3:
            switch passedData.IndexPathKey?.row {
            case 1: JsonData.contact_phone = passedData.ID
            case 2: JsonData.contact_email = passedData.ID
            default:
                print("")
            }
        default:
            print("")
        }
    }
    
  
    
    
    fileprivate func setupView() {
        picker.delegate = self
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sec = allTypes[indexPath.section]
        switch sec {
        case .photosProduct:
            return 130
        case .detail:
            if indexPath.row == 11{
                return 100
            }
            return 60
        case .discount:
            if indexPath.row == 1{
                return 70
            }
            return 60
        default:
            return 60
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      let sec = allTypes[section]
      return sec.rowCount
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MapTableViewHeaderFooterView") as? MapTableViewHeaderFooterView
            footerView?.contentView.backgroundColor = .white
            footerView?.delegate = self
            return footerView
        }
        return nil
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = allTypes[section]
        if section == 0 {
            return nil
        } else if section == 4 && false {
            
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PhoneNumberHeaderCell") as? PhoneNumberInputHeaderTableViewCell
            headerView?.contentView.backgroundColor = UIColor.white;
//            headerView?.addingButton?.isHidden = self.isHideButtonOfSection
//            headerView?.titleLabel?.text = "Phone 1"
//
            headerView?.addNewPhoneNumberHandler = {
                self.phone.numbers?.append("Okay")
                
                if self.phone.numbers?.count != 0 {
                    //self.isHideButtonOfSection = true
                    headerView?.btnAddNewPhoneNumber.isHidden = self.isHideButtonOfSection
                    //headerView?.titleLabel?.text = "kkk"
                } else {
                    //self.isHideButtonOfSection = false
                    //headerView?.titleLabel?.text = "none"
                }
               tableView.reloadData()
            }
            
           return headerView
        }
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width, height: 40))
        titleLabel.text = type.description
        titleView.addSubview(titleLabel)
        
        return titleView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 412
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNonzeroMagnitude
        }
        if section == 4 {
            return 70
        }
        return 40
    }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let type = allTypes[indexPath.section]
    switch type {
    
    case .photosProduct:
        let cell = tableView.dequeueReusableCell(withIdentifier: "photocollection")as! CollectionTableViewCell
        cell.postImagecollectionview.delegate = self
        cell.postImagecollectionview.dataSource = self
        self.refreshCollectionDelegate = cell.self
        return cell
        
    case .detail:
        let data  = allTypes[indexPath.section]
        var detailCell = tableView.dequeueReusableCell(withIdentifier: data.Content[indexPath.row] as! String) as? DetailTableViewCell
        if detailCell == nil {
            let nib = Bundle.main.loadNibNamed("DetailTableViewCell", owner: self, options: nil)
            detailCell = nib?[indexPath.row] as? DetailTableViewCell
        }
        detailCell?.passingData.IndexPathKey = NSIndexPath(row: indexPath.row, section: indexPath.section)
        detailCell?.delegate = self
        if indexPath.row == 5 {
            self.refreshXibDelegate = detailCell.self
        }
        return detailCell ?? UITableViewCell()

    case .discount:
        var detailCell = tableView.dequeueReusableCell(withIdentifier: type.Content[indexPath.row] as! String) as? DiscountInputTableViewCell
        if detailCell == nil {
            let nib = Bundle.main.loadNibNamed("DiscountInputTableViewCell", owner: self, options: nil)
            detailCell = nib?[indexPath.row] as? DiscountInputTableViewCell
        }
        if indexPath.row == 1 {
            self.getDropDownTypeDelegate = detailCell.self
        }
        
        detailCell?.delegate = self
        detailCell?.passingData.IndexPathKey = NSIndexPath(row: indexPath.row, section: indexPath.section)
        return detailCell ?? UITableViewCell()
    case .contact:
        var detailCell = tableView.dequeueReusableCell(withIdentifier: type.Content[indexPath.row] as! String) as? ContactInputTableViewCell
        if detailCell == nil {
            let nib = Bundle.main.loadNibNamed("ContactInputTableViewCell", owner: self, options: nil)
            detailCell = nib?[indexPath.row] as? ContactInputTableViewCell
        }
        detailCell?.passingData.IndexPathKey = NSIndexPath(row: indexPath.row, section: indexPath.section)
        detailCell?.delegate = self
        return detailCell ?? UITableViewCell()
        
//    case .phone:
//
//        var detailCell = tableView.dequeueReusableCell(withIdentifier: type.Content[indexPath.row] as! String) as? ContactInputTableViewCell
//        if detailCell == nil {
//            let nib = Bundle.main.loadNibNamed("ContactInputTableViewCell", owner: self, options: nil)
//            detailCell = nib?[indexPath.row + 1] as? ContactInputTableViewCell
//        }
//        return detailCell ?? UITableViewCell()
        
//        let cell = tableview.dequeueReusableCell(withIdentifier: "AddmoreNumberPhoneTableViewCell") as! AddmoreNumberPhoneTableViewCell
//
//        cell.addingbutton?.isHidden = false
//        if indexPath.row != self.phone.numbers!.count - 1 {
//            cell.addingbutton?.isHidden = true
//        }
//
//        if self.phone.numbers?.count == 2 {
//            cell.addingbutton?.isHidden = true
//        }
//
//        cell.addingTapComplietion = {
//            self.phone.numbers?.append("Phone Number")
//            let indexSet = IndexSet(integer: indexPath.section)
//            tableView.reloadSections(indexSet, with: .automatic)
//        }
//
//        if indexPath.row == 0 {
//            cell.titleLabel?.text = "Phone 2"
//        }
//        else if indexPath.row == 1 {
//            cell.titleLabel?.text = "Phone 3"
//        }
//        return cell
    }
}

}

extension PostAdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell",
                                                      for: indexPath) as? PhotoListCollectionViewCell
        cell!.postImageView?.image = postImages[indexPath.row].image
        
        print(postImages.get(at: indexPath.row) as Any)
        
        if postImages[indexPath.row].image.size.width != 50 {
            cell?.btnRemove.isHidden = false
            cell?.removeImage = {
                self.postImages[indexPath.row].image = UIImage(named: "icons8-plus-math-50 (5)")!
                self.postImages[indexPath.row].Imagevalue = nil
                self.refreshCollectionDelegate?.refreshCollection()
            }
        }
        else{
            cell?.btnRemove.isHidden = true
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        self.currentIndex = indexPath.row
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
        let alertController = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (alert) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }
            else{
                Message.ErrorMessage(message: "Camera in your device is not avialable.", View: self)
            }
        }
        
        let photoAlbumAction = UIAlertAction(title: "Open Album", style: .default) { (alert) in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoAlbumAction)
        alertController.addAction(CancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension PostAdViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage: UIImage = info[.originalImage] as? UIImage {
            
            picker.dismiss(animated: true) {
                self.tempImage = selectedImage
                self.postImages[self.currentIndex] = postImageModel(image: selectedImage, Imagevalue: selectedImage)
                self.refreshCollectionDelegate?.refreshCollection()
            }
        }
    }
}



