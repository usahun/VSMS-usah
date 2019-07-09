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
    let image:  UIImage
}

class Phone {
    var numbers: [String]? = []
}

enum SectionEnum {
    
    case photosProduct
    case detail
    case discount
    case contact
    case phone(phone: Phone)

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
        case .phone:
            return "Phone 1"
        }
    }
    
    var rowCount: Int {
        switch self {
        case .phone(let phone):
            return phone.numbers?.count ?? 0
        default:
            return self.Content.count
        }
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
            return ["Discount Type","Discount Amount"]
        case .contact:
            return ["Name"]
        case .phone:
            return ["Phone 1", "Phone 2", "Phone 3"]
        }
    }
}

class PostAdViewController: UIViewController, UITableViewDataSource, UITabBarDelegate,UITextFieldDelegate , UITableViewDelegate, CellTableClick {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView?
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allTypes = [SectionEnum.photosProduct,
                         SectionEnum.detail,
                         SectionEnum.discount,
                         SectionEnum.contact,
                         SectionEnum.phone(phone: self.phone)]
        
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
        
        setupView()
        
        for _ in 0...3 {
            self.postImages.append(postImageModel(image: UIImage(named: "icons8-plus-math-50 (5)")!))
        }
    }
    
    //DelegateMethod
    func SubmitClick() {
        JsonData.sale_post = [SalePostData.asDictionary]
        
        let headers: HTTPHeaders = [
            "Cookie": "",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization" : User.getUserEncoded(),
        ]
        
//        let imagePost = #imageLiteral(resourceName: <#T##String#>)
//        let keys = JsonData.asDictionary.keys
//        let values = JsonData.asDictionary.values
//        
//        
//        Alamofire.upload(
//            multipartFormData: { MultipartFormData in
//                
//                for (key, value) in self.JsonData.asDictionary {
//                    MultipartFormData.append((value as AnyObject), withName: key)
//                }
//    
//                MultipartFormData.append(imagePost.jpegData(compressionQuality: 1)!, withName: "front_image_path", fileName: "Rathana", mimeType: "image/png")
//        }, to: PROJECT_API.POST_SELL) { (result) in
//            
//            switch result {
//            case .success(let upload, _, _):
//                
//                upload.responseJSON { response in
//                    print(response.result.value)
//                }
//                
//            case .failure(let encodingError): break
//            print(encodingError)
//            }
//            
//            
//        }
        
        
        Alamofire.request(PROJECT_API.POST_SELL,
                          method: .post,
                          parameters: JsonData.asDictionary,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON { response in
                        switch response.result{
                        case .success (let value):
                            print(value)
                            let AlertMessage = UIAlertController(title: "Successfully",
                                                                 message: "Post created succssfully.",
                                                                 preferredStyle: .alert)
                            AlertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(AlertMessage, animated: true, completion: nil)
                        case .failure(let error):
                            
                            print(error)
                        }
                    }
    }
    
    func ClickCell(currentCell: CellClickViewModel) {
        getValueFromDetailSectionByRowIndex(passedData: currentCell)
        if currentCell.IndexPathKey?.row == 4 {
            self.refreshXibDelegate?.refreshXib(FKKey: currentCell.ID.toInt())
        }
    }
    
    //fucntion
    func getValueFromDetailSectionByRowIndex(passedData: CellClickViewModel){
        
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
            
            SalePostData.price = passedData.ID
            SalePostData.total_price = passedData.ID
        default:
            print("default")
        }
    }
    
    
    fileprivate func setupView() {
        picker.delegate = self
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sec = allTypes[indexPath.section]
        switch sec {
        case .photosProduct:
            return 95
        case .detail:
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      
      let sec = allTypes[section]
      return sec.rowCount
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 4 {
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
        } else if section == 4 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as? PhoneNumberHeader
            headerView?.contentView.backgroundColor = UIColor.white;
            headerView?.addingButton?.isHidden = self.isHideButtonOfSection
            headerView?.titleLabel?.text = "Phone 1"
            
            headerView?.addingTapComplietion = {
                self.phone.numbers?.append("Okay")
                
                if self.phone.numbers?.count != 0 {
                    self.isHideButtonOfSection = true
                    headerView?.addingButton?.isHidden = self.isHideButtonOfSection
                    headerView?.titleLabel?.text = "kkk"
                } else {
                    self.isHideButtonOfSection = false
                    headerView?.titleLabel?.text = "none"
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
        if section == 4 {
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
        let cell = tableview.dequeueReusableCell(withIdentifier: "detailCell") as! DeTailTableCell
        let sec = allTypes[indexPath.section]
        cell.titlelabel.text = sec.Content[indexPath.row] as? String
        return cell
        //cell.titlelabel.text = Sections(rawValue: indexPath.section)?.Content[indexPath.row] as? String
    case .contact:
        let cell = tableview.dequeueReusableCell(withIdentifier: "detailCell") as! DeTailTableCell
        let sec = allTypes[indexPath.section]
        cell.titlelabel.text = sec.Content[indexPath.row] as? String
        return cell
        //cell.titlelabel.text = Sections(rawValue: indexPath.section)?.Content[indexPath.row] as? String
    case .phone:
        let cell = tableview.dequeueReusableCell(withIdentifier: "AddmoreNumberPhoneTableViewCell") as! AddmoreNumberPhoneTableViewCell
        
        cell.addingbutton?.isHidden = false
        if indexPath.row != self.phone.numbers!.count - 1 {
            cell.addingbutton?.isHidden = true
        }
        
        if self.phone.numbers?.count == 2 {
            cell.addingbutton?.isHidden = true
        }
        
        
        cell.addingTapComplietion = {
            self.phone.numbers?.append("Okay")
            let indexSet = IndexSet(integer: indexPath.section)
            tableView.reloadSections(indexSet, with: .automatic)
        }
        
        if indexPath.row == 0 {
            cell.titleLabel?.text = "Phone 2"
        }
        else if indexPath.row == 1 {
            cell.titleLabel?.text = "Phone 3"
        }
        
        return cell
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
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        self.currentIndex = indexPath.row
        
        let alertController = UIAlertController(title: "Allbume", message: "Please Select Photos", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { (alert) in
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        }
        
        let photoAlbumAction = UIAlertAction(title: "Album", style: .default) { (alert) in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoAlbumAction)
        
        //_ = UIStoryboard.init(name: "Main", bundle: nil)
        //= storyBoard.instantiateViewController(withIdentifier: "testVC") as? TestViewController
        //let navigationController = UINavigationController(rootViewController: VC!)
        //present(VC!    , animated: true, completion: nil)
        
        
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
                self.postImages[self.currentIndex] = postImageModel(image: selectedImage)
                self.collectionView?.reloadData()
            }
            
        }
        
        
    }
}


extension String {
    func toInt() -> Int {
        return Int(self) ?? 0
    }
}

