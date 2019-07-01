//
//  NewlyTableViewCell.swift
//  VSMS
//
//  Created by usah on 6/18/19.
//  Copyright © 2019 121. All rights reserved.
//
import CollectionViewGridLayout
import UIKit

enum TemporaryData: Int, CustomStringConvertible {
    case HondaClick2019
    case HondayScoopy2019
    case HondaDream2019
    case Kawasaki2019
    case Suzuki2019
    case HondaPCX2019
    case HondaZoomerX2019
    case SuzukiNex2019
    case SuzukiSmash2019
    case HondaWave2019
    
    var description: String{
        switch self{
        case .HondaClick2019:
            return "Honda Click 2019"
        case .HondayScoopy2019:
            return "Honda Scoopy 2019"
        case .HondaDream2019:
            return "Honda Dream 2019"
        case .Kawasaki2019:
            return "Kawasaki 2019"
        case .Suzuki2019:
            return "Suzuki 2019"
        case .HondaPCX2019:
            return "Honda PCX 2019"
        case .HondaZoomerX2019:
            return "Honda Zoomer X 2019"
        case .SuzukiNex2019:
            return "Suzuki Nex 2019"
        case .SuzukiSmash2019:
            return "Suzuki Smash 2019"
        case .HondaWave2019:
            return "Honda Wave 2019"
        }
    }
    
    var Image: UIImage{
        switch self{
        case .HondaClick2019:
            return UIImage(named: "HondaClick2019") ?? UIImage()
        case .HondayScoopy2019:
            return UIImage(named: "HondaScoopy2019") ?? UIImage()
        case .HondaDream2019:
            return UIImage(named: "HondaDream2019") ?? UIImage()
        case .Kawasaki2019:
            return UIImage(named: "Kawasaki2019") ?? UIImage()
        case .Suzuki2019:
            return UIImage(named: "SuzukiSmash2019") ?? UIImage()
        case .HondaPCX2019:
            return UIImage(named: "HondaPCX2019") ?? UIImage()
        case .HondaZoomerX2019:
            return UIImage(named: "HondaZoomerX2019") ?? UIImage()
        case .SuzukiNex2019:
            return UIImage(named: "SuzukiNex2019") ?? UIImage()
        case .SuzukiSmash2019:
            return UIImage(named: "SuzukiSmash2019") ?? UIImage()
        case .HondaWave2019:
            return UIImage(named: "HondaWave2019") ?? UIImage()
        }
    }
    
    var Price: Double {
        switch self{
        case .HondaClick2019:
            return 1800
        case .HondayScoopy2019:
            return 1900
        case .HondaDream2019:
            return 1750
        case .Kawasaki2019:
            return 3200
        case .Suzuki2019:
            return 1600
        case .HondaPCX2019:
            return 2100
        case .HondaZoomerX2019:
            return 1800
        case .SuzukiNex2019:
            return 1600
        case .SuzukiSmash2019:
            return 1500
        case .HondaWave2019:
            return 1100
        }
    }
}

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
    
    
    //Internal Properties
    var cellHeightCount: CGFloat = 0
    var collectionViewFlolayout: UICollectionViewFlowLayout!
    var listType = "list"
    
    
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
        print(btnActive.accessibilityLabel ?? "")
        
        switch btnActive{
        case btnList :
            btnList.setImage(UIImage(named:"list_active"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail"), for: .normal)
            btnImage.setImage(UIImage(named:"img"), for: .normal)
            break
        case btnGrid:
            btnList.setImage(UIImage(named:"list"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail_active"), for: .normal)
            btnImage.setImage(UIImage(named:"img"), for: .normal)
            break
        case btnImage:
            btnList.setImage(UIImage(named:"list"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail"), for: .normal)
            btnImage.setImage(UIImage(named:"img_active"), for: .normal)
            break
        default:
            btnList.setImage(UIImage(named:"list_active"), for: .normal)
            btnGrid.setImage(UIImage(named:"thumnail"), for: .normal)
            btnImage.setImage(UIImage(named:"image"), for: .normal)
        }
    }
    
    func getCellByListType(collection: UICollectionView, index: IndexPath) -> UICollectionViewCell{
         let data = TemporaryData(rawValue: index.row)
        switch listType{
        case "list":
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "NewPostCollectionCell_ID", for: index) as! NewPostListCollectionViewCell
            cell.Img.image = data?.Image ?? UIImage()
            cell.lblProductName.text = data?.description
            cell.lblProductPrice.text = "\(data?.Price ?? 0)"
            cell.lblOldPrice.text = "$\(data?.Price ?? 0 - 200)"
            return cell
        case "grid":
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "NewPostGridCollectionCell_ID", for: index) as! NewPostGridCollectionViewCell
            cell.img.image = data?.Image ?? UIImage()
            cell.lblProductName.text = data?.description
            cell.lblPrice.text = "$\(data?.Price ?? 0)"
            cell.lblOldPrice.text = "$\((data?.Price ?? 0) - 200)"
            return cell
        case "img":
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "NewPostImageCollectionCell_ID", for: index) as! NewPostImageCollectionViewCell
            cell.Image.image = data?.Image
            return cell
        default:
            return collection.dequeueReusableCell(withReuseIdentifier: "NewPostCollectionCell_ID", for: index) as! NewPostListCollectionViewCell
        }
    }
    
    func CellHeight(collectionHeight: CGFloat) -> CGFloat{
        switch listType{
        case "list": return collectionHeight / 8 - 4
        case "grid": return collectionHeight / 4 - 4
        case "img": return collectionHeight / 4
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

        // Configure the view for the selected state
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
