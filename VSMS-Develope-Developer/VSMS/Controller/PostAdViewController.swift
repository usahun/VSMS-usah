//
//  PostAdViewController.swift
//  VSMS
//
//  Created by Vuthy Tep on 4/29/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import GoogleMaps

struct postImageModel {
    let image:  UIImage
}

class Phone {
    var numbers: [String]? = []
}

enum Section {
    
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
           return ["Title","Choose Type","Tax Type","Brand","Year","Condition","Cost","Price","Description"]
           
        case .discount:
            return ["Discount Type","Discount Amount"]
        case .contact:
            return ["Name"]
        case .phone:
            return ["Phone 1", "Phone 2", "Phone 3"]
        }
    }
}




class PostAdViewController: UIViewController, UITableViewDataSource, UITabBarDelegate,UITextFieldDelegate , UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView?
    
    var phone: Phone = Phone()
    
    var postImages: Array<postImageModel> = []
    
    let picker = UIImagePickerController()
    
    var tempImage: UIImage?
    
    var currentIndex: Int = 0
    
    
    var allTypes: [Section] = []
    
    var isHideButtonOfSection = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //google map
//        GMSServices.provideAPIKey("AIzaSyChN5VYq3X6RKvoFeIRfz0WNmC31FrZ0wg")
//        let camera = GMSCameraPosition.camera(withLatitude:11.568653 , longitude: 104.870329, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
//        self.view = mapView
        
        
        // address LSI
       // 11.568653; 104.870329
       // let camera = GMSCameraPosition.camera(withLatitude: 11.568653, longitude: 104.870329, zoom: 10)
        //all section in tableview
        self.allTypes = [Section.photosProduct,
                         Section.detail,
                         Section.discount,
                         Section.contact,
                         Section.phone(phone: self.phone)]
        
        tableview.delegate = self
        tableview.dataSource = self
 
        
        // register nib intaleview
        let cellNib = UINib(nibName: "DeTailTableCell", bundle: nil)
        tableview?.register(cellNib, forCellReuseIdentifier: "detailCell")
        tableview.keyboardDismissMode = .onDrag
        
        
        let cellcollection = UINib(nibName: "CollectionTableViewCell", bundle: nil)
       tableview?.register(cellcollection, forCellReuseIdentifier: "photocollection")
    
        
        
        let cellData = UINib(nibName: "PassDataCell", bundle: nil)
        tableview?.register(cellData, forCellReuseIdentifier: "dataCell")
        let cellphone = UINib(nibName: "PhoneNumberHeader", bundle: nil)
        tableview?.register(cellphone, forHeaderFooterViewReuseIdentifier: "headerView")
        let celladdnewnumber = UINib(nibName: "AddmoreNumberPhoneTableViewCell", bundle: nil)
        tableview?.register(celladdnewnumber, forCellReuseIdentifier: "AddmoreNumberPhoneTableViewCell")
      
        let cellFooter = UINib(nibName: "MapTableViewHeaderFooterView", bundle: nil)
        tableview?.register(cellFooter, forHeaderFooterViewReuseIdentifier: "MapTableViewHeaderFooterView")
        //collectionview
        setupView()
        
        for _ in 0...6 {
            self.postImages.append(postImageModel(image: UIImage(named: "icons8-plus-math-50 (5)")!))
        }
    }
    //fucntion
    
    fileprivate func setupView() {
        
        
        picker.delegate = self
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sec = allTypes[indexPath.section]
        switch sec {
        case .photosProduct:
            return 95
        case .detail:
            if indexPath.row == 8{
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      
      let sec = allTypes[section]
      return sec.rowCount
        
//        var rows: Int!
//        switch section {
//        case 0:
//            rows = item1.count
//            break
//        case 1:
//            rows = item2.count
//            break
//        case 2:
//            rows = item3.count
//            break
//        default:
//            break
//        }
//        return rows
       // return items[section].count
       // return 8
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 4 {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MapTableViewHeaderFooterView") as? MapTableViewHeaderFooterView
            footerView?.contentView.backgroundColor = .white
            return footerView
        }
        return nil
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        
        let type = allTypes[section]
        
        if section == 0 {
//            let collection = tableView.dequeueReusableHeaderFooterView(withIdentifier: "photocollection") as! CollectionTableViewCell
//            collection.postImagecollectionview.dataSource = self
//            collection.postImagecollectionview.delegate = self
            return nil
//            let cellcollection = tableView.dequeueReusableHeaderFooterView(withIdentifier: "photocollection") as? CollectionTableViewCell
//            return cellcollection
            
            //add new phone number
            
        }else if section == 4 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as? PhoneNumberHeader
            headerView?.contentView.backgroundColor = UIColor.white;
            headerView?.addingButton?.isHidden = self.isHideButtonOfSection
            headerView?.titleLabel?.text = "Phone 1"
            headerView?.addingTapComplietion = {
                self.phone.numbers?.append("Okay")
                
                if self.phone.numbers?.count != 0
                {
                    self.isHideButtonOfSection = true
                    headerView?.addingButton?.isHidden = self.isHideButtonOfSection
                    headerView?.titleLabel?.text = "kkk"
                }
                else
                {
                    self.isHideButtonOfSection = false
                    headerView?.titleLabel?.text = "nono"
                    //headerView?.addingButton?.isHidden = self.isHideButtonOfSection
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
    
//    if indexPath.section == 0 {
    
    let type = allTypes[indexPath.section]
    
    switch type {
    
    case .photosProduct:
        let cell = tableView.dequeueReusableCell(withIdentifier: "photocollection")as! CollectionTableViewCell
        cell.postImagecollectionview.delegate = self
        cell.postImagecollectionview.dataSource = self
        return cell
        
    case .detail:
        let cell = tableview.dequeueReusableCell(withIdentifier: "dataCell") as! PassDataTableViewCell
        //cell.titlelabel.text = Sections(rawValue: indexPath.section)?.Content[indexPath.row] as? String
        if indexPath.row == 1 ||
                    indexPath.row == 2 ||
                    indexPath.row == 3 ||
                    indexPath.row == 4 ||
                    indexPath.row == 5 {
                    cell.accessoryType = .disclosureIndicator
                } else {
                    cell.accessoryType = .none
                }
        let sec = allTypes[indexPath.section]
        cell.titleLabel.text = sec.Content[indexPath.row] as? String
        
        
        return cell
        
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
    case .phone(let phone):
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
        //cell.titlelabel.text = Sections(rawValue: indexPath.section)?.Content[indexPath.row] as? String
   // case .footer:
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewHeaderFooterView") as? MapTableViewHeaderFooterView
//        return cell

    
    }
    
    
        
//        if indexPath.row == 1 ||
//            indexPath.row == 2 ||
//            indexPath.row == 3 ||
//            indexPath.row == 4 ||
//            indexPath.row == 5 {
//            cell.accessoryType = .disclosureIndicator
//        } else {
//            cell.accessoryType = .none
//        }
    
        //return cell
//    }else if indexPath.section == 2 {
//        let cell =
//        let cell = tableview.dequeueReusableCell(withIdentifier: "dataCell") as!
//        PassDataTableViewCell
//        cell.titleLabel.text = Sections(rawValue: indexPath.section)?.Content[indexPath.row] as? String
//         cell.accessoryType = .none
//    return cell
//    }
   
    
//    let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for:    indexPath) as! DeTailTableCell
//    let sec = Sections(rawValue: indexPath.section)
//    cell.titlelabel.text = sec!.Content[indexPath.row] as? String
//    cell.titlelabel.numberOfLines = 0
//    return cell
    

 //       cell.labelTitle.text = titlelabel[indexPath.row]
//       if indexPath.section == 0 {
//            cell.labelTitle.text = titlelabel[indexPath.row]
//        }
//        else{
//            cell.labelTitle.text = titlelabel1[indexPath.row]
//        }
//       //cell.textLabel?.text = items[indexPath.section][indexPath.row]
//
    
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableview.dequeueReusableCell(withIdentifier: "cell")
//        if cell == nil{
//            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//        }
//        cell!.textLabel?.text = tabledata[indexPath.row]
//        return cell!
//    }
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
