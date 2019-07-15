//
//  NewlyTableViewCell.swift
//  VSMS
//
//  Created by usah on 6/18/19.
//  Copyright © 2019 121. All rights reserved.
//
import CollectionViewGridLayout
import UIKit
import Alamofire
import SwiftyJSON


struct CollectionCellProp {
    let itemShow: CGFloat
    let heigthofTableCell: CGFloat
}

class NewlyTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
  
    //Storyboard Properties
    @IBOutlet weak var NewlyPost: UICollectionView!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var btnGrid: UIButton!
    @IBOutlet weak var btnImage: UIButton!
    
    var postPro: [HomePageModel] = []
    var recordCount: Int = 0
    var collectionHeight: CGFloat = 125
    weak var delegate: RecordCountProtocol?
    
    //Internal Properties
    var cellHeightCount: CGFloat = 0
    var collectionViewFlolayout: UICollectionViewFlowLayout!
    var listType = "list"
    weak var TableToCollectDelegate: CollectionToTableProtocol?
    
    var ListCell: CGFloat = 125
    var GridCell: CGFloat = 250
    var ImgCell: CGFloat = 350
    
    func API() {
        
        Alamofire.request(PROJECT_API.HOMEPAGE, method: .get,encoding: JSONEncoding.default).responseJSON
            { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.postPro = (json["results"].array?.map{
                        HomePageModel(id: $0["id"].stringValue.toInt(), name: $0["title"].stringValue,cost: $0["cost"].stringValue,imagefront: $0["front_image_base64"].stringValue)
                        }) ?? []
                    self.recordCount = self.postPro.count
                    self.delegate?.getHeighOfCollectionView(recordCount: (CGFloat(self.recordCount) * self.collectionHeight) + CGFloat(self.recordCount * 16) - self.minusByRecord())
                    self.NewlyPost.reloadData()
                case .failure:
                    print("error")
                }
        }
    }
    
    func minusByRecord() -> CGFloat {
        if recordCount == 0 {
            return 0
        }
        else if recordCount == 1 {
            return 8
        }
        else {
            return 16
        }
    }
    
    //Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 90, height: 90)
       // layout.scrollDirection = .horizontal
        NewlyPost.collectionViewLayout = layout
        self.NewlyPost.delegate = self
        self.NewlyPost.dataSource = self
        
        //Call function
        registerXibFile()
        configBtnHandler()
        
        API()
    
    }
    
    //Custom function
    func configBtnHandler(){
        btnList.addTarget(self, action: #selector(btnListClick), for: .touchUpInside)
        btnGrid.addTarget(self, action: #selector(btnGridClick), for: .touchUpInside)
        btnImage.addTarget(self, action: #selector(btnImageClick), for: .touchUpInside)
    }
    
    func registerXibFile(){
        let cellimage = UINib(nibName: "GreditImageCollectionViewCell", bundle: nil)
        NewlyPost.register(cellimage, forCellWithReuseIdentifier: "greditImage")
        
        let NewPostListCell = UINib(nibName: "NewPostListCollectionViewCell", bundle: nil)
        NewlyPost.register(NewPostListCell, forCellWithReuseIdentifier: "NewPostCollectionCell_ID")
        
        let NewPostGridCell = UINib(nibName: "NewPostGridCollectionViewCell", bundle: nil)
        NewlyPost.register(NewPostGridCell, forCellWithReuseIdentifier: "NewPostGridCollectionCell_ID")
        
        let NewPostImageCell = UINib(nibName: "NewPostImageCollectionViewCell", bundle: nil)
        NewlyPost.register(NewPostImageCell, forCellWithReuseIdentifier: "NewPostImageCollectionCell_ID")
    }
    
    func updateBtnDisplay(btnActive: UIButton){
        var XHeight: CGFloat = CGFloat((self.recordCount * 16) - 12)
        if XHeight < 0 {
            XHeight = 0
        }
        switch btnActive{
        case btnList :
            self.collectionHeight = ListCell
            self.delegate?.getHeighOfCollectionView(recordCount: CGFloat(self.recordCount) * self.collectionHeight + XHeight)
            btnList.setImage(UIImage(named:"list_active"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail"), for: .normal)
            btnImage.setImage(UIImage(named:"img"), for: .normal)
            break
        case btnGrid:
            self.collectionHeight = GridCell
            self.delegate?.getHeighOfCollectionView(recordCount: CGFloat(self.recordCount / 2) * self.collectionHeight + XHeight)
            btnList.setImage(UIImage(named:"list"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail_active"), for: .normal)
            btnImage.setImage(UIImage(named:"img"), for: .normal)
            break
        case btnImage:
            self.collectionHeight = ImgCell
            self.delegate?.getHeighOfCollectionView(recordCount: CGFloat(self.recordCount) * self.collectionHeight + XHeight)
            btnList.setImage(UIImage(named:"list"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail"), for: .normal)
            btnImage.setImage(UIImage(named:"img_active"), for: .normal)
            break
        default:
            self.collectionHeight = ListCell
            self.delegate?.getHeighOfCollectionView(recordCount: CGFloat(self.recordCount) * self.collectionHeight + XHeight)
            btnList.setImage(UIImage(named:"list_active"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail"), for: .normal)
            btnImage.setImage(UIImage(named:"image"), for: .normal)
        }
    }
    
    func getCellByListType(collection: UICollectionView, index: IndexPath) -> UICollectionViewCell{
       //  let data = TemporaryData(rawValue: index.row)
        switch listType{
        case "list":
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "NewPostCollectionCell_ID", for: index) as! NewPostListCollectionViewCell
            cell.proID = postPro[index.row].product
            cell.Img.image = postPro[index.row].imagefront.base64ToImage()
            cell.lblProductName.text = postPro[index.row].title
            cell.lblProductPrice.text = "$\(postPro[index.row].cost)"
            cell.delgate = self
            return cell
        case "grid":
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "NewPostGridCollectionCell_ID", for: index) as! NewPostGridCollectionViewCell
            cell.proID = postPro[index.row].product
            cell.img.image = postPro[index.row].imagefront.base64ToImage()
            cell.lblProductName.text = postPro[index.row].title
            cell.lblPrice.text = "$\(postPro[index.row].cost)"
            cell.delgate = self
            return cell
        case "img":
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "NewPostImageCollectionCell_ID", for: index) as! NewPostImageCollectionViewCell
            cell.proID = postPro[index.row].product
            cell.Image.image = postPro[index.row].imagefront.base64ToImage()
            cell.LblName.text = postPro[index.row].title
            cell.lblPrice.text = "$\(postPro[index.row].cost)"
            cell.delgate = self
            return cell
        default:
            return collection.dequeueReusableCell(withReuseIdentifier: "NewPostCollectionCell_ID", for: index) as! NewPostListCollectionViewCell
        }
    }
    
    func CellHeight(collectionHeight: CGFloat) -> CGFloat{
        switch listType{
        case "list": return 125 //collectionHeight / 8 - 4
        case "grid": return 250 //collectionHeight / 4 - 4
        case "img": return 350
        default:
            return 0
        }
    }
    
    func CellWeight(collectionWidth: CGFloat) -> CGFloat{
        switch listType{
        case "list": return collectionWidth
        case "grid": return collectionWidth / 2 - 4
        case "img": return collectionWidth
        default:
            return 0
        }
    }
    
    //Selector function
    
    @objc func btnListClick(){
        updateBtnDisplay(btnActive: self.btnList)
        listType = "list"
        NewlyPost.reloadData()
    }
    
    @objc func btnGridClick(){
        updateBtnDisplay(btnActive: self.btnGrid)
        listType = "grid"
        NewlyPost.reloadData()
    }
    
    @objc func btnImageClick(){
        updateBtnDisplay(btnActive: self.btnImage)
        listType = "img"
        NewlyPost.reloadData()
    }
    
    
    //Overide Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postPro.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = getCellByListType(collection: collectionView, index: indexPath)
        return cell
    }
    
}


extension NewlyTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let collectionWidth = collectionView.bounds.width
       let collectionHeight = collectionView.bounds.height
       return CGSize(width: CellWeight(collectionWidth: collectionWidth), height: CellHeight(collectionHeight: collectionHeight))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension NewlyTableViewCell: InitailViewControllerProtocol {
    func pushNewViewController(ID: Int) {
        self.TableToCollectDelegate?.getFromCollectionCell(ProID: ID)
    }
}


