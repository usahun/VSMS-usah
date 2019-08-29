////
////  PostAdViewController.swift
////  VSMS
////
////  Created by Vuthy Tep on 4/29/19.
////  Copyright © 2019 121. All rights reserved.
////
//
//import UIKit
//import GoogleMaps
//import Alamofire
//import SwiftyJSON
//import TLPhotoPicker
//
//
//struct postImageModel {
//    var image:  UIImage
//    var Imagevalue: UIImage?
//}
//
//
//
//class Phone {
//    var numbers: [String]? = []
//}
//
//enum SectionEnum {
//    
//    case photosProduct
//    case detail
//    case discount
//    case contact
//  //  case phone(phone: Phone)
//
//    var description: String {
//        switch self {
//            
//        case .photosProduct:
//            return ""
//        case .detail:
//            return "DETAIL"
//        case .discount:
//            return "DISCOUNT"
//        case .contact:
//            return "CONTACT"
////        case .phone:
////            return "Phone 1"
//      }
//    }
//    
//    var rowCount: Int {
//        return self.Content.count
//    }
//    
//    var Content: Array<Any>
//    {
//        switch self
//        {
//        case .photosProduct:
//        return[""]
//            
//        case .detail:
//           return ["PostTypeCell", "TitleCell", "CategoryCell", "TypeCell", "BrandCell", "ModelCell","YearCell","ConditionCell","ColorCell","DescriptionCell", "PriceCell"]
//        case .discount:
//            return ["DiscountTypeCell","DiscountAmountCell"]
//        case .contact:
//            return ["NameCell", "PhoneNumberCell", "EmailCell", "AddressCell"]
////        case .phone:
////            return ["PhoneNumberCell", "EmailCell"]
//      }
//    }
//}
//
//class PostAdViewController: UIViewController, UITableViewDataSource, UITabBarDelegate,UITextFieldDelegate , UITableViewDelegate {
//    
//    @IBOutlet weak var tableview: UITableView!
////    @IBOutlet private weak var collectionView: UICollectionView?
//    
//    var phone: Phone = Phone()
//    var postImages: [postImageModel] = []
//    
//    var allTypes: [SectionEnum] = []
//    var isHideButtonOfSection = false
//    var isHideType = false
//    var isHideDiscount = false
//    var isBeingEdit = false
//    
//    var PostIDEdit: Int?
//    
//    var JsonData = PostViewModel()
//    var SalePostData = SalePost()
//    var RentPostData = RentPost()
//    var BuyPostData = BuyPost()
//    
//    
//    var posttypecheck = true
//    var categorycheck = true
//    
//    
//    weak var getDropDownTypeDelegate: getDropdowntypeProtocol?
//    weak var refreshCollectionDelegate: refreshCollectionProtocol?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.allTypes = [SectionEnum.photosProduct,
//                         SectionEnum.detail,
//                         SectionEnum.discount,
//                         SectionEnum.contact
//                         ]
//
//        tableview.delegate = self
//        tableview.dataSource = self
//
//        ShowDefaultNavigation()
//        RegisterXib()
//        
//        if PostIDEdit != nil
//        {
//            self.view.makeToastActivity(.center)
//            JsonData.LoadPostByID(ID: PostIDEdit!) { (val) in
//                self.JsonData = val
//                self.isBeingEdit = true
//                self.tableview.reloadData()
//                self.view.hideToastActivity()
//                
//            }
//        }
//
//    }
//    
//    
//    //Configuration
//    func RegisterXib(){
//        
//        let cellNib = UINib(nibName: "DeTailTableCell", bundle: nil)
//        tableview?.register(cellNib, forCellReuseIdentifier: "detailCell")
//        tableview.keyboardDismissMode = .onDrag
//        
//        let cellcollection = UINib(nibName: "CollectionTableViewCell", bundle: nil)
//        tableview?.register(cellcollection, forCellReuseIdentifier: "photocollection")
//        
//        let dropdownlist = UINib(nibName: "DropdownTableViewCell", bundle: nil)
//        tableview.register(dropdownlist, forCellReuseIdentifier: "dropdownlist")
//        
//        let cellData = UINib(nibName: "PassDataCell", bundle: nil)
//        tableview?.register(cellData, forCellReuseIdentifier: "dataCell")
//        
//        let cellphone = UINib(nibName: "PhoneNumberHeader", bundle: nil)
//        tableview?.register(cellphone, forHeaderFooterViewReuseIdentifier: "headerView")
//        
//        let celladdnewnumber = UINib(nibName: "AddmoreNumberPhoneTableViewCell", bundle: nil)
//        tableview?.register(celladdnewnumber, forCellReuseIdentifier: "AddmoreNumberPhoneTableViewCell")
//        
//        let cellFooter = UINib(nibName: "MapTableViewHeaderFooterView", bundle: nil)
//        tableview?.register(cellFooter, forHeaderFooterViewReuseIdentifier: "MapTableViewHeaderFooterView")
//        
//        let PhoneHeader = UINib(nibName: "PhoneNumberInputHeaderTableViewCell", bundle: nil)
//        tableview?.register(PhoneHeader, forHeaderFooterViewReuseIdentifier: "PhoneNumberHeaderCell")
//        
//    }
//    
//    //DelegateMethod
//    func SubmitClick() {
//        let alertMessage = UIAlertController(title: nil, message: "Saving Product", preferredStyle: .alert)
//        alertMessage.addActivityIndicator()
//        self.present(alertMessage, animated: true, completion: nil)
//
//        if JsonData.post_type == "sell" {
//            SalePostData.price = JsonData.cost
//            SalePostData.total_price = JsonData.cost
//            JsonData.sale_post = [SalePostData.asDictionary]
//            JsonData.buy_post = []
//            JsonData.rent_post = []
//        }
//        else if JsonData.post_type == "buy" {
//            BuyPostData.total_price = JsonData.cost
//            JsonData.buy_post = [BuyPostData.asDictionary]
//            JsonData.sale_post = []
//            JsonData.rent_post = []
//        }
//        else if JsonData.post_type == "rent" {
//            RentPostData.price = JsonData.cost
//            RentPostData.total_price = JsonData.cost
//            JsonData.rent_post = [RentPostData.asDictionary]
//            JsonData.sale_post = []
//            JsonData.buy_post = []
//        }
//        
//        
//        let headers: HTTPHeaders = [
//            "Cookie": "",
//            "Accept": "application/json",
//            "Content-Type": "application/json",
//            "Authorization" : User.getUserEncoded(),
//        ]
//        
//        var apiEdit = ""
//        if JsonData.post_type == "sell"
//        {
//            apiEdit = PROJECT_API.POST_SELL
//        }
//        else if JsonData.post_type == "buy"
//        {
//            apiEdit = PROJECT_API.POST_BUYS
//        }
//        else if JsonData.post_type == "rent"
//        {
//            apiEdit = PROJECT_API.POST_RENTS
//        }
//        
//        if isBeingEdit
//        {
//            Alamofire.request("\(apiEdit)\(JsonData.PostID)/",
//                              method: .put,
//                              parameters: JsonData.asDictionary,
//                              encoding: JSONEncoding.default,
//                              headers: headers).responseJSON { response in
//                                switch response.result{
//                                case .success:
//                                   // print(value)
//                                    performOn(.Main, closure: {
//                                        alertMessage.dismissActivityIndicator()
//                                        Message.AlertMessage(message: "Product updated", header: "Message", View: self, callback: {
//                                            
//                                        })
//                                    })
//                                case .failure(let error):
//                                    performOn(.Main, closure: {
//                                        alertMessage.dismissActivityIndicator()
//                                        print(error)
//                                        self.view.makeToast("Error Error")
//                                    })
//                                }
//            }
//        }
//        else{
//            Alamofire.request(apiEdit,
//                              method: .post,
//                              parameters: JsonData.asDictionary,
//                              encoding: JSONEncoding.default,
//                              headers: headers).responseJSON { response in
//                                switch response.result{
//                                case .success:
//                                   // print(value)
//                                    performOn(.Main, closure: {
//                                        alertMessage.dismissActivityIndicator()
//                                        Message.AlertMessage(message: "Product Posted", header: "Message", View: self, callback: {
//                                            
//                                        })
//                                    })
//                                case .failure(let error):
//                                    print(error)
//                                    self.view.makeToast(error.localizedDescription)
//                                }
//            }
//        }
//    }
//    
//    //fucntion
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let sec = allTypes[indexPath.section]
//        switch sec {
//        case .photosProduct:
//            return 110
//        case .detail:
//            
//            if indexPath.row == 3 && isHideType{
//                return 0
//            }
//            
//            if indexPath.row == 3 && isBeingEdit && JsonData.category == 2
//            {
//                return 0
//            }
//            
//            if indexPath.row == 9{
//                return 100
//            }
//            return 55
//        default:
//            return 55
//        }
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      let sec = allTypes[section]
//        
//        if section == 2 && isHideDiscount {
//            return 0
//        }
//        
//      return sec.rowCount
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section == 3 {
//           return nil
//        }
//        return nil
//    }
//
////    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
////        if section == 3 {
////            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MapTableViewHeaderFooterView") as? MapTableViewHeaderFooterView
////            footerView?.contentView.backgroundColor = .white
////            footerView?.btnSubmitHandler = {
////                self.SubmitClick()
////            }
////            return footerView
////        }
////        return nil
////    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let type = allTypes[section]
//        if section == 0 {
//            return nil
//        } else if section == 4 && false {
//            
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PhoneNumberHeaderCell") as? PhoneNumberInputHeaderTableViewCell
//            headerView?.contentView.backgroundColor = UIColor.white;
////            headerView?.addingButton?.isHidden = self.isHideButtonOfSection
////            headerView?.titleLabel?.text = "Phone 1"
////
//            headerView?.addNewPhoneNumberHandler = {
//                self.phone.numbers?.append("Okay")
//                
//                if self.phone.numbers?.count != 0 {
//                    //self.isHideButtonOfSection = true
//                    headerView?.btnAddNewPhoneNumber.isHidden = self.isHideButtonOfSection
//                    //headerView?.titleLabel?.text = "kkk"
//                } else {
//                    //self.isHideButtonOfSection = false
//                    //headerView?.titleLabel?.text = "none"
//                }
//               tableView.reloadData()
//            }
//            
//           return headerView
//        }
//        
//        if section == 2 && isHideDiscount {
//            return nil
//        }
//        
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
//        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width, height: 40))
//        titleLabel.text = type.description
//        titleView.addSubview(titleLabel)
//        
//        return titleView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == 3 {
//            return 60
//        }
//        return CGFloat.leastNormalMagnitude
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return CGFloat.leastNonzeroMagnitude
//        }
//        
//        if section == 4 {
//            return 70
//        }
//        
//        if section == 2 && isHideDiscount || (section == 2 && JsonData.post_type == "buy") {
//            return CGFloat.leastNonzeroMagnitude
//        }
//        return 40
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let type = allTypes[indexPath.section]
//    switch type {
//    
//    case .photosProduct:
//        let cell = tableView.dequeueReusableCell(withIdentifier: "photocollection")as! CollectionTableViewCell
//        
//        if isBeingEdit
//        {
//            cell.loadEditImage(FImage: JsonData.front_image_base64?.base64ToImage(),
//                               LImage: JsonData.left_image_base64?.base64ToImage(),
//                               RImage: JsonData.right_image_base64?.base64ToImage(),
//                               BImage: JsonData.back_image_base64?.base64ToImage())
//        }
//        cell.setValueDelegate = self
//        return cell
//        
//    case .detail:
//        let data  = allTypes[indexPath.section]
//        var detailCell = tableView.dequeueReusableCell(withIdentifier: data.Content[indexPath.row] as! String) as? DetailTableViewCell
//        
//        if detailCell == nil {
//            let nib = Bundle.main.loadNibNamed("DetailTableViewCell", owner: self, options: nil)
//            detailCell = nib?[indexPath.row] as? DetailTableViewCell
//        }
//        
//        if indexPath.row == 5 {
//            self.getDropDownTypeDelegate = detailCell
//        }
//        if indexPath.row == 3 && isHideType || (indexPath.row == 3 && isBeingEdit && JsonData.category == 2) {
//            detailCell?.isHidden = true
//        }
//        else {
//            detailCell?.isHidden = false
//        }
//
//        if indexPath.row == 9 {
//            print("")
//        }
//        
//        if isBeingEdit
//        {
//            if indexPath.row == 0 && JsonData.PostTypeVal != ""
//            {
//                detailCell?.postTypeCheck.Inputchecked()
//                detailCell?.btnPostType.setTitle(JsonData.PostTypeVal, for: .normal)
//                detailCell?.passingData.Value = JsonData.PostTypeVal ?? ""
//                detailCell?.passingData.ID = JsonData.post_type
//                JsonData.PostTypeVal = ""
//            }
//            if indexPath.row == 1 && JsonData.TitleVal != ""
//            {
//                detailCell?.titleCheck.Inputchecked()
//                detailCell?.txttitle.text = JsonData.title
//                detailCell?.passingData.ID = JsonData.title
//                detailCell?.passingData.Value = JsonData.title
//                JsonData.TitleVal = ""
//            }
//            if indexPath.row == 2 && JsonData.CategoryVal != ""
//            {
//                detailCell?.categoryCheck.Inputchecked()
//                detailCell?.btnCategory.setTitle(JsonData.CategoryVal, for: .normal)
//                detailCell?.passingData.ID = JsonData.category.toString()
//                detailCell?.passingData.Value = JsonData.CategoryVal ?? ""
//                JsonData.CategoryVal = ""
//            }
//            if indexPath.row == 3 && JsonData.TypeVal != ""
//            {
//                detailCell?.typeCheck.Inputchecked()
//                detailCell?.btnType.setTitle(JsonData.TypeVal, for: .normal)
//                detailCell?.passingData.ID = JsonData.type.toString()
//                detailCell?.passingData.Value = JsonData.TypeVal ?? ""
//                JsonData.TypeVal = ""
//            }
//            
//            if indexPath.row == 4 && JsonData.BrandVal != ""
//            {
//                detailCell?.brandCheck.Inputchecked()
//                detailCell?.btnBrand.setTitle(JsonData.BrandVal, for: .normal)
//                detailCell?.passingData.ID = JsonData.brand.toString()
//                detailCell?.passingData.Value = JsonData.BrandVal ?? ""
//                JsonData.BrandVal = ""
//            }
//            
//            if indexPath.row == 5 && JsonData.ModelVal != ""
//            {
//                detailCell?.modelCheck.Inputchecked()
//                detailCell?.btnModel.setTitle(JsonData.ModelVal, for: .normal)
//                detailCell?.passingData.ID = JsonData.modeling.toString()
//                detailCell?.passingData.Value = JsonData.ModelVal ?? ""
//                JsonData.ModelVal = ""
//            }
//            
//            if indexPath.row == 6 && JsonData.YearVal != ""
//            {
//                detailCell?.yearCheck.Inputchecked()
//                detailCell?.btnYear.setTitle(JsonData.YearVal, for: .normal)
//                detailCell?.passingData.ID = JsonData.year.toString()
//                detailCell?.passingData.Value = JsonData.YearVal ?? ""
//                JsonData.YearVal = ""
//            }
//            
//            if indexPath.row == 7 && JsonData.ConditionVal != ""
//            {
//                detailCell?.conditionCheck.Inputchecked()
//                detailCell?.btnCodition.setTitle(JsonData.ConditionVal, for: .normal)
//                detailCell?.passingData.ID = JsonData.condition
//                detailCell?.passingData.Value = JsonData.ConditionVal ?? ""
//                JsonData.ConditionVal = ""
//            }
//            
//            if indexPath.row == 8 && JsonData.ColorVal != ""
//            {
//                detailCell?.colorCheck.Inputchecked()
//                detailCell?.btnColor.setTitle(JsonData.ColorVal, for: .normal)
//                detailCell?.passingData.ID = JsonData.color
//                detailCell?.passingData.Value = JsonData.ColorVal ?? ""
//                JsonData.ColorVal = ""
//            }
//            
//            if indexPath.row == 9 && JsonData.description != ""
//            {
//                detailCell?.desCheck.Inputchecked()
//                detailCell?.textView.text = JsonData.description
//                detailCell?.passingData.ID = JsonData.description
//                detailCell?.passingData.Value = JsonData.description
//                JsonData.description = ""
//            }
//            
//            if indexPath.row == 10 && JsonData.PriceVal != ""
//            {
//                detailCell?.priceCheck.Inputchecked()
//                detailCell?.btnPrice.text = JsonData.cost
//                detailCell?.passingData.ID = JsonData.cost
//                detailCell?.passingData.Value = JsonData.cost
//                JsonData.PriceVal = ""
//            }
//        }
//        
//        detailCell?.passingData.IndexPathKey = NSIndexPath(row: indexPath.row, section: indexPath.section)
//        detailCell?.delegate = self
//        return detailCell ?? UITableViewCell()
//
//    case .discount:
//        var detailCell = tableView.dequeueReusableCell(withIdentifier: type.Content[indexPath.row] as! String) as? DiscountInputTableViewCell
//        if detailCell == nil {
//            let nib = Bundle.main.loadNibNamed("DiscountInputTableViewCell", owner: self, options: nil)
//            detailCell = nib?[indexPath.row] as? DiscountInputTableViewCell
//        }
//        if indexPath.row == 1 {
//            self.getDropDownTypeDelegate = detailCell.self
//        }
//        
//        
//        if isBeingEdit
//        {
//            if indexPath.row == 0 && JsonData.DiscountTypeVal != ""
//            {
//                detailCell?.passingData.ID = JsonData.discount_type
//                detailCell?.passingData.Value = JsonData.discount_type.capitalizingFirstLetter()
//                detailCell?.btnDiscountType.setTitle(JsonData.discount_type.capitalizingFirstLetter(), for: .normal)
//                JsonData.DiscountTypeVal = ""
//                detailCell?.discountTypeCheck.Inputchecked()
//            }
//            
//            if indexPath.row == 1 && JsonData.DiscountVal != ""
//            {
//                detailCell?.passingData.ID = JsonData.discount
//                detailCell?.passingData.Value = JsonData.discount
//                detailCell?.txtDiscount.text = JsonData.discount
//                detailCell?.discountCheck.Inputchecked()
//                JsonData.DiscountVal = ""
//            }
//        }
//        
//        detailCell?.passingData.IndexPathKey = NSIndexPath(row: indexPath.row, section: indexPath.section)
//        detailCell?.setValueDelegate = self
//        return detailCell ?? UITableViewCell()
//    case .contact:
//        var detailCell = tableView.dequeueReusableCell(withIdentifier: type.Content[indexPath.row] as! String) as? ContactInputTableViewCell
//        if detailCell == nil {
//            let nib = Bundle.main.loadNibNamed("ContactInputTableViewCell", owner: self, options: nil)
//            detailCell = nib?[indexPath.row] as? ContactInputTableViewCell
//        }
//        
//        if isBeingEdit
//        {
//            if indexPath.row == 0 && JsonData.NameVal != ""
//            {
//                detailCell?.passingData.ID = JsonData.name
//                detailCell?.passingData.Value = JsonData.name
//                detailCell?.txtName.text = JsonData.NameVal
//                JsonData.NameVal = ""
//            }
//            if indexPath.row == 1 && JsonData.PhoneNumberVal != ""
//            {
//                detailCell?.passingData.ID = JsonData.contact_phone
//                detailCell?.passingData.Value = JsonData.contact_phone
//                detailCell?.txtPhoneNumber.text = JsonData.contact_phone
//                JsonData.PhoneNumberVal = ""
//            }
//            if indexPath.row == 2 && JsonData.EmailVal != ""
//            {
//                detailCell?.passingData.ID = JsonData.contact_email
//                detailCell?.passingData.Value = JsonData.contact_email
//                detailCell?.txtEmail.text = JsonData.contact_email
//                JsonData.EmailVal = ""
//            }
//            if indexPath.row == 3 && JsonData.AddressVal != ""
//            {
//                detailCell?.passingData.ID = JsonData.contact_address
//                detailCell?.passingData.Value = JsonData.contact_address
//                detailCell?.txtAddress.text = JsonData.contact_address
//                JsonData.AddressVal = ""
//            }
//
//        }
//        
//        detailCell?.passingData.IndexPathKey = NSIndexPath(row: indexPath.row, section: indexPath.section)
//        detailCell?.setValueDelegate = self
//        return detailCell ?? UITableViewCell()
//        
//    }
//}
//
//}
//
//extension PostAdViewController: getValueFromXibDetail {
//    func getTitle(value: CellClickViewModel) {
//        self.JsonData.title = value.ID
//    }
//    
//    func getPostType(value: CellClickViewModel) {
//        self.JsonData.post_type = value.ID
//        if value.ID == "buy" {
//            isHideDiscount = true
//        }
//        else {
//            isHideDiscount = false
//        }
//        tableview.reloadData()
//    }
//    
//    func getCategory(value: CellClickViewModel) {
//        self.JsonData.category = value.ID.toInt()
//        if value.ID == "2" {
//            isHideType = true
//        }
//        else {
//            isHideType = false
//        }
//        tableview.reloadData()
//    }
//    
//    func getType(value: CellClickViewModel) {
//        self.JsonData.type = value.ID.toInt()
//    }
//    
//    func getBrand(value: CellClickViewModel) {
//        self.JsonData.brand = value.ID.toInt()
//        self.getDropDownTypeDelegate?.getDropDownTypeData(type: value.ID)
//    }
//    
//    func getModel(value: CellClickViewModel) {
//        self.JsonData.modeling = value.ID.toInt()
//    }
//    
//    func getYear(value: CellClickViewModel) {
//        self.JsonData.year = value.ID.toInt()
//    }
//    
//    func getCondition(value: CellClickViewModel) {
//        self.JsonData.condition = value.ID
//    }
//    
//    func getColor(value: CellClickViewModel) {
//        self.JsonData.color = value.ID
//    }
//    
//    func getVinCode(value: CellClickViewModel) {
//        self.JsonData.vin_code = value.ID
//    }
//    
//    func getMachinecode(value: CellClickViewModel) {
//        self.JsonData.machine_code = value.ID
//    }
//    
//    func getDescription(value: CellClickViewModel) {
//        self.JsonData.description = value.ID
//    }
//    
//    func getPrice(value: CellClickViewModel) {
//        self.JsonData.cost = value.ID
//    }
//}
//
//extension PostAdViewController: getValueFromXibDiscount {
//    func getDiscountType(value: CellClickViewModel) {
//        self.JsonData.discount_type = value.ID
//    }
//    
//    func getDiscount(value: CellClickViewModel) {
//        self.JsonData.discount = value.ID
//    }
//}
//
//extension PostAdViewController: getValueFromXibContact {
//    func getName(value: CellClickViewModel) {
//        print(value.ID)
//    }
//    
//    func getPhoneNumber(value: CellClickViewModel) {
//        self.JsonData.contact_phone = value.ID
//    }
//    
//    func getEmail(value: CellClickViewModel) {
//        self.JsonData.contact_email = value.ID
//    }
//    
//    func getAddress(value: CellClickViewModel) {
//        self.JsonData.contact_address = value.ID
//    }
//}
//
//extension PostAdViewController: getValueFromXibPhoto {
//    func getPhoto(Photos: [imageWithPLAsset]) {
//        performOn(.Background) {
//            Photos[0].PLAsset?.cloudImageDownload(progressBlock: { (pro) in
//                
//            }, completionBlock: { (img) in
//                self.JsonData.front_image_path = img?.toBase64()
//                self.JsonData.front_image_base64 = self.JsonData.front_image_path
//            })
//            
//            Photos[1].PLAsset?.cloudImageDownload(progressBlock: { (pro) in
//                
//            }, completionBlock: { (img) in
//                self.JsonData.left_image_path = img?.toBase64()
//                self.JsonData.left_image_base64 = self.JsonData.left_image_path
//            })
//            
//            Photos[2].PLAsset?.cloudImageDownload(progressBlock: { (pro) in
//                
//            }, completionBlock: { (img) in
//                self.JsonData.right_image_path = img?.toBase64()
//                self.JsonData.right_image_base64 = self.JsonData.right_image_path
//            })
//            
//            Photos[3].PLAsset?.cloudImageDownload(progressBlock: { (pro) in
//                
//            }, completionBlock: { (img) in
//                self.JsonData.back_image_path = img?.toBase64()
//                self.JsonData.back_image_base64 = self.JsonData.back_image_path
//            })
//        }
//    }
//}
